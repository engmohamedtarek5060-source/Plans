# iOS / TestFlight release

Build, signing, upload, and TestFlight distribution run on a GitHub Actions
macOS runner. No Mac is needed locally. After the one-time setup below, a
release is one button click — and the recurring rebuild needs no click at all.

- Bundle ID: `com.plans.app`
- Display name: `Plans`
- Release pipeline: `.github/workflows/ios-testflight.yml`
- Expiry monitor: `.github/workflows/testflight-expiry-check.yml`
- API client: `.github/scripts/asc.py`
- Export options: `ios/ExportOptions.plist`

## What runs automatically

| Stage | Handled by |
|---|---|
| Flutter install, `clean`, `pub get`, `analyze`, `test` | workflow |
| CocoaPods resolution | `ios/Podfile` (platform pinned to iOS 13.0) |
| Build number allocation | `asc.py next-build-number` — reads the highest used number from App Store Connect and adds one |
| Certificate + provisioning profile | `xcodebuild -allowProvisioningUpdates` with the API key |
| Release IPA export | `xcodebuild -exportArchive` |
| Validation + upload (3 retries, then iTMSTransporter) | `altool` |
| Waiting for processing | `asc.py wait-processing` |
| Group assignment, release notes, testers | `asc.py release` |
| Rebuild before the 90-day expiry | cron, 1st of every second month |
| Expiry alarm | weekly check, opens a GitHub issue |

## Prerequisite

An active **Apple Developer Program** membership (99 USD/year). A free Apple ID
cannot upload to TestFlight.

## 1. Register the Bundle ID

<https://developer.apple.com/account/resources/identifiers/list>

**+** → App IDs → App. Description `Plans`, Bundle ID **Explicit** →
`com.plans.app`. Leave all capabilities off — the app needs none, and an
enabled capability that isn't in the App ID causes
`Provisioning profile failed qualification`.

If you use a different Bundle ID, change it in **both**
`ios/Runner.xcodeproj/project.pbxproj` (4 occurrences) and the `BUNDLE_ID`
env in both workflow files.

## 2. Create the app record

<https://appstoreconnect.apple.com/apps> → **+** → New App. Platform iOS,
Bundle ID `com.plans.app`, SKU `plans-app-001`, User Access Full Access.

The store listing **Name** must be globally unique across the App Store; it
can differ from the home-screen name.

## 3. Create the App Store Connect API key

<https://appstoreconnect.apple.com/access/integrations/api> → Team Keys → **+**

- Name: `github-actions-testflight`
- Access: **App Manager**

> App Manager is required, not optional. `-allowProvisioningUpdates` creates
> the distribution certificate and provisioning profile on demand, and the
> Developer role cannot do that — the Archive step fails with
> `No profiles for 'com.plans.app' were found`. A key's role cannot be changed
> after creation; generate a new key if you picked wrong.

**Download the `.p8` immediately — Apple allows it exactly once.**

Record three values:

| Value | Where |
|---|---|
| Key ID | the key row, e.g. `A1B2C3D4E5` |
| Issuer ID | a UUID shown *above* the key list |
| `.p8` file | the downloaded `AuthKey_XXXXXXXX.p8` |

## 4. Find the Team ID

<https://developer.apple.com/account> → Membership details → **Team ID**
(10 characters, e.g. `9ABCDE1234`).

## 5. Add the GitHub secrets

The `.p8` is multi-line, so it goes in base64. In PowerShell:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("$HOME\Downloads\AuthKey_A1B2C3D4E5.p8")) | Set-Clipboard
```

At `Settings → Secrets and variables → Actions → Secrets`, add four
**repository secrets** (names are case-sensitive):

| Secret | Value |
|---|---|
| `ASC_KEY_P8_BASE64` | the base64 string just copied |
| `ASC_KEY_ID` | Key ID from step 3 |
| `ASC_ISSUER_ID` | Issuer ID from step 3 |
| `APPLE_TEAM_ID` | Team ID from step 4 |

Then delete the `.p8` from Downloads — it is a credential that can upload
builds as you.

### Optional: predefined testers

On the **Variables** tab of the same page, add a repository variable
`TESTFLIGHT_TESTERS` with a comma-separated list:

```
alice@example.com,bob@example.com
```

Every run adds these to the internal group. Emails are not secret, so this is
a variable rather than a secret — it stays readable and editable.

> **Internal testers must already hold a role on your App Store Connect team.**
> Apple rejects an arbitrary email for an internal group. Invite them first at
> **Users and Access** (role Developer or higher). A tester that cannot be
> added is reported and skipped — it does not fail the build, because the
> build itself is already uploaded and usable.

## 6. Run it

**Actions → iOS TestFlight → Run workflow.**

- `build_number` — leave blank. It is read from App Store Connect and
  incremented, which is correct even if a build was uploaded from elsewhere.
- `release_notes` — the "What to Test" text testers see.
- `tester_group` — defaults to `Internal Testers`, created if absent.

Roughly 25–40 minutes, most of it Apple-side processing.

The pipeline also runs on a `v*.*.*` tag push, and on the 1st of every second
month (see Expiration below).

## 7. Commit `Podfile.lock` once

The first successful run attaches a `podfile-lock` artifact. Download it,
place it at `ios/Podfile.lock`, and commit. CocoaPods then resolves identical
pod versions on every later run. It can't be generated on Windows, which is
why this is a one-time manual step.

## Versioning

`pubspec.yaml` holds `version: 1.0.0+1`.

- `1.0.0` is the user-visible version — bump it for each release. The workflow
  reads it and passes it as `--build-name`.
- The `+1` build number is ignored; the real number comes from App Store
  Connect.

Apple **permanently** rejects a build number already used for the same version
string, so never reuse one. Bumping the version string resets the build
numbering.

## Expiration handling

TestFlight expires every build **90 days after upload**. Testers can no longer
install it, and Apple sends no advance warning. Two mechanisms cover this:

1. **Rebuild cron** — `ios-testflight.yml` runs `0 6 1 */2 *` (06:00 UTC on
   the 1st of every second month, ~60 days), so a fresh build always lands
   about a month before the current one expires.

   Cron has no "every 60 days"; `*/60` in the day-of-month field is
   meaningless since that field only counts 1–31. Every-second-month is the
   correct expression.

2. **Weekly monitor** — `testflight-expiry-check.yml` runs Mondays, reads the
   newest live build's `expirationDate`, and opens a GitHub issue when fewer
   than 21 days remain (or when no live build exists at all). It comments on
   the existing issue rather than filing a new one each week, and closes it
   once a fresh build is live.

> ⚠️ **GitHub disables scheduled workflows after 60 days of repository
> inactivity** — the same order as the rebuild interval. If the repo goes
> quiet, the rebuild cron silently stops. The weekly monitor is the alarm for
> exactly that case, but it is subject to the same rule; if both go quiet,
> re-enable them from the Actions tab. A commit of any kind resets the clock.
>
> Scheduled workflows also only run from the **default branch**.

## TestFlight distribution

**Internal testing** — up to 100 people holding an App Store Connect role. No
Apple review; available minutes after processing. Fully automated by the
pipeline.

**External testing** — up to 10,000 testers, no ASC role needed, and the only
route to a public invite link. Not automated, because it requires:

- **Beta App Review** (typically 24–48 hours for the first build)
- Test Information: what to test, feedback email, and a **demo account** the
  reviewer can log in with. This app signs in against the Plans ERP API, so
  without working credentials review is rejected.

Set it up at TestFlight → External Testing, then enable **Public Link**.

## Troubleshooting

**`No profiles for 'com.plans.app' were found`**
The App ID is not registered (step 1), or the API key lacks App Manager
access (step 3). Key roles cannot be changed — generate a new key.

**`No signing certificate "iOS Distribution" found`**
An Apple account allows 3 distribution certificates. Revoke an unused one at
<https://developer.apple.com/account/resources/certificates/list>.

**`Provisioning profile failed qualification`**
A capability is enabled in the Xcode project but not on the App ID. Keep them
in sync.

**`The provided entity includes an attribute with a value that has already been used`**
The build number was reused. Re-run — the number now comes from App Store
Connect, so this should not recur; if it does, the app record's bundle ID does
not match `BUNDLE_ID`.

**`Decoded .p8 is not a private key`**
The base64 secret was truncated or wrapped. Re-run the PowerShell command in
step 5 and paste the whole single-line string.

**`Invalid Bundle. Missing Info.plist value` / privacy rejection**
A required `NS*UsageDescription` key is missing.
`NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` are already
set — `image_picker` requires both, and their absence is an automatic reject.

**Upload fails repeatedly**
The workflow retries `altool` three times, then falls back to
`iTMSTransporter`. If both fail, the IPA is attached as an artifact — download
it and upload manually with Transporter (Mac App Store) while you investigate.

**Build stuck at `PROCESSING` past 30 minutes**
`wait-processing` times out but the build may still succeed. Check App Store
Connect before re-running; re-running consumes another build number.

**Build finished as `INVALID`**
App Store Connect emails the reason to the account holder. Common causes: a
missing icon size, an alpha channel in the 1024×1024 icon, an invalid
entitlement, or an unsupported architecture.

**`CocoaPods could not find compatible versions`**
A plugin requires a higher iOS minimum than 13.0. Raise the `platform :ios`
line in `ios/Podfile` **and** `IPHONEOS_DEPLOYMENT_TARGET` in
`ios/Runner.xcodeproj/project.pbxproj` together — they must match.

**A tester was skipped**
Internal testers must hold an App Store Connect role. Invite them at Users and
Access first. This is reported, not fatal.

**`Missing Compliance` in TestFlight**
Should not occur — `ITSAppUsesNonExemptEncryption=false` is set in
`ios/Runner/Info.plist`. If custom cryptography is ever added, that must be
revisited.
