#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$CYBERTUZ_DIR/modules"
LOG_DIR="$CYBERTUZ_DIR/logs"
REPORT_DIR="$CYBERTUZ_DIR/reports"

mkdir -p "$LOG_DIR" "$REPORT_DIR"

log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_DIR/cybertuz.log"
}

banner() {
    clear
    echo -e "${RED}"
    echo "  ██████╗██╗   ██╗██████╗ ███████╗██████╗ ████████╗██╗   ██╗███████╗"
    echo " ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║   ██║╚══███╔╝"
    echo " ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝   ██║   ██║   ██║  ███╔╝ "
    echo " ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗   ██║   ██║   ██║ ███╔╝  "
    echo " ╚██████╗   ██║   ██████╔╝███████╗██║  ██║   ██║   ╚██████╔╝███████╗"
    echo "  ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝"
    echo -e "${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}        Platform Belajar Cyber Security Lengkap untuk Termux${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${YELLOW}        Untuk Tujuan Edukasi dan Etika Hacking${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
}

disclaimer() {
    banner
    echo -e "${RED}  DISCLAIMER & PERNYATAAN ETIKA${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  CyberTuz adalah platform edukasi cyber security untuk Termux.${RESET}"
    echo -e "${WHITE}  Semua materi dirancang untuk pembelajaran yang legal dan etis.${RESET}"
    echo ""
    echo -e "${YELLOW}  ATURAN PENGGUNAAN:${RESET}"
    echo -e "${GREEN}  [+] Gunakan HANYA pada sistem yang kamu miliki atau sudah ada izin${RESET}"
    echo -e "${GREEN}  [+] Semua praktik hanya untuk tujuan pembelajaran${RESET}"
    echo -e "${GREEN}  [+] Jangan gunakan teknik ini untuk menyerang sistem orang lain${RESET}"
    echo -e "${GREEN}  [+] Patuhi UU ITE No. 11 Tahun 2008 dan hukum yang berlaku${RESET}"
    echo ""
    echo -e "${RED}  PERINGATAN: Menyerang sistem tanpa izin adalah KEJAHATAN!${RESET}"
    echo ""
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -ne "${WHITE}  Apakah kamu setuju dengan ketentuan di atas? (ya/tidak): ${RESET}"
    read -r agreement
    if [[ "$agreement" != "ya" && "$agreement" != "YA" && "$agreement" != "y" && "$agreement" != "Y" ]]; then
        echo -e "${RED}  Keluar dari CyberTuz.${RESET}"
        exit 0
    fi
    log_action "User menyetujui disclaimer dan memulai sesi"
}

main_menu() {
    while true; do
        banner
        echo -e "${CYAN}  =================================================================${RESET}"
        echo -e "${WHITE}                       MENU UTAMA CYBERTUZ${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        echo ""
        echo -e "${GREEN}  [1]  Teori Dasar Cyber Security${RESET}"
        echo -e "${GREEN}  [2]  Reconnaissance & Information Gathering${RESET}"
        echo -e "${GREEN}  [3]  Network Scanning & Enumeration${RESET}"
        echo -e "${GREEN}  [4]  Vulnerability Assessment${RESET}"
        echo -e "${GREEN}  [5]  Web Application Security${RESET}"
        echo -e "${GREEN}  [6]  Kriptografi & Enkripsi${RESET}"
        echo -e "${GREEN}  [7]  Password Security & Cracking${RESET}"
        echo -e "${GREEN}  [8]  Social Engineering Awareness${RESET}"
        echo -e "${GREEN}  [9]  Network Security & Firewall${RESET}"
        echo -e "${GREEN}  [10] Wireless Security${RESET}"
        echo -e "${GREEN}  [11] Forensik Digital${RESET}"
        echo -e "${GREEN}  [12] Malware Analysis Basics${RESET}"
        echo -e "${GREEN}  [13] CTF & Tantangan Latihan${RESET}"
        echo -e "${GREEN}  [14] Tools & Cheatsheet Lengkap${RESET}"
        echo -e "${GREEN}  [15] Laporan & Progress Belajar${RESET}"
        echo -e "${YELLOW}  [0]  Keluar${RESET}"
        echo ""
        echo -e "${CYAN}  =================================================================${RESET}"
        echo -ne "${WHITE}  Pilih menu [0-15]: ${RESET}"
        read -r choice
        case $choice in
            1) bash "$MODULES_DIR/01_teori_dasar.sh" ;;
            2) bash "$MODULES_DIR/02_reconnaissance.sh" ;;
            3) bash "$MODULES_DIR/03_network_scanning.sh" ;;
            4) bash "$MODULES_DIR/04_vulnerability.sh" ;;
            5) bash "$MODULES_DIR/05_web_security.sh" ;;
            6) bash "$MODULES_DIR/06_kriptografi.sh" ;;
            7) bash "$MODULES_DIR/07_password_security.sh" ;;
            8) bash "$MODULES_DIR/08_social_engineering.sh" ;;
            9) bash "$MODULES_DIR/09_network_security.sh" ;;
            10) bash "$MODULES_DIR/10_wireless_security.sh" ;;
            11) bash "$MODULES_DIR/11_forensik.sh" ;;
            12) bash "$MODULES_DIR/12_malware_analysis.sh" ;;
            13) bash "$MODULES_DIR/13_ctf_latihan.sh" ;;
            14) bash "$MODULES_DIR/14_tools_cheatsheet.sh" ;;
            15) bash "$MODULES_DIR/15_laporan.sh" ;;
            0) echo -e "${YELLOW}  Terima kasih telah menggunakan CyberTuz!${RESET}"; log_action "User keluar dari CyberTuz"; exit 0 ;;
            *) echo -e "${RED}  Pilihan tidak valid!${RESET}"; sleep 1 ;;
        esac
    done
}

disclaimer
main_menu
