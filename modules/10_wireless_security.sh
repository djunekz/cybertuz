#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                    WIRELESS SECURITY"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_wifi() {
    header
    echo -e "${CYAN}  KEAMANAN JARINGAN WIRELESS${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_WIFI_DEF${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_WIFI_PROTOCOLS${RESET}"
    echo ""
    echo -e "${RED}  $CT_C_WEP${RESET}"
    echo -e "${WHITE}  $CT_C_WEP_DESC${RESET}"
    
    echo ""
    echo -e "${YELLOW}  $CT_C_WPA${RESET}"
    echo -e "${WHITE}  $CT_C_WPA_DESC${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_WPA2${RESET}"
    echo -e "${WHITE}  $CT_C_WPA2_DESC${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_WPA3${RESET}"
    echo -e "${WHITE}  $CT_C_WPA3_DESC${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_WIFI_ATTACKS${RESET}"
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
    echo -e "${GREEN}  $CT_C_WIFI_TIPS${RESET}"
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
    echo -e "${GREEN}  $CT_C_WIFI_TOOLS${RESET}"
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
    echo -e "${GREEN}  $CT_C_WIFI_CHECK${RESET}"
    echo ""
    echo -e "${WHITE}  Hal yang perlu dicek:${RESET}"
    echo -e "${WHITE}  1. Protokol keamanan (WPA2/WPA3)${RESET}"
    echo -e "${WHITE}  2. Firmware router up to date${RESET}"
    echo -e "${WHITE}  3. Default password sudah diganti${RESET}"
    echo -e "${WHITE}  4. Remote management disabled${RESET}"
    echo -e "${WHITE}  5. UPnP disabled jika tidak dibutuhkan${RESET}"
    echo ""
    if command -v nmcli &>/dev/null; then
        echo -e "${CYAN}  $CT_C_WIFI_NEARBY${RESET}"
        nmcli dev wifi list 2>/dev/null | head -20 || echo -e "${RED}  $CT_C_WIFI_CANT_SCAN${RESET}"
    elif command -v iwlist &>/dev/null; then
        echo -e "${CYAN}  Scanning Wi-Fi...${RESET}"
        iwlist scan 2>/dev/null | grep -E "SSID|Quality|Encryption" | head -30 || echo -e "${RED}  Scan gagal. Coba: iwlist wlan0 scan${RESET}"
    else
        echo -e "${RED}  $CT_C_WIFI_NO_TOOL${RESET}"
        echo -e "${WHITE}  $CT_C_WIFI_INSTALL${RESET}"
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
    echo -ne "${WHITE}  $CT_C_CHOOSE_TOPIC${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_wifi ;;
        2) wifi_scanner ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
