# Changelog

All notable changes to CyberTuz are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

- Additional language translations
- New CTF challenge scenarios
- Web-based dashboard for progress tracking

---

---

## [1.0.2] - 2026-04-25

### Update
- **Support English Language** — Next change 02, 03, 13, 14, 15, 16, 17
  - modules/01_teori_dasar.sh
  - modules/04_vulnerability.sh
  - modules/05_web_security.sh
  - modules/06_kriptografi.sh
  - modules/07_password_security.sh
  - modules/08_social_engineering.sh
  - modules/09_network_security.sh
  - modules/10_wireless_security.sh
  - modules/11_forensik.sh
  - modules/12_malware_analysis.sh

---
## [1.0.1] - 2026

### Added
- **Multi-language system** — Full support for 13 languages: English, Indonesian, Hindi, Malay, Russian, Chinese Simplified, Japanese, Thai, Vietnamese, Arabic, Spanish, Italian, Korean
- `lang.sh` — Centralized language library loaded by all modules
- Language selection screen on first launch with CyberTuz description in English
- Language preference saved to `logs/lang.dat` — persists across sessions
- `[L]` option in main menu to change language at any time
- **Module 16: Training Arena** — Leveled hands-on practice system
  - Level 1–2 (Newbie): DNS/port reconnaissance, subdomain probing, nmap basics
  - Level 3–4 (Intermediate): Web vulnerability simulation, Linux privilege escalation
  - Level 5–6 (Advanced): Full web app pentest chain, network attack analysis
  - Level 7 (Expert): Red team full exploitation chain with responsible disclosure
  - Progress and scores saved to `logs/latihan_progress.dat` and `logs/latihan_scores.dat`
- **Module 17: Mission System** — Structured pentest simulation tasks
  - M-01 (Easy): Domain investigation with live DNS/MX/TXT/subdomain lookup
  - M-02 (Easy): Port scanning and service fingerprinting with nmap
  - M-03 (Medium): Cryptography analysis and hash cracking simulation
  - M-04 (Medium): Web vulnerability hunting and PHP code analysis
  - M-05 (Hard): Linux post-exploitation walkthrough with live system enumeration
  - M-06 (Hard): Incident response simulation with Apache log analysis
  - Mission completion saved to `logs/misi_selesai.dat`

### Changed
- Main menu updated to include modules 16 and 17
- Menu prompt updated from `[0-15]` to `[0-17]`
- All modules now support language variable injection via `lang.sh`
- `jeda()` function now uses localized `CT_ENTER` string in modules 16 and 17

---

## [1.0.0] - 2026

### Added
- Initial release of CyberTuz
- **Module 01**: Basic Theory of Cyber Security — CIA triad, attack types, threat models
- **Module 02**: Reconnaissance & Information Gathering — OSINT, passive/active recon, Google dorks
- **Module 03**: Network Scanning & Enumeration — nmap usage, port states, service detection
- **Module 04**: Vulnerability Assessment — CVSS scoring, vulnerability databases, scanning tools
- **Module 05**: Web Application Security — OWASP Top 10, SQLi, XSS, CSRF, file upload
- **Module 06**: Cryptography & Encryption — symmetric/asymmetric, hashing, PKI basics
- **Module 07**: Password Security & Cracking — wordlists, hashcat, john, rainbow tables
- **Module 08**: Social Engineering Awareness — phishing, vishing, pretexting, defense
- **Module 09**: Network Security & Firewall — iptables, firewall rules, IDS/IPS concepts
- **Module 10**: Wireless Security — WPA2, handshake capture, wireless recon
- **Module 11**: Digital Forensics — file analysis, metadata, log forensics, chain of custody
- **Module 12**: Malware Analysis Basics — static/dynamic analysis, sandbox concepts
- **Module 13**: CTF & Practice Challenges — hands-on flag challenges with hints
- **Module 14**: Tools & Complete Cheatsheet — quick reference for nmap, sqlmap, burpsuite, etc.
- **Module 15**: Reports & Learning Progress — session log viewer, progress summary
- Main launcher `cybertuz.sh` with ASCII banner, disclaimer, and menu routing
- Ethical disclaimer with agreement gate on first launch
- Activity logging to `logs/cybertuz.log`
- Modular architecture — each module is a self-contained Bash script

---

## Legend

- **Added** — New features or modules
- **Changed** — Changes to existing functionality
- **Deprecated** — Features that will be removed in upcoming releases
- **Removed** — Features removed in this release
- **Fixed** — Bug fixes
- **Security** — Security-related fixes or improvements
