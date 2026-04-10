#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                    WIRELESS SECURITY"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_wifi() {
    header
    echo -e "${CYAN}  KEAMANAN JARINGAN WIRELESS${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Wi-Fi menggunakan gelombang radio yang bisa disadap oleh siapapun${RESET}"
    echo -e "${WHITE}  dalam jangkauan sinyal. Keamanan sangat penting!${RESET}"
    echo ""
    echo -e "${GREEN}  PROTOKOL KEAMANAN WI-FI:${RESET}"
    echo ""
    echo -e "${RED}  WEP (Wired Equivalent Privacy) - JANGAN GUNAKAN${RESET}"
    echo -e "${WHITE}  Protokol lama yang sudah retak. Bisa di-crack dalam menit.${RESET}"
    echo -e "${WHITE}  RC4 cipher dengan implementasi yang lemah.${RESET}"
    echo ""
    echo -e "${YELLOW}  WPA (Wi-Fi Protected Access)${RESET}"
    echo -e "${WHITE}  Lebih baik dari WEP tapi masih rentan terhadap serangan.${RESET}"
    echo -e "${WHITE}  Menggunakan TKIP yang sudah terkompromi.${RESET}"
    echo ""
    echo -e "${GREEN}  WPA2 - Standar Saat Ini${RESET}"
    echo -e "${WHITE}  Menggunakan AES-CCMP yang kuat.${RESET}"
    echo -e "${WHITE}  Rentan terhadap: brute force handshake, KRACK${RESET}"
    echo ""
    echo -e "${GREEN}  WPA3 - Paling Aman${RESET}"
    echo -e "${WHITE}  SAE (Simultaneous Authentication of Equals) menggantikan PSK.${RESET}"
    echo -e "${WHITE}  Proteksi terhadap offline dictionary attack.${RESET}"
    echo ""
    echo -e "${GREEN}  SERANGAN TERHADAP WI-FI:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. WPA2 Handshake Capture${RESET}"
    echo -e "${WHITE}     Capture 4-way handshake lalu brute force offline.${RESET}"
    echo -e "${WHITE}     Tool: aircrack-ng, hashcat${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Evil Twin / Rogue AP${RESET}"
    echo -e "${WHITE}     Buat access point palsu dengan nama sama.${RESET}"
    echo -e "${WHITE}     Korban connect ke AP penyerang.${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Deauthentication Attack${RESET}"
    echo -e "${WHITE}     Paksa client disconnect untuk capture handshake saat reconnect.${RESET}"
    echo ""
    echo -e "${GREEN}  TIPS KEAMANAN WI-FI:${RESET}"
    echo -e "${WHITE}  - Gunakan WPA3 atau WPA2 dengan password kuat${RESET}"
    echo -e "${WHITE}  - Sembunyikan SSID (tidak 100% efektif)${RESET}"
    echo -e "${WHITE}  - MAC address filtering (bisa di-bypass)${RESET}"
    echo -e "${WHITE}  - Gunakan VPN di jaringan publik${RESET}"
    echo -e "${WHITE}  - Update firmware router secara berkala${RESET}"
    echo -e "${WHITE}  - Pisahkan network tamu dari network utama${RESET}"
    press_enter
}

wifi_scanner() {
    header
    echo -e "${CYAN}  WIFI SCANNER - ANALISIS JARINGAN SEKITAR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Kita bisa menganalisis jaringan Wi-Fi di sekitar kita.${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS UNTUK WIFI SCANNING:${RESET}"
    echo ""
    echo -e "${YELLOW}  nmcli (Network Manager CLI):${RESET}"
    echo -e "${WHITE}  nmcli dev wifi list${RESET}"
    echo ""
    echo -e "${YELLOW}  iwlist:${RESET}"
    echo -e "${WHITE}  iwlist wlan0 scan | grep -E 'SSID|Quality|Encryption'${RESET}"
    echo ""
    echo -e "${YELLOW}  aircrack-ng suite:${RESET}"
    echo -e "${WHITE}  airmon-ng start wlan0       (aktifkan monitor mode)${RESET}"
    echo -e "${WHITE}  airodump-ng wlan0mon         (scan network)${RESET}"
    echo ""
    echo -e "${GREEN}  MENCEK KEAMANAN ROUTER:${RESET}"
    echo ""
    echo -e "${WHITE}  Hal yang perlu dicek:${RESET}"
    echo -e "${WHITE}  1. Protokol keamanan (WPA2/WPA3)${RESET}"
    echo -e "${WHITE}  2. Firmware router up to date${RESET}"
    echo -e "${WHITE}  3. Default password sudah diganti${RESET}"
    echo -e "${WHITE}  4. Remote management disabled${RESET}"
    echo -e "${WHITE}  5. UPnP disabled jika tidak dibutuhkan${RESET}"
    echo ""
    if command -v nmcli &>/dev/null; then
        echo -e "${CYAN}  Jaringan Wi-Fi di sekitar:${RESET}"
        nmcli dev wifi list 2>/dev/null | head -20 || echo -e "${RED}  Tidak bisa scan Wi-Fi (mungkin butuh root)${RESET}"
    elif command -v iwlist &>/dev/null; then
        echo -e "${CYAN}  Scanning Wi-Fi...${RESET}"
        iwlist scan 2>/dev/null | grep -E "SSID|Quality|Encryption" | head -30 || echo -e "${RED}  Scan gagal. Coba: iwlist wlan0 scan${RESET}"
    else
        echo -e "${RED}  Tool Wi-Fi scanning tidak tersedia.${RESET}"
        echo -e "${WHITE}  Install: pkg install wireless-tools atau pkg install network-manager${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                   WIRELESS SECURITY${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M10_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M10_2${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_wifi ;;
        2) wifi_scanner ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
