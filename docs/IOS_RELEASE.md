# iOS / TestFlight release

The build runs on a GitHub Actions macOS runner, so no Mac is needed locally.
Everything below is done once; after that a release is one button click.

- Bundle ID: `com.plans.app`
- Display name: `Plans`
- Workflow: `.github/workflows/ios-testflight.yml`
- Export options: `ios/ExportOptions.plist`

## Prerequisite

An active **Apple Developer Program** membership (99 USD/year, individual or
organization). A free Apple ID cannot upload to TestFlight. Enrolment is at
<https://developer.apple.com/programs/enroll/> and can take 24-48 hours if Apple
verifies an organization (D-U-N-S number required for company accounts).

Nothing below works until the membership is active.

## 1. Register the Bundle ID

<https://developer.apple.com/account/resources/identifiers/list>

- **+** -> App IDs -> App
- Description: `Plans`
- Bundle ID: **Explicit** -> `com.plans.app`
- Capabilities: leave everything off. The app currently needs none.
- Register.

If a different Bundle ID is used, it must be changed in **both**
`ios/Runner.xcodeproj/project.pbxproj` (4 occurrences) and the `BUNDLE_ID` env in
the workflow.

## 2. Create the app record

<https://appstoreconnect.apple.com/apps> -> **+** -> New App

- Platform: iOS
- Name: `Plans` (must be globally unique across the App Store; if taken, pick
  another - this is the store listing name and can differ from the home-screen name)
- Primary language, Bundle ID `com.plans.app`, SKU: `plans-app-001`
- User Access: Full Access

## 3. Create the App Store Connect API key

<https://appstoreconnect.apple.com/access/integrations/api>

- Team Keys tab -> **+**
- Name: `github-actions-testflight`
- Access: **App Manager** (needed so Xcode can create signing certificates
  automatically; Developer role is not sufficient)
- Generate, then **download the `.p8` file - it can only be downloaded once.**

Record three values:

| Value | Where |
|---|---|
| Key ID | the key row, e.g. `A1B2C3D4E5` |
| Issuer ID | shown above the key list, a UUID |
| `.p8` file | the downloaded `AuthKey_XXXXXXXX.p8` |

## 4. Find the Team ID

<https://developer.apple.com/account> -> Membership details -> **Team ID**
(10 characters, e.g. `9ABCDE1234`).

## 5. Add the GitHub secrets

The `.p8` is binary-ish and multi-line, so it goes in base64. In PowerShell:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("$HOME\Downloads\AuthKey_A1B2C3D4E5.p8")) | Set-Clipboard
```

Then at
`https://github.com/engmohamedtarek5060-source/Plans/settings/secrets/actions`
add four repository secrets:

| Secret | Value |
|---|---|
| `ASC_KEY_P8_BASE64` | the base64 string just copied |
| `ASC_KEY_ID` | Key ID from step 3 |
| `ASC_ISSUER_ID` | Issuer ID from step 3 |
| `APPLE_TEAM_ID` | Team ID from step 4 |

Delete the `.p8` from the Downloads folder afterwards. It is a credential.

## 6. Run the build

GitHub -> **Actions** -> **iOS TestFlight** -> **Run workflow**.

- `build_number` - leave blank; the workflow uses the run number, which always
  increases. Apple rejects a build number that has been used before for the same
  version string.
- `release_notes` - shown to testers.

The run takes roughly 15-25 minutes. The IPA is also attached as an artifact, so
a failed upload can be retried without rebuilding.

## 7. TestFlight

After upload, App Store Connect processes the build for 5-15 minutes before it
appears under **TestFlight -> iOS Builds**.

**Internal testing** - up to 100 people who hold a role on the App Store Connect
team. No Apple review. Available within minutes of processing.

- TestFlight -> Internal Testing -> **+** on a group -> add testers by Apple ID email.
- Each tester installs the TestFlight app from the App Store and accepts the
  emailed invite.

**External testing** - up to 10,000 people, no App Store Connect role needed, and
the only route to a **public invite link**.

- TestFlight -> External Testing -> create a group -> add the build.
- Requires **Beta App Review** (typically 24-48 hours for the first build).
- Requires filled Test Information: what to test, feedback email, and a
  **demo account** - the reviewer must be able to log in. Given this app signs in
  against the Plans ERP API, supply working credentials or review will be rejected.
- Once approved, enable **Public Link** on the group. That URL is the shareable
  invite link.

## Version bumps

`pubspec.yaml` holds `version: 1.0.0+1`. The `1.0.0` part is the user-visible
version; bump it for each release. The `+1` build number is overridden by the
workflow, so it does not need editing.

## Troubleshooting

**"No profiles for 'com.plans.app' were found"** - the Bundle ID in step 1 was not
registered, or the API key lacks App Manager access.

**"Provisioning profile failed qualification"** - a capability is enabled in Xcode
that is not enabled on the App ID. Keep them in sync.

**"The provided entity includes an attribute with a value that has already been used"** -
the build number was reused. Re-run with a higher `build_number`.

**"Missing Compliance" in TestFlight** - should not occur;
`ITSAppUsesNonExemptEncryption=false` is set in `ios/Runner/Info.plist`. If it
does, answer the prompt in App Store Connect.

**Certificate limit reached** - an Apple account allows 3 distribution
certificates. Revoke unused ones at
<https://developer.apple.com/account/resources/certificates/list>.
