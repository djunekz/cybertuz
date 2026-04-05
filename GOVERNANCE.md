# Project Governance

## Overview

CyberTuz is a community-oriented open-source project. This document describes how decisions are made, who has what authority, and how the project is organized.

---

## Project Roles

### Maintainer

The current project maintainer is **djunekz** ([@djunekz](https://github.com/djunekz)).

Maintainer responsibilities:
- Reviewing and merging pull requests
- Triaging and responding to issues
- Making final decisions on direction, features, and standards
- Managing releases and the changelog
- Enforcing the Code of Conduct
- Publishing security advisories

### Contributors

Anyone who submits a pull request, reports a bug, improves documentation, or adds a translation is a contributor. Contributors are listed in the GitHub contributor graph and may be acknowledged in `CHANGELOG.md` for significant contributions.

There is no formal hierarchy beyond maintainer and contributor at this time.

---

## Decision Making

### Day-to-Day Decisions

The maintainer makes routine decisions about bug fixes, small improvements, and documentation changes. These may be merged without extended review if they are low-risk and clearly correct.

### Feature Decisions

New features — new modules, significant behavior changes, architectural changes — are discussed openly in GitHub issues before implementation begins. Community input is welcomed. The maintainer makes the final call.

### Language and Content Standards

All user-facing text must follow the language system (`lang.sh`). Content standards — no hardcoded single-language strings, no emoji in output, no inline comments — are non-negotiable and enforced at review time.

### Ethical Standards

Any contribution or decision that could facilitate unauthorized access or illegal use is rejected without debate, regardless of perceived educational value. This is a strict and non-negotiable policy.

---

## Releases

CyberTuz uses **Semantic Versioning** (MAJOR.MINOR.PATCH):

- **MAJOR** — Breaking changes to module structure, file format, or behavior
- **MINOR** — New modules, new language support, significant new features
- **PATCH** — Bug fixes, minor content corrections, typo fixes

Releases are tagged on the `main` branch. The `CHANGELOG.md` is updated for every release.

---

## Becoming a Maintainer

At present, CyberTuz is maintained by a single person. If the project grows significantly and a contributor consistently demonstrates:

- High-quality pull requests
- Constructive issue engagement
- Alignment with project ethics and standards
- Understanding of the codebase and architecture

...they may be invited to join as a co-maintainer. This is at the sole discretion of the current maintainer.

---

## Conflict Resolution

If a dispute arises about a pull request, feature decision, or conduct:

1. Attempt to resolve through respectful discussion in the relevant GitHub thread
2. If unresolved, the maintainer makes the final decision
3. Decisions about conduct violations follow the enforcement ladder in [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

---

## Changes to This Document

Changes to the governance model require a public issue for community discussion before being merged. The maintainer has final authority but will give reasonable notice and consider community input.

---

*Last updated: 2025*
