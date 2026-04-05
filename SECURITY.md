# Security Policy

## Supported Versions

CyberTuz is actively maintained on the `main` branch. Only the latest release receives security updates.

| Version | Supported |
|---------|-----------|
| Latest (main) | Yes |
| Older releases | No |

---

## Reporting a Security Vulnerability

If you discover a security vulnerability in CyberTuz itself (the tool's code, not vulnerabilities you find *using* the tool), please report it responsibly.

### How to Report

**Do not open a public GitHub issue for security vulnerabilities.**

Instead, please report privately by:

1. Opening a **private security advisory** via GitHub:
   - Go to the repository: `https://github.com/djunekz/cybertuz`
   - Click **Security** tab → **Advisories** → **New draft security advisory**
2. Or contact the maintainer directly via GitHub private message: [@djunekz](https://github.com/djunekz)

### What to Include in Your Report

- A clear description of the vulnerability
- The affected file(s) and line numbers, if applicable
- Steps to reproduce the issue
- Potential impact or severity assessment
- Any suggested fix or mitigation (optional but appreciated)

---

## Response Timeline

| Stage | Timeframe |
|-------|-----------|
| Initial acknowledgment | Within 72 hours |
| Severity assessment | Within 7 days |
| Fix or mitigation | Within 30 days (critical: sooner) |
| Public disclosure | After fix is released |

---

## Scope

### In Scope

- Code execution vulnerabilities in `cybertuz.sh`, `lang.sh`, or any module script
- Privilege escalation bugs caused by CyberTuz code
- Injection vulnerabilities in user input handling within CyberTuz
- Vulnerabilities in the language or module loading mechanism
- Any issue that could cause unintended harm to the user's device or data

### Out of Scope

- Vulnerabilities in third-party tools that CyberTuz calls (nmap, curl, python3, etc.) — report those to the respective projects
- Vulnerabilities found *using* CyberTuz on external systems — those should be reported to the relevant system owner
- Issues caused by running CyberTuz on rooted devices or heavily modified Android environments
- Social engineering of maintainers

---

## Disclosure Policy

CyberTuz follows **coordinated disclosure**:

1. Reporter submits a private report
2. Maintainer acknowledges and investigates
3. Fix is developed and tested
4. A new release is published with the fix
5. A public security advisory is published crediting the reporter (unless anonymity is requested)

We ask that reporters allow at least **30 days** before any public disclosure to give time for a proper fix.

---

## Security Best Practices for CyberTuz Users

CyberTuz is a security learning tool. To use it safely:

- Run CyberTuz only on devices you own and control
- Do not run CyberTuz as root unless you understand the risks
- Keep Termux and all packages up to date: `pkg update && pkg upgrade`
- Only run modules against authorized targets
- Do not share your `logs/` directory — it contains your session history

---

## Bug Bounty

CyberTuz does not currently operate a formal bug bounty program. However, responsible reporters will be credited in the security advisory and CHANGELOG.

---

*Last updated: 2025*
