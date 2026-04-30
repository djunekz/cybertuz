#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                $CT_C_M9_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

firewall_module() {
    header
    echo -e "${CYAN}  $CT_C_M9_FW_HDR${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_FW_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M9_FW_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M9_FW1${RESET}"
    echo -e "${WHITE}  $CT_C_M9_FW1_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M9_FW2${RESET}"
    echo -e "${WHITE}  $CT_C_M9_FW2_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M9_FW3${RESET}"
    echo -e "${WHITE}  $CT_C_M9_FW3_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M9_FW4${RESET}"
    echo -e "${WHITE}  $CT_C_M9_FW4_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M9_IPTABLES${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_VIEW_RULES${RESET}"
    echo -e "${CYAN}  iptables -L -n -v${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_BLOCK_IP${RESET}"
    echo -e "${CYAN}  iptables -A INPUT -s 192.168.1.100 -j DROP${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_ALLOW_PORT${RESET}"
    echo -e "${CYAN}  iptables -A INPUT -p tcp --dport 22 -j ACCEPT${RESET}"
    echo -e "${CYAN}  iptables -A INPUT -p tcp --dport 80 -j ACCEPT${RESET}"
    echo -e "${CYAN}  iptables -A INPUT -p tcp --dport 443 -j ACCEPT${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_BLOCK_ALL${RESET}"
    echo -e "${CYAN}  iptables -P INPUT DROP${RESET}"
    echo -e "${CYAN}  iptables -P OUTPUT ACCEPT${RESET}"
    press_enter
}

net_analysis() {
    header
    echo -e "${CYAN}  $CT_C_M9_NET_ANALYSIS${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M9_ACTIVE_CONN${RESET}"
    echo -e "${WHITE}  $CT_C_M9_ACTIVE_LABEL${RESET}"
    if command -v ss &>/dev/null; then
        ss -tuln 2>/dev/null | head -12
    elif command -v netstat &>/dev/null; then
        netstat -tuln 2>/dev/null | head -12
    fi
    echo ""
    echo -e "${GREEN}  $CT_C_M9_ROUTING${RESET}"
    ip route 2>/dev/null || route -n 2>/dev/null | head -8
    echo ""
    echo -e "${GREEN}  $CT_C_M9_DNS_USED${RESET}"
    cat /etc/resolv.conf 2>/dev/null | grep nameserver | head -5
    echo ""
    echo -e "${GREEN}  $CT_C_M9_ARP${RESET}"
    arp -a 2>/dev/null | head -8 || ip neigh 2>/dev/null | head -8
    press_enter
}

mitm_module() {
    header
    echo -e "${CYAN}  $CT_C_M9_MITM_HDR${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_MITM_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M9_MITM_TECH${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M9_MITM_T1${RESET}"
    echo -e "${YELLOW}  $CT_C_M9_MITM_T2${RESET}"
    echo -e "${YELLOW}  $CT_C_M9_MITM_T3${RESET}"
    echo -e "${YELLOW}  $CT_C_M9_MITM_T4${RESET}"
    echo ""
    echo -e "${GREEN}  MitM $CT_NOTE - HOW IT LOOKS:${RESET}"
    echo ""
    echo "  Client                 Attacker               Server"
    echo "    |---SYN------------>|                         |"
    echo "    |                   |---SYN----------------->|"
    echo "    |<--SYN-ACK---------|                         |"
    echo "    |                   |<--SYN-ACK--------------|"
    echo "    |====TRAFFIC=======>|====TRAFFIC============>|"
    echo "    |<====TRAFFIC=======|<===TRAFFIC=============|"
    echo "            ^^^INTERCEPTED BY ATTACKER^^^"
    echo ""
    echo -e "${GREEN}  $CT_C_M9_MITM_PREV${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M9_MITM_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M9_MITM_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M9_MITM_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M9_MITM_P4${RESET}"
    echo -e "${WHITE}  $CT_C_M9_MITM_P5${RESET}"
    echo -e "${WHITE}  $CT_C_M9_MITM_P6${RESET}"
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}              $CT_C_M9_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M9_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M9_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M9_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) firewall_module ;; 2) net_analysis ;; 3) mitm_module ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
