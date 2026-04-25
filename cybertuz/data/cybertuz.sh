#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$CYBERTUZ_DIR/modules"
LOG_DIR="$CYBERTUZ_DIR/logs"
REPORT_DIR="$CYBERTUZ_DIR/reports"

mkdir -p "$LOG_DIR" "$REPORT_DIR"

source "$CYBERTUZ_DIR/lang.sh"

if ! ct_load_lang; then
    ct_choose_language
fi
export CYBERTUZ_LANG

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
    echo -e "${WHITE}        $CT_SUBTITLE${RESET}"
    echo -e "${YELLOW}        $CT_FOR_EDU${RESET}"
    echo -e "${WHITE}${DIM}        Official Developer : ${GREEN}djunekz${RESET}"
    echo -e "${WHITE}${DIM}        Open Contributing  : ${GREEN}https://github.com/djunekz/cybertuz${RESET}"
    echo -e "${WHITE}${DIM}        Information Tools  : ${YELLOW}OpenSource with MIT License${RESET}"
    echo -e "${WHITE}${DIM}        Language: ${YELLOW}$CT_LANG_NAME${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
}

disclaimer() {
    banner
    echo -e "${RED}  $CT_DISC_TITLE${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_DISC_1${RESET}"
    echo -e "${WHITE}  $CT_DISC_2${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_DISC_RULES${RESET}"
    echo -e "${WHITE}  [${YELLOW}+${WHITE}]${GREEN} $CT_RULE_1${RESET}"
    echo -e "${WHITE}  [${YELLOW}+${WHITE}]${GREEN} $CT_RULE_2${RESET}"
    echo -e "${WHITE}  [${YELLOW}+${WHITE}]${GREEN} $CT_RULE_3${RESET}"
    echo -e "${WHITE}  [${YELLOW}+${WHITE}]${GREEN} $CT_RULE_4${RESET}"
    echo ""
    echo -e "${RED}  $CT_WARN${RESET}"
    echo ""
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -ne "${WHITE}  $CT_AGREE_Q${RESET}"
    read -r _agr
    _agr_low=$(echo "$_agr" | tr '[:upper:]' '[:lower:]')
    _ok=0
    for _w in $CT_AGREE_OK; do
        [ "$_agr_low" = "$_w" ] && _ok=1 && break
    done
    if [ "$_ok" -eq 0 ]; then
        echo -e "${RED}  $CT_EXIT${RESET}"
        exit 0
    fi
    log_action "$CT_SESSION - $CT_LANG_NAME"
}

main_menu() {
    while true; do
        banner
        echo -e "${CYAN}  =================================================================${RESET}"
        echo -e "${WHITE}                  $CT_MENU_HDR${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        echo ""
        echo -e "${GREEN}  [1]  $CT_M1${RESET}"
        echo -e "${GREEN}  [2]  $CT_M2${RESET}"
        echo -e "${GREEN}  [3]  $CT_M3${RESET}"
        echo -e "${GREEN}  [4]  $CT_M4${RESET}"
        echo -e "${GREEN}  [5]  $CT_M5${RESET}"
        echo -e "${GREEN}  [6]  $CT_M6${RESET}"
        echo -e "${GREEN}  [7]  $CT_M7${RESET}"
        echo -e "${GREEN}  [8]  $CT_M8${RESET}"
        echo -e "${GREEN}  [9]  $CT_M9${RESET}"
        echo -e "${GREEN}  [10] $CT_M10${RESET}"
        echo -e "${GREEN}  [11] $CT_M11${RESET}"
        echo -e "${GREEN}  [12] $CT_M12${RESET}"
        echo -e "${GREEN}  [13] $CT_M13${RESET}"
        echo -e "${GREEN}  [14] $CT_M14${RESET}"
        echo -e "${GREEN}  [15] $CT_M15${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        echo -e "${YELLOW}  [16] $CT_M16${RESET}"
        echo -e "${YELLOW}  [17] $CT_M17${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        echo -e "${DIM}  [L]  $CT_LANG_MENU${RESET}"
        echo -e "${RED}  [0]  $CT_M0${RESET}"
        echo ""
        echo -ne "${WHITE}  $CT_MPROMPT${RESET}"
        read -r choice
        case $choice in
            1)  bash "$MODULES_DIR/01_teori_dasar.sh" ;;
            2)  bash "$MODULES_DIR/02_reconnaissance.sh" ;;
            3)  bash "$MODULES_DIR/03_network_scanning.sh" ;;
            4)  bash "$MODULES_DIR/04_vulnerability.sh" ;;
            5)  bash "$MODULES_DIR/05_web_security.sh" ;;
            6)  bash "$MODULES_DIR/06_kriptografi.sh" ;;
            7)  bash "$MODULES_DIR/07_password_security.sh" ;;
            8)  bash "$MODULES_DIR/08_social_engineering.sh" ;;
            9)  bash "$MODULES_DIR/09_network_security.sh" ;;
            10) bash "$MODULES_DIR/10_wireless_security.sh" ;;
            11) bash "$MODULES_DIR/11_forensik.sh" ;;
            12) bash "$MODULES_DIR/12_malware_analysis.sh" ;;
            13) bash "$MODULES_DIR/13_ctf_latihan.sh" ;;
            14) bash "$MODULES_DIR/14_tools_cheatsheet.sh" ;;
            15) bash "$MODULES_DIR/15_laporan.sh" ;;
            16) bash "$MODULES_DIR/16_training_arena.sh" ;;
            17) bash "$MODULES_DIR/17_misi_tugas.sh" ;;
            L|l)
                ct_choose_language
                export CYBERTUZ_LANG
                log_action "Language changed to: $CT_LANG_NAME"
                ;;
            0)
                echo ""
                echo -e "${YELLOW}  $CT_EXIT${RESET}"
                echo ""
                log_action "User exited"
                exit 0
                ;;
            *)
                echo -e "${RED}  $CT_INVALID${RESET}"
                sleep 1
                ;;
        esac
    done
}

disclaimer
main_menu
