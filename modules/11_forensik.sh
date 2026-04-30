#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                  $CT_C_M11_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

forensik_theory() {
    header
    echo -e "${CYAN}  $CT_C_M11_THEORY${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M11_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_PRINCIPLES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M11_P1_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M11_P2_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M11_P3_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_P4${RESET}"
    echo -e "${WHITE}  $CT_C_M11_P4_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_P5${RESET}"
    echo -e "${WHITE}  $CT_C_M11_P5_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_CHAIN${RESET}"
    echo -e "${WHITE}  $CT_C_M11_CHAIN_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_TOOLS${RESET}"
    echo -e "${WHITE}  $CT_C_M11_T1${RESET}"
    echo -e "${WHITE}  $CT_C_M11_T2${RESET}"
    echo -e "${WHITE}  $CT_C_M11_T3${RESET}"
    echo -e "${WHITE}  $CT_C_M11_T4${RESET}"
    echo -e "${WHITE}  $CT_C_M11_T5${RESET}"
    press_enter
}

log_analysis() {
    header
    echo -e "${CYAN}  $CT_C_M11_LOG${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M11_LOG_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_LOG_LOCS${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L1${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L2${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L3${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L4${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L5${RESET}"
    echo -e "${WHITE}  $CT_C_M11_LOG_L6${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_LOG_CMDS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_FAIL${RESET}"
    echo -e "${WHITE}  grep 'Failed password' /var/log/auth.log | tail -10${RESET}"
    echo -e "${WHITE}  grep 'authentication failure' /var/log/auth.log | tail -10${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_OK${RESET}"
    echo -e "${WHITE}  grep 'Accepted password' /var/log/auth.log | tail -10${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_SUDO${RESET}"
    echo -e "${WHITE}  grep 'sudo' /var/log/auth.log | tail -10${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_APACHE${RESET}"
    echo -e "${WHITE}  awk '{print \$1}' /var/log/apache2/access.log | sort | uniq -c | sort -rn | head -10${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_LOG_LOCAL${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_HIST${RESET}"
    if [[ -f ~/.bash_history ]]; then
        tail -15 ~/.bash_history 2>/dev/null
    else
        echo -e "${WHITE}  $CT_C_M11_LOG_NONE${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  $CT_C_M11_LOG_WHO${RESET}"
    who 2>/dev/null || echo -e "${WHITE}  N/A${RESET}"
    press_enter
}

file_analysis() {
    header
    echo -e "${CYAN}  $CT_C_M11_FILE${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M11_FILE_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_FILE_META${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M11_FILE_BASIC${RESET}"
    echo -e "${WHITE}  $CT_C_M11_FILE_EXIF${RESET}"
    echo -e "${WHITE}  $CT_C_M11_FILE_HASH${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_FIND_HIDDEN${RESET}"
    echo ""
    echo -e "${WHITE}  find /tmp -type f -mtime -1 2>/dev/null${RESET}"
    echo -e "${WHITE}  find / -name '.*' -type f 2>/dev/null | head -10${RESET}"
    echo -e "${WHITE}  find / -perm /4000 2>/dev/null (SUID files)${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M11_PRACTICE${RESET}"
    echo -ne "${WHITE}  $CT_C_M11_ENTER_FILE${RESET}"; read -r analyze_file
    if [[ -n "$analyze_file" && -f "$analyze_file" ]]; then
        echo ""
        echo -e "${CYAN}  $CT_C_M11_FILE_INFO${RESET}"
        stat "$analyze_file" 2>/dev/null
        echo ""
        echo -e "${CYAN}  $CT_C_M11_FILE_TYPE${RESET}"
        file "$analyze_file" 2>/dev/null
        echo ""
        echo -e "${CYAN}  $CT_C_M11_HASH_MD5${RESET}"
        md5sum "$analyze_file" 2>/dev/null || echo "N/A"
        echo ""
        echo -e "${CYAN}  $CT_C_M11_HASH_SHA256${RESET}"
        sha256sum "$analyze_file" 2>/dev/null || echo "N/A"
    else
        echo -e "${RED}  $CT_C_M11_NOT_FOUND${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               $CT_C_M11_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M11_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M11_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M11_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) forensik_theory ;; 2) log_analysis ;; 3) file_analysis ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
