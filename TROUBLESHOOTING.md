# Troubleshooting

This guide covers common issues when installing or running CyberTuz on Termux and their solutions.

---

## Installation Issues

### `git: command not found`

```bash
pkg install git
```

### `bash: command not found` or wrong bash version

Termux ships with bash. If missing:
```bash
pkg install bash
```

Check version:
```bash
bash --version
```
Bash 4.0 or later is required.

### Clone fails with SSL or network error

```bash
pkg install ca-certificates
pkg update
git clone https://github.com/djunekz/cybertuz.git
```

---

## Launch Issues

### `Permission denied` when running `./cybertuz.sh`

```bash
chmod +x cybertuz.sh
bash cybertuz.sh
```

Always run with `bash cybertuz.sh`, not `./cybertuz.sh`, for best compatibility.

### `lang.sh: No such file or directory`

You are running `cybertuz.sh` from the wrong directory, or `lang.sh` is missing.

```bash
# Make sure you are inside the cybertuz folder
ls
# You should see: cybertuz.sh  lang.sh  modules/

# If lang.sh is missing, re-clone
git clone https://github.com/djunekz/cybertuz.git
```

### `source: not found`

This happens if you run CyberTuz with `sh` instead of `bash`:
```bash
# Wrong:
sh cybertuz.sh

# Correct:
bash cybertuz.sh
```

### The banner displays garbled characters or boxes

Your terminal does not support UTF-8. In Termux:

- Go to **Settings** in the Termux app
- Ensure **Font** is set to a font that supports Unicode
- Or install a Nerd Font via termux-font

### Colors do not display correctly

```bash
export TERM=xterm-256color
bash cybertuz.sh
```

---

## Language Issues

### Language selection screen does not appear

CyberTuz reads your saved language from `logs/lang.dat`. If the file exists but is corrupted:
```bash
rm logs/lang.dat
bash cybertuz.sh
```

### Language reverts to English every time

The `logs/` directory must be writable:
```bash
ls -la logs/
chmod 755 logs/
```

---

## Module Issues

### `nmap: command not found`

```bash
pkg install nmap
```

Note: Some nmap options (e.g., `-sS` SYN scan) require root. CyberTuz uses TCP connect scan (`-sT`) which works without root.

### `dig: command not found` or `nslookup: command not found`

```bash
pkg install dnsutils
```

### `curl: command not found`

```bash
pkg install curl
```

### `whois: command not found`

```bash
pkg install whois
```

### `python3: command not found`

```bash
pkg install python3
```

### Module exits immediately without showing content

Run with bash explicitly and check for syntax errors:
```bash
bash -n modules/16_training_arena.sh
bash modules/16_training_arena.sh
```

---

## Progress and Logs

### My Training Arena progress was reset

Check if `logs/latihan_progress.dat` exists:
```bash
cat logs/latihan_progress.dat
```

If it was accidentally deleted, progress cannot be recovered. The file is a plain text list of completed level keys.

### `logs/` directory does not exist

CyberTuz creates it automatically on first run. If it still does not exist:
```bash
mkdir -p logs
```

### Session log is growing very large

You can safely truncate it:
```bash
> logs/cybertuz.log
```

---

## Live Practice Issues

### `scanme.nmap.org` scan is very slow

nmap scans over mobile connections can be slow. Try reducing the scan scope:

The modules use `nmap -sT -T4` which is already optimized for speed. If still slow, check your mobile data connection quality.

### DNS lookups return no results

Check your internet connection:
```bash
ping -c 3 8.8.8.8
```

If ping works but DNS fails:
```bash
pkg install dnsutils
dig @8.8.8.8 google.com
```

### HTTP requests fail or time out

Check if curl can reach the internet:
```bash
curl -I https://google.com
```

If behind a proxy or VPN, configure Termux to use it.

---

## Still Having Issues?

If your problem is not listed here:

1. Check [FAQ.md](FAQ.md)
2. Search [GitHub Issues](https://github.com/djunekz/cybertuz/issues)
3. Open a [Support Request](https://github.com/djunekz/cybertuz/issues/new?template=support_request.yml) with full details

When reporting, always include:
- Output of `termux-info` (if available)
- Android version
- Exact error message
- Steps to reproduce

---

*Last updated: 2025*
