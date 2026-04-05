# Contributing to CyberTuz

Thank you for your interest in contributing to CyberTuz! Contributions of all kinds are welcome — bug fixes, new modules, language translations, documentation improvements, and ideas.

Please read this guide before submitting anything to ensure a smooth process for everyone.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Ways to Contribute](#ways-to-contribute)
- [Getting Started](#getting-started)
- [Development Guidelines](#development-guidelines)
- [Adding a New Module](#adding-a-new-module)
- [Adding or Improving a Language Translation](#adding-or-improving-a-language-translation)
- [Submitting a Pull Request](#submitting-a-pull-request)
- [Reporting Bugs](#reporting-bugs)
- [Requesting Features](#requesting-features)
- [Ethical Guidelines for Contributors](#ethical-guidelines-for-contributors)

---

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it before contributing.

---

## Ways to Contribute

- **Bug reports** — Found something broken? Open an issue.
- **Feature requests** — Have an idea? Open a feature request.
- **New modules** — Want to add a new learning topic? See below.
- **Language translations** — Help translate CyberTuz into more languages.
- **Documentation** — Improve README, fix typos, clarify explanations.
- **Code improvements** — Optimize existing modules or fix logic issues.
- **CTF challenges** — Add new challenges to Module 13.
- **Content review** — Review existing module content for accuracy.

---

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/cybertuz.git
   cd cybertuz
   ```
3. **Create a new branch** for your changes:
   ```bash
   git checkout -b feature/my-feature-name
   ```
4. Make your changes
5. **Test** your changes on Termux (Android) or a Linux terminal
6. **Commit** and **push**:
   ```bash
   git add .
   git commit -m "feat: brief description of change"
   git push origin feature/my-feature-name
   ```
7. Open a **Pull Request** on GitHub

---

## Development Guidelines

### Shell Scripting Standards

- All scripts must be valid **Bash** (not sh) — use `#!/bin/bash`
- Run `bash -n yourfile.sh` to check syntax before submitting
- No comments (`#`) inside script logic — only the shebang line is allowed
- No emoji anywhere in script output
- Use the standard color variables: `RED GREEN YELLOW CYAN WHITE BLUE MAGENTA DIM BOLD RESET`
- Use `echo -e` for all colored output
- All user-facing text must use `CT_*` language variables from `lang.sh`

### Language Variable Usage

Every string shown to the user must reference a `CT_*` variable from `lang.sh`. Do not hardcode display text in module files. For example:

```bash
echo -e "${GREEN}  [$CT_CORRECT]${RESET} $1"
echo -ne "${DIM}  $CT_ENTER${RESET}"
```

### File Naming

- Modules: `NN_short_name.sh` where `NN` is a two-digit number (e.g., `18_new_topic.sh`)
- New modules must be registered in `cybertuz.sh` main menu

### Tested Targets Only

All live commands must use **safe, legal, public test targets**:
- `scanme.nmap.org` — nmap's official scan test host
- `testphp.vulnweb.com` — Acunetix's intentionally vulnerable test site
- `localhost` or `127.0.0.1`
- `google.com`, `example.com` for DNS lookups only

Never target third-party systems without explicit authorization.

---

## Adding a New Module

1. Copy an existing module as a template
2. Place it in `modules/` with the next available number
3. Add `lang.sh` injection at the top (see any module 16 or 17 for the pattern)
4. Use only `CT_*` variables for user-facing text
5. Register it in `cybertuz.sh`:
   - Add a menu entry in the `main_menu()` function
   - Add a `case` handler to route to it
   - Add the corresponding `CT_M*` strings to all 13 language blocks in `lang.sh`
6. Update `CHANGELOG.md`

---

## Adding or Improving a Language Translation

All translations live in `lang.sh` inside the `_ct_set_lang()` function.

To add a new language:

1. Add a new `case` block with a two-letter language code (ISO 639-1)
2. Translate all `CT_*` variables for that language
3. Add the language to the selection menu in `ct_choose_language()`
4. Test that all modules display correctly
5. Submit a pull request

To fix or improve an existing translation:

1. Find the relevant `case` block in `lang.sh`
2. Correct the strings
3. Test and submit

---

## Submitting a Pull Request

Before opening a PR, ensure:

- [ ] Your code passes `bash -n` syntax check
- [ ] You have tested on Termux or a Linux terminal
- [ ] All user-facing strings use `CT_*` language variables
- [ ] No hardcoded Indonesian or other single-language text in logic files
- [ ] `CHANGELOG.md` is updated
- [ ] Your branch is up to date with `main`
- [ ] The PR description clearly explains what was changed and why

Use the PR template provided in `.github/PULL_REQUEST_TEMPLATE.md`.

---

## Reporting Bugs

Use the **Bug Report** issue template. Include:
- Termux version and Android version
- Steps to reproduce the issue
- What you expected to happen
- What actually happened
- Any error output (paste the terminal output)

---

## Requesting Features

Use the **Feature Request** issue template. Describe:
- The problem you want solved or the capability you want added
- Why it would benefit CyberTuz users
- Any ideas on how it could be implemented

---

## Ethical Guidelines for Contributors

All contributions must align with CyberTuz's educational mission:

- Content must be legal and ethical in nature
- Do not contribute exploit code targeting production systems
- Do not add techniques that have no legitimate educational value
- All live command examples must use authorized public test targets
- Follow responsible disclosure — if your contribution references a real vulnerability, it must be properly disclosed or patched

Contributions that facilitate unauthorized access, illegal activity, or harm will be rejected and the contributor may be blocked from the project.

---

Thank you for helping make CyberTuz better for learners everywhere.
