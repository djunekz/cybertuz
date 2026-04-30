#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -ne "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() {
    clear
    echo -e "${RED}"
    echo "  ================================================================="
    echo "                $CT_M14"
    echo "  ================================================================="
    echo -e "${RESET}"
}

install_tools() {
    header
    echo -e "${CYAN}  $CT_M14_1${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_UPDATE${RESET}"
    echo -e "${WHITE}  pkg update && pkg upgrade${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_BASIC_TOOLS${RESET}"
    echo -e "${YELLOW}  pkg install nmap curl wget git python3 openssl${RESET}"
    echo -e "${YELLOW}  pkg install dnsutils whois netcat-openbsd${RESET}"
    echo -e "${YELLOW}  pkg install binutils${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_ADV_TOOLS${RESET}"
    echo -e "${YELLOW}  pkg install hydra     ($CT_C_T14_BRUTE)${RESET}"
    echo -e "${YELLOW}  pkg install john      ($CT_C_T14_PWD_CRACK)${RESET}"
    echo -e "${YELLOW}  pkg install nikto     ($CT_C_T14_WEB_SCAN)${RESET}"
    echo -e "${YELLOW}  pkg install sqlmap    ($CT_C_T14_SQLI)${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_PY_TOOLS${RESET}"
    echo -e "${YELLOW}  pip install scapy     ($CT_C_T14_SCAPY)${RESET}"
    echo -e "${YELLOW}  pip install requests  ($CT_C_T14_REQ)${RESET}"
    echo -e "${YELLOW}  pip install impacket  ($CT_C_T14_IMP)${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_T14_INSTALL_NOW (y/n): ${RESET}"
    read -r install_ans
    if [[ "$install_ans" == "y" || "$install_ans" == "yes" ]]; then
        echo -e "${CYAN}  $CT_C_T14_INSTALLING${RESET}"
        pkg install -y nmap curl wget git python3 openssl dnsutils 2>/dev/null
        echo -e "${GREEN}  $CT_SUCCESS${RESET}"
    fi
    press_enter
}

nmap_cheatsheet() {
    header
    echo -e "${CYAN}  $CT_M14_2${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_BASIC_SCAN${RESET}"
    echo -e "${WHITE}  nmap target                    $CT_C_T14_SCAN_1000${RESET}"
    echo -e "${WHITE}  nmap -p 80 target              $CT_C_T14_SCAN_PORT${RESET}"
    echo -e "${WHITE}  nmap -p 1-65535 target         $CT_C_T14_SCAN_ALL${RESET}"
    echo -e "${WHITE}  nmap -p- target                $CT_C_T14_SCAN_ALL (shortcut)${RESET}"
    echo ""
    echo -e "${GREEN}  SCAN METHODS:${RESET}"
    echo -e "${WHITE}  nmap -sS target                SYN scan (stealth)${RESET}"
    echo -e "${WHITE}  nmap -sT target                TCP connect scan${RESET}"
    echo -e "${WHITE}  nmap -sU target                UDP scan${RESET}"
    echo -e "${WHITE}  nmap -sP target                Ping scan${RESET}"
    echo ""
    echo -e "${GREEN}  DETECTION:${RESET}"
    echo -e "${WHITE}  nmap -sV target                $CT_C_T14_SVC_VER${RESET}"
    echo -e "${WHITE}  nmap -O  target                $CT_C_T14_OS_DET${RESET}"
    echo -e "${WHITE}  nmap -A  target                $CT_C_T14_AGGR${RESET}"
    echo ""
    echo -e "${GREEN}  OUTPUT:${RESET}"
    echo -e "${WHITE}  nmap -oN out.txt target        $CT_C_T14_OUT_TXT${RESET}"
    echo -e "${WHITE}  nmap -oX out.xml target        $CT_C_T14_OUT_XML${RESET}"
    echo -e "${WHITE}  nmap -oG out.grep target       $CT_C_T14_OUT_GREP${RESET}"
    echo ""
    echo -e "${GREEN}  NSE SCRIPTS:${RESET}"
    echo -e "${WHITE}  nmap --script=vuln target      $CT_C_T14_NSE_VULN${RESET}"
    echo -e "${WHITE}  nmap --script=http-enum target $CT_C_T14_NSE_HTTP${RESET}"
    echo -e "${WHITE}  nmap --script=smb-vuln* target $CT_C_T14_NSE_SMB${RESET}"
    echo ""
    echo -e "${GREEN}  EVASION:${RESET}"
    echo -e "${WHITE}  nmap -D RND:10 target          $CT_C_T14_DECOY${RESET}"
    echo -e "${WHITE}  nmap -f target                 $CT_C_T14_FRAG${RESET}"
    echo -e "${WHITE}  nmap --data-length 200 target  $CT_C_T14_RAND_DATA${RESET}"
    press_enter
}

curl_cheatsheet() {
    header
    echo -e "${CYAN}  $CT_M14_3${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_BASIC_REQ${RESET}"
    echo -e "${WHITE}  curl http://target.com                 GET request${RESET}"
    echo -e "${WHITE}  curl -I http://target.com              $CT_C_T14_CURL_HEAD${RESET}"
    echo -e "${WHITE}  curl -v http://target.com              $CT_C_T14_CURL_VERB${RESET}"
    echo -e "${WHITE}  curl -L http://target.com              $CT_C_T14_CURL_REDIR${RESET}"
    echo ""
    echo -e "${GREEN}  POST REQUEST:${RESET}"
    echo -e "${WHITE}  curl -X POST -d 'user=admin&pass=123' http://target.com/login${RESET}"
    echo -e "${WHITE}  curl -X POST -H 'Content-Type: application/json' -d '{\"k\":\"v\"}' url${RESET}"
    echo ""
    echo -e "${GREEN}  HEADERS & COOKIES:${RESET}"
    echo -e "${WHITE}  curl -H 'Authorization: Bearer token' url${RESET}"
    echo -e "${WHITE}  curl -b 'session=abc123' url${RESET}"
    echo -e "${WHITE}  curl -c cookies.txt -b cookies.txt url${RESET}"
    echo ""
    echo -e "${GREEN}  SSL & PROXY:${RESET}"
    echo -e "${WHITE}  curl -k url                            $CT_C_T14_SKIP_SSL${RESET}"
    echo -e "${WHITE}  curl --proxy http://127.0.0.1:8080 url $CT_C_T14_PROXY${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_DL_UL${RESET}"
    echo -e "${WHITE}  curl -o output.html url                $CT_C_T14_DOWNLOAD${RESET}"
    echo -e "${WHITE}  curl -F 'file=@/path/file.txt' url     $CT_C_T14_UPLOAD${RESET}"
    press_enter
}

python_security_scripts() {
    header
    echo -e "${CYAN}  $CT_M14_4${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_PY_SCANNER${RESET}"
    echo -e "${YELLOW}  #!/usr/bin/env python3${RESET}"
    echo -e "${YELLOW}  import socket, sys${RESET}"
    echo -e "${YELLOW}  target = sys.argv[1]${RESET}"
    echo -e "${YELLOW}  for port in range(1, 1025):${RESET}"
    echo -e "${YELLOW}      sock = socket.socket()${RESET}"
    echo -e "${YELLOW}      sock.settimeout(1)${RESET}"
    echo -e "${YELLOW}      if sock.connect_ex((target, port)) == 0:${RESET}"
    echo -e "${YELLOW}          print(f'Port {port}: OPEN')${RESET}"
    echo -e "${YELLOW}      sock.close()${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_PY_SUBDOMAIN${RESET}"
    echo -e "${YELLOW}  import socket${RESET}"
    echo -e "${YELLOW}  subs = ['www','mail','ftp','admin','dev','api']${RESET}"
    echo -e "${YELLOW}  domain = 'target.com'${RESET}"
    echo -e "${YELLOW}  for sub in subs:${RESET}"
    echo -e "${YELLOW}      try:${RESET}"
    echo -e "${YELLOW}          ip = socket.gethostbyname(f'{sub}.{domain}')${RESET}"
    echo -e "${YELLOW}          print(f'[FOUND] {sub}.{domain} -> {ip}')${RESET}"
    echo -e "${YELLOW}      except: pass${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_T14_RUN_SCANNER (y/n): ${RESET}"
    read -r py_ans
    if [[ "$py_ans" == "y" || "$py_ans" == "yes" ]]; then
        scanner_file="/tmp/ct_scanner.py"
        cat > "$scanner_file" << 'PYEOF'
import socket
target = input("Enter target IP/domain: ")
print(f"\nScanning {target}...\n")
common_ports = [21,22,23,25,53,80,110,143,443,445,3306,3389,8080,8443]
for port in common_ports:
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    if sock.connect_ex((target, port)) == 0:
        print(f"Port {port:5}: OPEN")
    sock.close()
print("\nDone.")
PYEOF
        python3 "$scanner_file"
    fi
    press_enter
}

linux_privesc_cheatsheet() {
    header
    echo -e "${CYAN}  $CT_M14_5${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_T14_PRIVESC_INTRO${RESET}"
    echo ""
    echo -e "${GREEN}  ENUMERATION:${RESET}"
    echo -e "${WHITE}  id                         $CT_C_T14_WHO_AM_I${RESET}"
    echo -e "${WHITE}  whoami                     Username${RESET}"
    echo -e "${WHITE}  uname -a                   $CT_C_T14_KERNEL_INFO${RESET}"
    echo -e "${WHITE}  cat /etc/passwd            $CT_C_T14_USER_LIST${RESET}"
    echo -e "${WHITE}  cat /etc/shadow            $CT_C_T14_PWD_HASH${RESET}"
    echo -e "${WHITE}  sudo -l                    $CT_C_T14_SUDO_LIST${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_FIND_SUID${RESET}"
    echo -e "${WHITE}  find / -perm -4000 2>/dev/null${RESET}"
    echo -e "${WHITE}  find / -perm -2000 2>/dev/null${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_T14_FIND_WRITABLE${RESET}"
    echo -e "${WHITE}  find / -writable -type f 2>/dev/null | grep -v proc${RESET}"
    echo ""
    echo -e "${GREEN}  CRON JOBS:${RESET}"
    echo -e "${WHITE}  cat /etc/crontab | ls -la /etc/cron*${RESET}"
    echo ""
    echo -e "${CYAN}  $CT_C_T14_CURRENT_SYS${RESET}"
    uname -a 2>/dev/null
    id 2>/dev/null
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                $CT_M14${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M14_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M14_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M14_3${RESET}"
    echo -e "${GREEN}  [4] $CT_M14_4${RESET}"
    echo -e "${GREEN}  [5] $CT_M14_5${RESET}"
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
