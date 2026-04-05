# Frequently Asked Questions (FAQ)

## General

**What is CyberTuz?**

CyberTuz is a free, open-source, terminal-based cyber security learning platform designed to run on Termux (Android). It covers topics from basic theory to advanced penetration testing simulations, all from your phone.

**Is CyberTuz free?**

Yes. CyberTuz is completely free, open-source, and has no ads, subscriptions, or tracking.

**What languages does CyberTuz support?**

CyberTuz supports 13 languages: English, Indonesian, Hindi, Malay, Russian, Chinese Simplified, Japanese, Thai, Vietnamese, Arabic, Spanish, Italian, and Korean. You choose your language on first launch, and it is saved for future sessions. You can change it anytime by pressing `L` in the main menu.

**Is CyberTuz only for Android?**

CyberTuz is designed and tested for Termux on Android, but it will run on any system with Bash 4.0 or later — including Linux, macOS (with bash), and WSL on Windows.

---

## Installation

**How do I install CyberTuz?**

```bash
pkg update && pkg upgrade -y
pkg install -y git nmap curl dnsutils whois python3
git clone https://github.com/djunekz/cybertuz.git
cd cybertuz
chmod +x cybertuz.sh
bash cybertuz.sh
```

**Do I need root/sudo to run CyberTuz?**

No. CyberTuz does not require root access. Some advanced tools like nmap's SYN scan (`-sS`) require root, but CyberTuz uses only non-root scan methods when running inside Termux.

**The tool says a command is not found. What do I do?**

Install the missing tool via Termux:
```bash
pkg install nmap         # for nmap
pkg install curl         # for curl
pkg install dnsutils     # for dig, host, nslookup
pkg install whois        # for whois
pkg install python3      # for python3
```

---

## Usage

**How do I start CyberTuz?**

```bash
cd cybertuz
bash cybertuz.sh
```

**How do I change the language?**

Press `L` at the main menu. You will see the full language selection screen.

**Where is my progress saved?**

Progress is saved in the `logs/` directory inside the CyberTuz folder:
- `logs/cybertuz.log` — session activity log
- `logs/lang.dat` — saved language preference
- `logs/latihan_progress.dat` — Training Arena completion progress
- `logs/latihan_scores.dat` — Training Arena scores
- `logs/misi_selesai.dat` — completed missions

**How do I reset my progress?**

Delete the relevant files in `logs/`:
```bash
rm logs/latihan_progress.dat logs/latihan_scores.dat
rm logs/misi_selesai.dat
```

To reset everything including language:
```bash
rm -rf logs/
```

**Can I run CyberTuz without an internet connection?**

Most of the theory modules and CTF challenges work fully offline. Live practice sections (DNS lookups, nmap against scanme.nmap.org, HTTP header checks) require an internet connection.

---

## Modules

**What is the Training Arena?**

The Training Arena (Module 16) is a leveled practice system. You progress through difficulty levels — Newbie, Intermediate, Advanced, and Expert — with hands-on exercises, simulated scenarios, and scored quizzes.

**What is the Mission System?**

The Mission System (Module 17) presents structured pentest simulation tasks with backgrounds, objectives, and step-by-step execution guides. Missions simulate real-world scenarios like domain investigation, port scanning, web vulnerability hunting, post-exploitation, and incident response.

**Are the CTF challenges real?**

Module 13 contains CTF-style exercises that run locally within CyberTuz. They are simulated challenges designed to teach concepts — not live CTF competitions. For real CTF practice, consider platforms like HackTheBox, TryHackMe, or PicoCTF.

---

## Ethics and Legality

**Is it legal to use CyberTuz?**

Using CyberTuz for learning, on systems you own, or on authorized targets is legal. Using it to access systems without permission is illegal in virtually every country. Read the full [DISCLAIMER.md](DISCLAIMER.md).

**Can I use CyberTuz for bug bounty hunting?**

Yes, if you are participating in an authorized bug bounty program and operating within the defined scope. Always ensure you have written authorization before testing any target.

**What targets does CyberTuz use for live practice?**

CyberTuz uses only safe, authorized public test targets:
- `scanme.nmap.org` — nmap's official public scan test host
- `testphp.vulnweb.com` — Acunetix's intentionally vulnerable demo site
- `localhost` / `127.0.0.1` — your own device
- `google.com`, `example.com` — for DNS resolution examples only

---

## Contributing

**How can I contribute?**

See [CONTRIBUTING.md](CONTRIBUTING.md) for full details. In short: fork the repo, make changes on a branch, test on Termux, and open a pull request.

**I want to add a new language. How?**

Add a new `case` block in the `_ct_set_lang()` function inside `lang.sh`, translate all `CT_*` variables, add the language to the selection menu in `ct_choose_language()`, and submit a pull request.

**I found a bug. Where do I report it?**

Open an issue on GitHub using the Bug Report template. For security vulnerabilities, see [SECURITY.md](SECURITY.md).

---

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for solutions to common problems.

---

*Last updated: 2025*
