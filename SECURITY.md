# SECURITY POLICY

**S.T.R.A.T.A.G.E.M. TERMINAL** — Security Disclosure Policy

---

## Supported Versions

Only the latest released version receives security attention. Older versions are unsupported.

| Version | Supported |
|---------|-----------|
| 4.8.x (current) | Yes |
| 4.7.x | No |
| < 4.7 | No |

---

## Scope

This is a local AutoHotkey v2 script that runs entirely on your machine. It has no server component and no user accounts. Starting in v4.8.9, an **optional** outbound HTTPS request checks the GitHub Releases API for newer versions — this is disabled by default and only activates when the user manually sets the `UpdateURL` global variable. No user data is transmitted. Security concerns are therefore narrow but real:

### In Scope

The following are considered valid security issues for this project:

- **Malicious code injection** - a modified or counterfeit version of this script that exfiltrates data, executes unintended system commands, or modifies files outside the script directory
- **Stratagem sequence tampering** - a modified `stratagems.json` or `.ahk` file distributed under the project's name that causes unintended input automation (e.g., sending macro inputs that could damage a game account more aggressively)
- **Config file exploitation** - a crafted `stratagem_loadout.ini` that causes unintended script behavior when loaded
- **Future network features (v6.x+)** - once LAN broadcast, web server, or community platform features are added, any vulnerability in those network surfaces (e.g., unauthenticated RCE, SSRF, arbitrary file write via crafted payloads)
- **Dependency vulnerabilities** - if the project adopts npm, Python, or other package managers in companion app phases, known CVEs in those dependencies

### Out of Scope

The following are **not** treated as security vulnerabilities for this project:

- Anti-cheat detection by Helldivers 2 or any platform - this is expected behavior, not a security flaw
- Account bans resulting from use - this is a Terms of Service issue, not a software vulnerability
- The script sending keyboard/mouse input to the game - this is the intended function of the tool
- Windows UAC prompts when running `.ahk` files - standard OS behavior
- The script being visible to the game's process list - expected for any foreground application

---

## Reporting a Vulnerability

If you discover a security issue, please **do not open a public GitHub Issue** for vulnerabilities that could be exploited before a fix is released.

### How to Report

1. **Open a GitHub Issue** marked `[SECURITY]` in the title for lower-severity issues that do not pose immediate risk to users
2. For issues involving potential for harm to users (e.g., a compromised release binary, data exfiltration in a future network feature), contact the repository maintainer directly via GitHub private messaging or the contact method listed on the profile

### What to Include

- Description of the vulnerability
- Steps to reproduce
- The version of the script affected
- Your assessment of impact and severity
- Any proof-of-concept code (please do not include working exploits publicly)

### Response Timeline

| Severity | Initial Response | Target Fix |
|----------|-----------------|------------|
| Critical (user data at risk, RCE) | 48 hours | 7 days |
| High (unintended system access) | 72 hours | 14 days |
| Medium (config exploitation, behavioral) | 1 week | 30 days |
| Low (informational, theoretical) | 2 weeks | Next minor release |

These are best-effort targets for a solo personal project. There are no SLAs.

---

## Known Security Considerations

### Input Automation Visibility

The script uses `SendInput` and `SendEvent` to send directional keystrokes to the game. Any anti-cheat or monitoring software with kernel-level access can observe these inputs. This is by design and not a vulnerability.

### Config Files Are Plaintext

`stratagem_loadout.ini` stores only stratagem names as plaintext. No credentials, tokens, or sensitive data are stored. Do not add sensitive information to this file.

### No Code Signing

`.ahk` script files are not code-signed. You should only run scripts obtained directly from the official repository or that you have personally reviewed. Verify the file hash against the published release if in doubt.

### Update Notifier (v4.8.9+)

The optional update notifier makes a single outbound HTTPS GET request to the GitHub Releases API on startup (after a 3-second delay). It sends only a `User-Agent: STRATAGEM-Terminal` header and reads only the `tag_name` field from the JSON response. No user data, system information, or loadout data is transmitted. The request is wrapped in `try` and fails silently on any error. **This feature is disabled by default** — it only activates when the user manually sets the `UpdateURL` global variable to a GitHub API endpoint.

### Future Network Attack Surface

Starting in the v6.x roadmap, features including a local web server (localhost:7447), LAN UDP broadcast, and expanded GitHub integration are planned. When these features ship, the security policy will be updated to reflect the expanded attack surface. Network features will be **opt-in and disabled by default**.

---

## Verifying Release Integrity

When the project publishes compiled `.exe` releases (planned for v6.7.x), SHA-256 checksums will be published alongside each release. To verify:

```powershell
# PowerShell
Get-FileHash .\STRATAGEM_TERMINAL_v4.8.10.exe -Algorithm SHA256
```

Compare the output against the checksum listed in the corresponding GitHub Release.

---

## Security Hardening Recommendations

If you are security-conscious about running `.ahk` scripts:

1. **Review the source** - `Helldivers.ahk` is a single file. Read it before running.
2. **Run in a standard user account** - the script does not require administrator privileges
3. **Check the script directory** - the script only reads/writes `stratagem_loadout.ini` in its own folder; no other disk access is performed
4. **Use Windows Defender or equivalent** - keep your AV active; it will scan `.ahk` files on execution
5. **Do not run modified versions from unknown sources** - only run scripts you obtained from the official repo or that you personally modified

---

*Last updated: v4.8.10 release*
