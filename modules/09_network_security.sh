#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "               NETWORK SECURITY & FIREWALL"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_firewall() {
    header
    echo -e "${CYAN}  FIREWALL - PERTAHANAN JARINGAN${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Firewall adalah sistem keamanan yang memantau dan mengontrol${RESET}"
    echo -e "${WHITE}  traffic jaringan berdasarkan aturan keamanan yang ditentukan.${RESET}"
    echo ""
    echo -e "${GREEN}  JENIS FIREWALL:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Packet Filter Firewall${RESET}"
    echo -e "${WHITE}     Memeriksa header paket (IP, port, protokol).${RESET}"
    echo -e "${WHITE}     Cepat tapi tidak bisa lihat isi paket.${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Stateful Inspection Firewall${RESET}"
    echo -e "${WHITE}     Melacak state koneksi (apakah ini bagian dari session sah?).${RESET}"
    echo -e "${WHITE}     Lebih aman dari packet filter.${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Application Layer Firewall (WAF)${RESET}"
    echo -e "${WHITE}     Menganalisis konten aplikasi (HTTP, SQL, dll).${RESET}"
    echo -e "${WHITE}     Dapat mencegah SQLi, XSS, dll.${RESET}"
    echo ""
    echo -e "${YELLOW}  4. Next-Generation Firewall (NGFW)${RESET}"
    echo -e "${WHITE}     Menggabungkan semua tipe + IPS, DPI, User Identity.${RESET}"
    echo ""
    echo -e "${GREEN}  IPTABLES - FIREWALL LINUX:${RESET}"
    echo ""
    echo -e "${WHITE}  Lihat rules aktif:${RESET}"
    echo -e "${YELLOW}  iptables -L -n -v${RESET}"
    echo ""
    echo -e "${WHITE}  Blokir IP tertentu:${RESET}"
    echo -e "${YELLOW}  iptables -A INPUT -s 192.168.1.100 -j DROP${RESET}"
    echo ""
    echo -e "${WHITE}  Izinkan port tertentu:${RESET}"
    echo -e "${YELLOW}  iptables -A INPUT -p tcp --dport 80 -j ACCEPT${RESET}"
    echo ""
    echo -e "${WHITE}  Blokir semua incoming, izinkan outgoing:${RESET}"
    echo -e "${YELLOW}  iptables -P INPUT DROP${RESET}"
    echo -e "${YELLOW}  iptables -P OUTPUT ACCEPT${RESET}"
    echo -e "${YELLOW}  iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT${RESET}"
    press_enter
}

praktik_network_analysis() {
    header
    echo -e "${CYAN}  ANALISIS JARINGAN LOKAL${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  CEK KONEKSI AKTIF:${RESET}"
    echo ""
    if command -v netstat &>/dev/null; then
        echo -e "${CYAN}  Koneksi jaringan aktif:${RESET}"
        netstat -tuln 2>/dev/null | head -20
    elif command -v ss &>/dev/null; then
        echo -e "${CYAN}  Koneksi jaringan aktif:${RESET}"
        ss -tuln 2>/dev/null | head -20
    fi
    echo ""
    echo -e "${GREEN}  INFORMASI ROUTING:${RESET}"
    if command -v ip &>/dev/null; then
        ip route 2>/dev/null | head -10
    fi
    echo ""
    echo -e "${GREEN}  DNS YANG DIGUNAKAN:${RESET}"
    cat /etc/resolv.conf 2>/dev/null | grep nameserver | head -5
    echo ""
    echo -e "${GREEN}  ARP TABLE (Device di jaringan lokal):${RESET}"
    if command -v arp &>/dev/null; then
        arp -a 2>/dev/null | head -15
    fi
    press_enter
}

mitm_awareness() {
    header
    echo -e "${CYAN}  MAN-IN-THE-MIDDLE ATTACK${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  MitM adalah serangan dimana penyerang berada di antara${RESET}"
    echo -e "${WHITE}  dua pihak yang berkomunikasi tanpa sepengetahuan mereka.${RESET}"
    echo ""
    echo -e "${GREEN}  TEKNIK MitM:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. ARP Spoofing/Poisoning${RESET}"
    echo -e "${WHITE}     Mengirim ARP reply palsu untuk mengarahkan traffic ke penyerang.${RESET}"
    echo -e "${WHITE}     Tool: arpspoof, ettercap${RESET}"
    echo -e "${WHITE}     arpspoof -i eth0 -t 192.168.1.1 192.168.1.100${RESET}"
    echo ""
    echo -e "${YELLOW}  2. DNS Spoofing${RESET}"
    echo -e "${WHITE}     Memanipulasi cache DNS untuk mengarahkan ke IP palsu.${RESET}"
    echo ""
    echo -e "${YELLOW}  3. SSL Stripping${RESET}"
    echo -e "${WHITE}     Downgrade HTTPS ke HTTP untuk intercept traffic terenkripsi.${RESET}"
    echo -e "${WHITE}     Tool: sslstrip${RESET}"
    echo ""
    echo -e "${YELLOW}  4. Evil Twin (Wi-Fi)${RESET}"
    echo -e "${WHITE}     Membuat hotspot palsu dengan nama sama seperti asli.${RESET}"
    echo ""
    echo -e "${GREEN}  PENCEGAHAN MitM:${RESET}"
    echo -e "${WHITE}  - Gunakan HTTPS (pastikan ada kunci di browser)${RESET}"
    echo -e "${WHITE}  - Verifikasi certificate SSL${RESET}"
    echo -e "${WHITE}  - Hindari Wi-Fi publik untuk transaksi sensitif${RESET}"
    echo -e "${WHITE}  - Gunakan VPN${RESET}"
    echo -e "${WHITE}  - HTTP Strict Transport Security (HSTS)${RESET}"
    echo -e "${WHITE}  - Certificate pinning di aplikasi mobile${RESET}"
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               NETWORK SECURITY & FIREWALL${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M9_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M9_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M9_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_firewall ;;
        2) praktik_network_analysis ;;
        3) mitm_awareness ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
