#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -ne "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                TOOLS & CHEATSHEET LENGKAP"; echo "  ================================================================="; echo -e "${RESET}"; }

install_tools() {
    header
    echo -e "${CYAN}  INSTALASI TOOLS SECURITY DI TERMUX${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  UPDATE TERMUX DULU:${RESET}"
    echo -e "${WHITE}  pkg update && pkg upgrade${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS DASAR:${RESET}"
    echo -e "${YELLOW}  pkg install nmap curl wget git python3 openssl${RESET}"
    echo -e "${YELLOW}  pkg install dnsutils whois netcat-openbsd${RESET}"
    echo -e "${YELLOW}  pkg install binutils  (untuk strings, objdump)${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS LANJUTAN:${RESET}"
    echo -e "${YELLOW}  pkg install hydra     (brute force)${RESET}"
    echo -e "${YELLOW}  pkg install john      (password cracker)${RESET}"
    echo -e "${YELLOW}  pkg install nikto     (web scanner)${RESET}"
    echo -e "${YELLOW}  pkg install sqlmap    (SQL injection)${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS PYTHON (pip):${RESET}"
    echo -e "${YELLOW}  pip install scapy     (packet manipulation)${RESET}"
    echo -e "${YELLOW}  pip install requests  (HTTP requests)${RESET}"
    echo -e "${YELLOW}  pip install impacket  (network protocols)${RESET}"
    echo ""
    echo -ne "${WHITE}  Mau install tools dasar sekarang? (ya/tidak): ${RESET}"
    read -r install_ans
    if [[ "$install_ans" == "ya" || "$install_ans" == "y" ]]; then
        echo -e "${CYAN}  Menginstall tools dasar...${RESET}"
        pkg install -y nmap curl wget git python3 openssl dnsutils 2>/dev/null
        echo -e "${GREEN}  Selesai!${RESET}"
    fi
    press_enter
}

nmap_cheatsheet() {
    header
    echo -e "${CYAN}  NMAP CHEATSHEET LENGKAP${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  SCAN DASAR:${RESET}"
    echo -e "${WHITE}  nmap target                    Scan 1000 port populer${RESET}"
    echo -e "${WHITE}  nmap -p 80 target              Scan port spesifik${RESET}"
    echo -e "${WHITE}  nmap -p 1-65535 target         Scan semua port${RESET}"
    echo -e "${WHITE}  nmap -p- target                Scan semua port (shortcut)${RESET}"
    echo ""
    echo -e "${GREEN}  SCAN METHODS:${RESET}"
    echo -e "${WHITE}  nmap -sS target                SYN scan (stealth)${RESET}"
    echo -e "${WHITE}  nmap -sT target                TCP connect scan${RESET}"
    echo -e "${WHITE}  nmap -sU target                UDP scan${RESET}"
    echo -e "${WHITE}  nmap -sP target                Ping scan (host discovery)${RESET}"
    echo ""
    echo -e "${GREEN}  DETECTION:${RESET}"
    echo -e "${WHITE}  nmap -sV target                Service/version detection${RESET}"
    echo -e "${WHITE}  nmap -O target                 OS detection${RESET}"
    echo -e "${WHITE}  nmap -A target                 Aggressive (OS+version+scripts)${RESET}"
    echo ""
    echo -e "${GREEN}  OUTPUT:${RESET}"
    echo -e "${WHITE}  nmap -oN output.txt target     Save ke text file${RESET}"
    echo -e "${WHITE}  nmap -oX output.xml target     Save ke XML${RESET}"
    echo -e "${WHITE}  nmap -oG output.grep target    Save ke grepable format${RESET}"
    echo ""
    echo -e "${GREEN}  NSE SCRIPTS:${RESET}"
    echo -e "${WHITE}  nmap --script=vuln target      Scan kerentanan umum${RESET}"
    echo -e "${WHITE}  nmap --script=http-enum target Enumerate web paths${RESET}"
    echo -e "${WHITE}  nmap --script=smb-vuln* target SMB vulnerabilities${RESET}"
    echo ""
    echo -e "${GREEN}  EVASION:${RESET}"
    echo -e "${WHITE}  nmap -D RND:10 target          Decoy scan${RESET}"
    echo -e "${WHITE}  nmap -f target                 Fragment packets${RESET}"
    echo -e "${WHITE}  nmap --data-length 200 target  Append random data${RESET}"
    press_enter
}

curl_cheatsheet() {
    header
    echo -e "${CYAN}  CURL CHEATSHEET UNTUK WEB TESTING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  REQUEST DASAR:${RESET}"
    echo -e "${WHITE}  curl http://target.com                 GET request${RESET}"
    echo -e "${WHITE}  curl -I http://target.com              Hanya headers${RESET}"
    echo -e "${WHITE}  curl -v http://target.com              Verbose output${RESET}"
    echo -e "${WHITE}  curl -L http://target.com              Follow redirect${RESET}"
    echo ""
    echo -e "${GREEN}  POST REQUEST:${RESET}"
    echo -e "${WHITE}  curl -X POST -d 'user=admin&pass=123' http://target.com/login${RESET}"
    echo -e "${WHITE}  curl -X POST -H 'Content-Type: application/json' -d '{\"key\":\"val\"}' url${RESET}"
    echo ""
    echo -e "${GREEN}  HEADERS & COOKIES:${RESET}"
    echo -e "${WHITE}  curl -H 'Authorization: Bearer token' url${RESET}"
    echo -e "${WHITE}  curl -b 'session=abc123' url${RESET}"
    echo -e "${WHITE}  curl -c cookies.txt -b cookies.txt url${RESET}"
    echo ""
    echo -e "${GREEN}  SSL & PROXY:${RESET}"
    echo -e "${WHITE}  curl -k url                            Skip SSL verification${RESET}"
    echo -e "${WHITE}  curl --proxy http://127.0.0.1:8080 url Via proxy (Burp Suite)${RESET}"
    echo ""
    echo -e "${GREEN}  UPLOAD & DOWNLOAD:${RESET}"
    echo -e "${WHITE}  curl -o output.html url                Download ke file${RESET}"
    echo -e "${WHITE}  curl -F 'file=@/path/file.txt' url     Upload file${RESET}"
    press_enter
}

python_security_scripts() {
    header
    echo -e "${CYAN}  PYTHON SECURITY SCRIPTS${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  SCRIPT PORT SCANNER SEDERHANA:${RESET}"
    echo -e "${YELLOW}  #!/usr/bin/env python3${RESET}"
    echo -e "${YELLOW}  import socket${RESET}"
    echo -e "${YELLOW}  import sys${RESET}"
    echo -e "${YELLOW}  target = sys.argv[1]${RESET}"
    echo -e "${YELLOW}  for port in range(1, 1025):${RESET}"
    echo -e "${YELLOW}      sock = socket.socket()${RESET}"
    echo -e "${YELLOW}      sock.settimeout(1)${RESET}"
    echo -e "${YELLOW}      result = sock.connect_ex((target, port))${RESET}"
    echo -e "${YELLOW}      if result == 0:${RESET}"
    echo -e "${YELLOW}          print(f'Port {port}: OPEN')${RESET}"
    echo -e "${YELLOW}      sock.close()${RESET}"
    echo ""
    echo -e "${GREEN}  SCRIPT CEK SUBDOMAIN:${RESET}"
    echo -e "${YELLOW}  import socket${RESET}"
    echo -e "${YELLOW}  subs = ['www','mail','ftp','admin','dev','test','api']${RESET}"
    echo -e "${YELLOW}  domain = 'target.com'${RESET}"
    echo -e "${YELLOW}  for sub in subs:${RESET}"
    echo -e "${YELLOW}      try:${RESET}"
    echo -e "${YELLOW}          ip = socket.gethostbyname(f'{sub}.{domain}')${RESET}"
    echo -e "${YELLOW}          print(f'[FOUND] {sub}.{domain} -> {ip}')${RESET}"
    echo -e "${YELLOW}      except: pass${RESET}"
    echo ""
    echo -ne "${WHITE}  Mau generate dan jalankan port scanner Python? (ya/tidak): ${RESET}"
    read -r py_ans
    if [[ "$py_ans" == "ya" || "$py_ans" == "y" ]]; then
        scanner_file="/tmp/cybertuz_scanner.py"
        cat > "$scanner_file" << 'PYEOF'
import socket
import sys

target = input("Masukkan target IP/domain: ")
print(f"\nScanning {target}...\n")
common_ports = [21,22,23,25,53,80,110,143,443,445,3306,3389,8080,8443]
for port in common_ports:
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    result = sock.connect_ex((target, port))
    if result == 0:
        print(f"Port {port:5}: OPEN")
    sock.close()
print("\nScan selesai!")
PYEOF
        python3 "$scanner_file"
    fi
    press_enter
}

linux_privesc_cheatsheet() {
    header
    echo -e "${CYAN}  LINUX PRIVILEGE ESCALATION CHEATSHEET${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Setelah mendapat akses ke sistem, cari cara untuk eskalasi privilege.${RESET}"
    echo ""
    echo -e "${GREEN}  ENUMERATION:${RESET}"
    echo -e "${WHITE}  id                         Siapa kamu?${RESET}"
    echo -e "${WHITE}  whoami                     Username${RESET}"
    echo -e "${WHITE}  uname -a                   Info kernel dan OS${RESET}"
    echo -e "${WHITE}  cat /etc/passwd            Daftar user${RESET}"
    echo -e "${WHITE}  cat /etc/shadow            Password hash (butuh root)${RESET}"
    echo -e "${WHITE}  sudo -l                    Command yang bisa dijalankan sebagai root${RESET}"
    echo ""
    echo -e "${GREEN}  CARI FILE SUID/SGID:${RESET}"
    echo -e "${WHITE}  find / -perm -4000 2>/dev/null${RESET}"
    echo -e "${WHITE}  find / -perm -2000 2>/dev/null${RESET}"
    echo ""
    echo -e "${GREEN}  CARI FILE WRITABLE:${RESET}"
    echo -e "${WHITE}  find / -writable -type f 2>/dev/null | grep -v proc${RESET}"
    echo ""
    echo -e "${GREEN}  CRON JOBS:${RESET}"
    echo -e "${WHITE}  cat /etc/crontab${RESET}"
    echo -e "${WHITE}  ls -la /etc/cron*${RESET}"
    echo ""
    echo -e "${GREEN}  INFORMASI SISTEM:${RESET}"
    echo ""
    echo -e "${CYAN}  Sistem kamu saat ini:${RESET}"
    uname -a 2>/dev/null
    id 2>/dev/null
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                TOOLS & CHEATSHEET LENGKAP${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] Instalasi Tools Security di Termux${RESET}"
    echo -e "${GREEN}  [2] Nmap Cheatsheet Lengkap${RESET}"
    echo -e "${GREEN}  [3] Curl Cheatsheet untuk Web Testing${RESET}"
    echo -e "${GREEN}  [4] Python Security Scripts${RESET}"
    echo -e "${GREEN}  [5] Linux Privilege Escalation Cheatsheet${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"
    read -r pilihan
    case $pilihan in
        1) install_tools ;;
        2) nmap_cheatsheet ;;
        3) curl_cheatsheet ;;
        4) python_security_scripts ;;
        5) linux_privesc_cheatsheet ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
