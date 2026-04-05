<div align="center">

```
  ██████╗██╗   ██╗██████╗ ███████╗██████╗ ████████╗██╗   ██╗███████╗
 ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║   ██║╚══███╔╝
 ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝   ██║   ██║   ██║  ███╔╝
 ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗   ██║   ██║   ██║ ███╔╝
 ╚██████╗   ██║   ██████╔╝███████╗██║  ██║   ██║   ╚██████╔╝███████╗
  ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
```

**Comprehensive Cyber Security Learning Platform for Termux**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Termux-green.svg)](https://termux.dev)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Languages](https://img.shields.io/badge/Languages-13-orange.svg)](#language-support)
[![Modules](https://img.shields.io/badge/Modules-17-red.svg)](#modules)
[![GitHub](https://img.shields.io/badge/GitHub-djunekz%2Fcybertuz-black.svg)](https://github.com/djunekz/cybertuz)

</div>

---

## What is CyberTuz?

CyberTuz is a free, open-source, terminal-based cyber security learning platform built entirely in Bash and designed to run on [Termux](https://termux.dev) on Android. It covers ethical hacking, penetration testing, network security, web application security, cryptography, digital forensics, CTF challenges, and real-world pentest simulations — all from your phone.

> **For educational purposes only.** All content is designed to teach legal and ethical security practices.

---

## Features

- **17 learning modules** covering beginner to expert topics
- **13 language support** — English, Indonesian, Hindi, Malay, Russian, Chinese, Japanese, Thai, Vietnamese, Arabic, Spanish, Italian, Korean
- **Training Arena** — leveled hands-on practice (Newbie → Expert)
- **Mission System** — real-world pentest simulation tasks
- **CTF challenges** — capture the flag practice exercises
- **Live practice** — real commands against safe targets (scanme.nmap.org, etc.)
- **Progress tracking** — scores and mission completion saved locally
- **No internet required** for most features
- **Completely free** — no ads, no tracking, no subscriptions

---

## Requirements

- Android device with [Termux](https://termux.dev) installed
- Bash 4.0 or later (included in Termux)
- Optional tools for live practice: `nmap`, `curl`, `dig`, `whois`, `python3`

---

## Installation

```bash
# Update Termux packages
pkg update && pkg upgrade -y

# Install required tools (optional but recommended)
pkg install -y nmap curl dnsutils whois python3 git

# Clone the repository
git clone https://github.com/djunekz/cybertuz

# Enter directory
cd cybertuz

# Give execute permission
chmod +x cybertuz.sh

# Run CyberTuz
bash cybertuz.sh
```

---

## Quick Start

```bash
bash cybertuz.sh
```

On first launch, you will be greeted with a **welcome screen in English** and prompted to **select your language**. Your choice is saved automatically and used for all future sessions.

To change language at any time, press `L` in the main menu.

---

## Modules

| No | Module | Description |
|----|--------|-------------|
| 01 | Basic Theory | Fundamentals of cyber security concepts |
| 02 | Reconnaissance | Passive and active information gathering |
| 03 | Network Scanning | Nmap, port scanning, service enumeration |
| 04 | Vulnerability Assessment | Identifying and classifying vulnerabilities |
| 05 | Web Application Security | OWASP Top 10, SQLi, XSS, and more |
| 06 | Cryptography | Encryption, hashing, encoding techniques |
| 07 | Password Security | Password cracking and defense strategies |
| 08 | Social Engineering | Phishing, pretexting, awareness training |
| 09 | Network Security | Firewall, IDS/IPS, network defense |
| 10 | Wireless Security | WPA2, handshake capture, wireless attacks |
| 11 | Digital Forensics | File analysis, log forensics, evidence handling |
| 12 | Malware Analysis | Static and dynamic malware analysis basics |
| 13 | CTF Challenges | Capture the Flag hands-on exercises |
| 14 | Tools Cheatsheet | Quick reference for common security tools |
| 15 | Reports & Progress | Learning progress tracker and notes |
| 16 | Training Arena | Leveled practice: Newbie → Intermediate → Advanced → Expert |
| 17 | Mission System | Structured pentest simulation tasks |

---

## Language Support

CyberTuz supports 13 languages. The entire UI, menus, disclaimers, module labels, and feedback messages are translated:

| # | Language | Native Name |
|---|----------|-------------|
| 1 | English | English |
| 2 | Indonesian | Indonesia |
| 3 | Hindi | हिन्दी |
| 4 | Malay | Bahasa Melayu |
| 5 | Russian | Русский |
| 6 | Chinese Simplified | 中文 简体 |
| 7 | Japanese | 日本語 |
| 8 | Thai | ภาษาไทย |
| 9 | Vietnamese | Tiếng Việt |
| 10 | Arabic | العربية |
| 11 | Spanish | Español |
| 12 | Italian | Italiano |
| 13 | Korean | 한국어 |

---

## File Structure

```
cybertuz/
├── cybertuz.sh          # Main launcher
├── lang.sh              # Multi-language library (13 languages)
├── LICENSE
├── README.md
├── modules/
│   ├── 01_teori_dasar.sh
│   ├── 02_reconnaissance.sh
│   ├── 03_network_scanning.sh
│   ├── 04_vulnerability.sh
│   ├── 05_web_security.sh
│   ├── 06_kriptografi.sh
│   ├── 07_password_security.sh
│   ├── 08_social_engineering.sh
│   ├── 09_network_security.sh
│   ├── 10_wireless_security.sh
│   ├── 11_forensik.sh
│   ├── 12_malware_analysis.sh
│   ├── 13_ctf_latihan.sh
│   ├── 14_tools_cheatsheet.sh
│   ├── 15_laporan.sh
│   ├── 16_training_arena.sh
│   └── 17_misi_tugas.sh
└── logs/                # Auto-created: progress, scores, session log
```

---

## Ethical Use

CyberTuz is strictly for **educational and authorized use only**. By running this tool you agree to:

- Only use techniques on systems you own or have explicit written permission to test
- Never use this tool for unauthorized access, surveillance, or harm
- Comply with all laws and regulations in your country
- Follow responsible disclosure practices

Unauthorized access to computer systems is illegal in most jurisdictions. The author assumes no liability for misuse. See [DISCLAIMER.md](DISCLAIMER.md) for full details.

---

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting pull requests or issues.

---

## Security

To report a security vulnerability, see [SECURITY.md](SECURITY.md).

---

## License

Released under the [MIT License](LICENSE). Free to use, modify, and distribute with attribution.

---

## Author

Made with dedication by **djunekz**

- GitHub: [@djunekz](https://github.com/djunekz)
- Repository: [github.com/djunekz/cybertuz](https://github.com/djunekz/cybertuz)

---

<div align="center">
<sub>CyberTuz — Learn. Practice. Hack Ethically.</sub>
</div>
