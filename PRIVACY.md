# Privacy Policy

## Overview

CyberTuz is a local, offline-first application that runs entirely on your own device inside Termux. We take privacy seriously. This document explains exactly what data CyberTuz collects, stores, and does — and does not — transmit.

---

## Data Collection

### What CyberTuz Stores Locally

CyberTuz creates and writes only to the `logs/` directory inside its own folder. The following files may be created:

| File | Contents | Purpose |
|------|----------|---------|
| `logs/cybertuz.log` | Timestamped session events (start, module access, language changes, exit) | Session activity log for your own review |
| `logs/lang.dat` | A single two-letter language code (e.g., `en`, `id`) | Saves your language preference |
| `logs/latihan_progress.dat` | List of completed training level keys | Tracks Training Arena progress |
| `logs/latihan_scores.dat` | Timestamped score records per training session | Records your quiz scores |
| `logs/misi_selesai.dat` | List of completed mission IDs with timestamps | Tracks Mission System completion |
| `logs/misi_log.dat` | Mission completion event log | Mission activity log |
| `reports/` | Any pentest reports you manually write inside Module 15 | Your own notes and reports |

**All data is stored only on your device. Nothing is transmitted anywhere.**

### What CyberTuz Does NOT Collect

- No personal information (name, email, device ID, phone number)
- No hardware identifiers or fingerprints
- No usage analytics or telemetry
- No crash reports sent to external servers
- No location data
- No biometric data

---

## Network Activity

CyberTuz itself makes **no network connections** during launch or normal operation.

Some modules include optional **live practice** commands that make outbound connections to public test targets. These are:

- DNS lookups to `google.com` or `example.com` via `dig`, `host`, or `nslookup`
- Port scanning against `scanme.nmap.org` — Nmap's official public scan host
- HTTP requests to `testphp.vulnweb.com` — Acunetix's intentionally vulnerable demo site
- HTTP header checks against user-specified URLs

These connections are **initiated by standard system tools** (nmap, curl, dig) that you have installed. CyberTuz provides the commands; you choose to execute them.

**CyberTuz does not control or log these network connections.** Standard network activity on your device is handled by Termux, Android, and your internet provider per their own terms.

---

## Third-Party Tools

CyberTuz may suggest or demonstrate the use of third-party tools (nmap, curl, whois, python3, etc.). These tools are not part of CyberTuz and have their own privacy implications. Refer to each tool's documentation for details.

---

## Your Rights

Since all data is stored locally on your own device, you have full control:

- **View** your logs at any time: `cat logs/cybertuz.log`
- **Delete** any log files: `rm logs/cybertuz.log`
- **Reset** all progress: `rm -rf logs/`
- **Uninstall** CyberTuz completely: `rm -rf cybertuz/`

No account deletion request is needed because no account or server-side data exists.

---

## Children's Privacy

CyberTuz is intended for individuals who are legally adults in their jurisdiction, or minors with explicit parental or guardian consent and supervision. We do not knowingly collect any information from minors.

---

## Changes to This Policy

If this privacy policy changes, the update will be reflected in this file with a new date. Since CyberTuz collects no personal data, changes are unlikely to affect you materially.

---

## Contact

For privacy-related questions or concerns, contact the maintainer via GitHub: [@djunekz](https://github.com/djunekz)

---

*Last updated: 2025*
