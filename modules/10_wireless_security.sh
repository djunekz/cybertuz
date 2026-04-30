#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                 $CT_C_M10_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

wireless_theory() {
    header
    echo -e "${CYAN}  $CT_C_M10_THEORY${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M10_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_PROTOCOLS${RESET}"
    echo ""
    echo -e "${RED}  $CT_C_M10_WEP${RESET}"
    echo -e "${WHITE}  $CT_C_M10_WEP_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M10_WPA${RESET}"
    echo -e "${WHITE}  $CT_C_M10_WPA_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_WPA2${RESET}"
    echo -e "${WHITE}  $CT_C_M10_WPA2_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_WPA3${RESET}"
    echo -e "${WHITE}  $CT_C_M10_WPA3_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_ATTACKS${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M10_ATK1${RESET}"
    echo -e "${WHITE}  $CT_C_M10_ATK2${RESET}"
    echo -e "${WHITE}  $CT_C_M10_ATK3${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_TIPS${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M10_TIP1${RESET}"
    echo -e "${WHITE}  $CT_C_M10_TIP2${RESET}"
    echo -e "${WHITE}  $CT_C_M10_TIP3${RESET}"
    echo -e "${WHITE}  $CT_C_M10_TIP4${RESET}"
    echo -e "${WHITE}  $CT_C_M10_TIP5${RESET}"
    echo -e "${WHITE}  $CT_C_M10_TIP6${RESET}"
    press_enter
}

wifi_scanner() {
    header
    echo -e "${CYAN}  $CT_C_M10_SCANNER${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M10_SCAN_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_TOOLS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M10_NMCLI${RESET}"
    echo -e "${WHITE}  nmcli dev wifi list${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M10_IWLIST${RESET}"
    echo -e "${WHITE}  iwlist wlan0 scan | grep -E 'ESSID|Signal|Encryption'${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M10_AIRCRACK${RESET}"
    echo -e "${WHITE}  airmon-ng start wlan0${RESET}"
    echo -e "${WHITE}  airodump-ng wlan0mon${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_NEARBY${RESET}"
    echo ""
    if command -v nmcli &>/dev/null; then
        nmcli -f SSID,SIGNAL,SECURITY dev wifi list 2>/dev/null | head -15 || echo -e "${YELLOW}  $CT_C_M10_CANT${RESET}"
    elif command -v iwlist &>/dev/null; then
        interface=$(ip link | grep -E "wl|wlan" | awk '{print $2}' | tr -d ':' | head -1)
        if [[ -n "$interface" ]]; then
            iwlist "$interface" scan 2>/dev/null | grep -E "ESSID|Signal" | head -20 || echo -e "${YELLOW}  $CT_C_M10_CANT${RESET}"
        else
            echo -e "${YELLOW}  $CT_C_M10_CANT${RESET}"
        fi
    else
        echo -e "${YELLOW}  $CT_C_M10_NO_TOOL${RESET}"
        echo -e "${WHITE}  $CT_C_M10_INSTALL${RESET}"
    fi
    press_enter
}

router_security() {
    header
    echo -e "${CYAN}  $CT_C_M10_ROUTER_CHECK${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M10_CHECK_LIST${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M10_CK1${RESET}"
    echo -e "${WHITE}  $CT_C_M10_CK2${RESET}"
    echo -e "${WHITE}  $CT_C_M10_CK3${RESET}"
    echo -e "${WHITE}  $CT_C_M10_CK4${RESET}"
    echo -e "${WHITE}  $CT_C_M10_CK5${RESET}"
    echo ""
    echo -e "${GREEN}  Local Gateway:${RESET}"
    gw=$(ip route | grep default | awk '{print $3}' | head -1)
    if [[ -n "$gw" ]]; then
        echo -e "${WHITE}  Gateway: $gw${RESET}"
        if command -v curl &>/dev/null; then
            echo -e "${CYAN}  curl -s --connect-timeout 3 http://$gw | head -20${RESET}"
            curl -s --connect-timeout 3 "http://$gw" 2>/dev/null | head -10 | grep -i -E "title|router|admin|model" | head -3
        fi
    else
        echo -e "${YELLOW}  No gateway detected${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                $CT_C_M10_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M10_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M10_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M10_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) wireless_theory ;; 2) wifi_scanner ;; 3) router_security ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
