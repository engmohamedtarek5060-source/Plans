#!/usr/bin/env python3
"""App Store Connect API client for the TestFlight pipeline.

altool can upload a build and nothing else. Everything after the upload --
waiting for processing, assigning the build to a tester group, writing the
"What to Test" notes, and reading expiration dates -- is only reachable
through the App Store Connect REST API, which is what this script wraps.

Auth is the same .p8 key the upload uses, so no extra credential is needed.

Subcommands:
  next-build-number  Highest build number for a version, plus one.
  wait-processing    Block until a build leaves PROCESSING; print its id.
  release            Assign a build to a group, set notes, add testers.
  check-expiry       Report builds nearing the 90-day TestFlight expiry.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timedelta, timezone

import jwt

API = "https://api.appstoreconnect.apple.com/v1"

# TestFlight expires a build 90 days after upload. Apple does not publish this
# as a per-build field on upload, only as `expirationDate` once processed.
TESTFLIGHT_LIFETIME_DAYS = 90


class ASCError(RuntimeError):
    """An App Store Connect request failed in a way retrying will not fix."""


def _env(name: str) -> str:
    """Read a required secret, failing with a message that names the fix."""
    value = os.environ.get(name)
    if not value:
        raise ASCError(
            f"{name} is not set. Add it as a repository secret -- see docs/IOS_RELEASE.md."
        )
    return value


def _token() -> str:
    """Mint a short-lived ES256 JWT. Apple rejects anything over 20 minutes."""
    key_id = _env("ASC_KEY_ID")
    issuer_id = _env("ASC_ISSUER_ID")
    key_path = os.path.expanduser(f"~/private_keys/AuthKey_{key_id}.p8")

    try:
        with open(key_path, "r", encoding="utf-8") as handle:
            private_key = handle.read()
    except OSError as error:
        raise ASCError(
            f"Cannot read {key_path}: {error}. The 'Install App Store Connect "
            f"API key' step must run before this one."
        ) from error

    now = int(time.time())
    return jwt.encode(
        {"iss": issuer_id, "iat": now, "exp": now + 900, "aud": "appstoreconnect-v1"},
        private_key,
        algorithm="ES256",
        headers={"kid": key_id, "typ": "JWT"},
    )


def request(method: str, path: str, body: dict | None = None, *, attempts: int = 5) -> dict:
    """Call the API, retrying only what a retry can actually fix.

    429 and 5xx are transient; 4xx means the request itself is wrong and
    retrying would just burn the runner's minutes on the same error.
    """
    url = path if path.startswith("http") else f"{API}{path}"
    payload = json.dumps(body).encode() if body is not None else None

    for attempt in range(1, attempts + 1):
        req = urllib.request.Request(url, data=payload, method=method)
        req.add_header("Authorization", f"Bearer {_token()}")
        req.add_header("Content-Type", "application/json")

        try:
            with urllib.request.urlopen(req, timeout=60) as response:
                raw = response.read()
                return json.loads(raw) if raw else {}
        except urllib.error.HTTPError as error:
            detail = error.read().decode(errors="replace")
            if error.code in (429, 500, 502, 503, 504) and attempt < attempts:
                delay = min(2**attempt, 30)
                print(
                    f"  {method} {url} -> {error.code}; retry {attempt}/{attempts - 1} in {delay}s",
                    file=sys.stderr,
                )
                time.sleep(delay)
                continue
            raise ASCError(f"{method} {url} -> {error.code}\n{detail}") from error
        except urllib.error.URLError as error:
            if attempt < attempts:
                delay = min(2**attempt, 30)
                print(f"  {method} {url} network error; retry in {delay}s", file=sys.stderr)
                time.sleep(delay)
                continue
            raise ASCError(f"{method} {url} failed: {error}") from error

    raise ASCError(f"{method} {url} exhausted {attempts} attempts")


def app_id(bundle_id: str) -> str:
    query = urllib.parse.urlencode({"filter[bundleId]": bundle_id})
    data = request("GET", f"/apps?{query}").get("data", [])
    if not data:
        raise ASCError(
            f"No app found for bundle ID '{bundle_id}'. Register the App ID and "
            f"create the app record in App Store Connect before running this."
        )
    return data[0]["id"]


def builds_for_version(app: str, version: str) -> list[dict]:
    query = urllib.parse.urlencode(
        {
            "filter[app]": app,
            "filter[preReleaseVersion.version]": version,
            "limit": 200,
        }
    )
    return request("GET", f"/builds?{query}").get("data", [])


def cmd_next_build_number(args: argparse.Namespace) -> int:
    """Highest existing build number for this version, plus one.

    Deriving this from App Store Connect rather than the CI run number means
    the pipeline stays correct even if a build was uploaded from elsewhere.
    Apple permanently rejects a build number that has already been used for
    the same version string, and that rejection happens after the ~20-minute
    build, so guessing here is expensive.
    """
    builds = builds_for_version(app_id(args.bundle_id), args.version)

    highest = 0
    for build in builds:
        raw = build.get("attributes", {}).get("version")
        try:
            highest = max(highest, int(raw))
        except (TypeError, ValueError):
            # A non-numeric CFBundleVersion (e.g. "1.0.2") can't be compared
            # numerically; skip it rather than crash the build.
            continue

    print(highest + 1)
    return 0


def cmd_wait_processing(args: argparse.Namespace) -> int:
    """Poll until the build leaves PROCESSING.

    A build cannot be assigned to a tester group or given release notes until
    it is VALID, so every later step depends on this one.
    """
    app = app_id(args.bundle_id)
    deadline = time.time() + args.timeout

    while time.time() < deadline:
        for build in builds_for_version(app, args.version):
            attributes = build.get("attributes", {})
            if attributes.get("version") != args.build_number:
                continue

            state = attributes.get("processingState")
            print(f"  build {args.build_number}: {state}")

            if state == "VALID":
                _emit("build_id", build["id"])
                return 0
            if state in ("INVALID", "FAILED"):
                raise ASCError(
                    f"Build {args.build_number} finished processing as {state}. "
                    f"App Store Connect emails the reason to the account holder; "
                    f"common causes are a missing icon size, an invalid entitlement, "
                    f"or an unsupported architecture."
                )
            break
        else:
            print(f"  build {args.build_number} not visible yet")

        time.sleep(args.interval)

    raise ASCError(
        f"Build {args.build_number} still processing after {args.timeout}s. "
        f"It may still succeed -- check App Store Connect before re-running."
    )


def ensure_group(app: str, name: str) -> str:
    """Find the internal tester group by name, creating it if absent."""
    query = urllib.parse.urlencode({"filter[app]": app, "limit": 200})
    for group in request("GET", f"/betaGroups?{query}").get("data", []):
        if group.get("attributes", {}).get("name") == name:
            return group["id"]

    print(f"  creating internal group '{name}'")
    created = request(
        "POST",
        "/betaGroups",
        {
            "data": {
                "type": "betaGroups",
                "attributes": {"name": name, "isInternalGroup": True},
                "relationships": {"app": {"data": {"type": "apps", "id": app}}},
            }
        },
    )
    return created["data"]["id"]


def set_release_notes(build: str, notes: str, locale: str) -> None:
    """Write the "What to Test" text testers see in the TestFlight app.

    A localization already exists if a previous run created one, so a 409 here
    means "update" rather than "create".
    """
    body = {
        "data": {
            "type": "betaBuildLocalizations",
            "attributes": {"locale": locale, "whatsNew": notes},
            "relationships": {"build": {"data": {"type": "builds", "id": build}}},
        }
    }
    try:
        request("POST", "/betaBuildLocalizations", body)
        return
    except ASCError as error:
        if "409" not in str(error):
            raise

    query = urllib.parse.urlencode({"filter[build]": build, "limit": 200})
    for localization in request("GET", f"/betaBuildLocalizations?{query}").get("data", []):
        if localization.get("attributes", {}).get("locale") == locale:
            request(
                "PATCH",
                f"/betaBuildLocalizations/{localization['id']}",
                {
                    "data": {
                        "type": "betaBuildLocalizations",
                        "id": localization["id"],
                        "attributes": {"whatsNew": notes},
                    }
                },
            )
            return

    raise ASCError(f"Could not create or update {locale} release notes for build {build}")


def add_testers(group: str, emails: list[str]) -> None:
    """Add testers to the internal group.

    Internal testers must already hold a role on the App Store Connect team --
    Apple rejects an arbitrary email here. A failure is reported and skipped
    rather than failing the run, because the build itself is already uploaded
    and usable by existing testers.
    """
    for email in emails:
        try:
            request(
                "POST",
                "/betaTesters",
                {
                    "data": {
                        "type": "betaTesters",
                        "attributes": {"email": email},
                        "relationships": {
                            "betaGroups": {"data": [{"type": "betaGroups", "id": group}]}
                        },
                    }
                },
            )
            print(f"  added tester {email}")
        except ASCError as error:
            reason = "already a tester" if "409" in str(error) else str(error).split("\n")[0]
            print(f"  skipped {email}: {reason}")


def cmd_release(args: argparse.Namespace) -> int:
    app = app_id(args.bundle_id)
    group = ensure_group(app, args.group)

    request(
        "POST",
        f"/betaGroups/{group}/relationships/builds",
        {"data": [{"type": "builds", "id": args.build_id}]},
    )
    print(f"  assigned build to '{args.group}'")

    set_release_notes(args.build_id, args.notes, args.locale)
    print(f"  wrote {args.locale} release notes")

    emails = [e.strip() for e in args.testers.split(",") if e.strip()] if args.testers else []
    if emails:
        add_testers(group, emails)

    return 0


def cmd_check_expiry(args: argparse.Namespace) -> int:
    """Report the newest live build's remaining TestFlight lifetime.

    TestFlight expires builds 90 days after upload, at which point testers can
    no longer install. This surfaces that before it happens.
    """
    builds = builds_for_version(app_id(args.bundle_id), args.version)
    now = datetime.now(timezone.utc)

    live: list[tuple[datetime, str]] = []
    for build in builds:
        attributes = build.get("attributes", {})
        if attributes.get("expired"):
            continue

        raw = attributes.get("expirationDate")
        if raw:
            expires = datetime.fromisoformat(raw.replace("Z", "+00:00"))
        elif attributes.get("uploadedDate"):
            uploaded = datetime.fromisoformat(
                attributes["uploadedDate"].replace("Z", "+00:00")
            )
            expires = uploaded + timedelta(days=TESTFLIGHT_LIFETIME_DAYS)
        else:
            continue

        live.append((expires, attributes.get("version", "?")))

    if not live:
        print(f"No live builds for version {args.version}.")
        _emit("status", "none")
        _emit("days_left", "0")
        return 0

    expires, number = max(live)
    days_left = (expires - now).days
    print(f"Newest live build {number} expires {expires.date()} ({days_left} days left).")

    _emit("days_left", str(days_left))
    _emit("build_number", number)
    _emit("status", "warn" if days_left <= args.warn_days else "ok")
    return 0


def _emit(key: str, value: str) -> None:
    """Write to GITHUB_OUTPUT when running under Actions, stdout otherwise."""
    target = os.environ.get("GITHUB_OUTPUT")
    if target:
        with open(target, "a", encoding="utf-8") as handle:
            handle.write(f"{key}={value}\n")
    else:
        print(f"{key}={value}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    nbn = sub.add_parser("next-build-number")
    nbn.add_argument("--bundle-id", required=True)
    nbn.add_argument("--version", required=True)
    nbn.set_defaults(func=cmd_next_build_number)

    wait = sub.add_parser("wait-processing")
    wait.add_argument("--bundle-id", required=True)
    wait.add_argument("--version", required=True)
    wait.add_argument("--build-number", required=True)
    wait.add_argument("--timeout", type=int, default=1800)
    wait.add_argument("--interval", type=int, default=30)
    wait.set_defaults(func=cmd_wait_processing)

    rel = sub.add_parser("release")
    rel.add_argument("--bundle-id", required=True)
    rel.add_argument("--build-id", required=True)
    rel.add_argument("--group", default="Internal Testers")
    rel.add_argument("--notes", required=True)
    rel.add_argument("--locale", default="en-US")
    rel.add_argument("--testers", default="")
    rel.set_defaults(func=cmd_release)

    exp = sub.add_parser("check-expiry")
    exp.add_argument("--bundle-id", required=True)
    exp.add_argument("--version", required=True)
    exp.add_argument("--warn-days", type=int, default=21)
    exp.set_defaults(func=cmd_check_expiry)

    args = parser.parse_args()
    try:
        return args.func(args)
    except ASCError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
