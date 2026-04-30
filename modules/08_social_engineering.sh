#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "               $CT_C_M8_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_se() {
    header
    echo -e "${CYAN}  $CT_C_M8_WHAT${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M8_DEF${RESET}"
    echo ""
    echo -e "${YELLOW}  \"$CT_C_M8_QUOTE\"${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_PSY${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_AUTH${RESET}"
    echo -e "${WHITE}  $CT_C_M8_AUTH_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_AUTH_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_URG${RESET}"
    echo -e "${WHITE}  $CT_C_M8_URG_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_URG_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_PROOF${RESET}"
    echo -e "${WHITE}  $CT_C_M8_PROOF_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_PROOF_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_RECIP${RESET}"
    echo -e "${WHITE}  $CT_C_M8_RECIP_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_RECIP_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_LIKE${RESET}"
    echo -e "${WHITE}  $CT_C_M8_LIKE_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_LIKE_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_SCAR${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SCAR_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SCAR_EX${RESET}"
    press_enter
}

phishing_module() {
    header
    echo -e "${CYAN}  $CT_C_M8_PHISH_HDR${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M8_PHISH_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_PHISH_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_EMAIL_PHISH${RESET}"
    echo -e "${YELLOW}  $CT_C_M8_SPEAR${RESET}"
    echo -e "${YELLOW}  $CT_C_M8_WHALING${RESET}"
    echo -e "${YELLOW}  $CT_C_M8_SMISH${RESET}"
    echo -e "${YELLOW}  $CT_C_M8_VISH${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_SIGNS${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M8_SIGN1${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIGN2${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIGN3${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIGN4${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIGN5${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIGN6${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_SIM${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SIM_TRY${RESET}"
    echo ""
    declare -a urls=("paypal.com" "paypa1.com" "google.com" "g00gle.com" "bankbri.co.id" "bankbri-promo.com")
    declare -a answers=("s" "p" "s" "p" "s" "p")
    score=0
    for i in 0 1 2 3 4 5; do
        echo -e "${YELLOW}  ${urls[$i]}${RESET}"
        echo -ne "${WHITE}  $CT_C_M8_SIM_ASK${RESET}"; read -r user_ans
        if [[ "${user_ans,,}" == "${answers[$i]}" ]] || [[ "${user_ans,,}" == "a" && "${answers[$i]}" == "s" ]]; then
            echo -e "${GREEN}  [$CT_CORRECT]${RESET}"; ((score++))
        else
            if [[ "${answers[$i]}" == "p" ]]; then
                echo -e "${RED}  [$CT_WRONG] $CT_C_M8_DOM_SUSP${RESET}"
            else
                echo -e "${RED}  [$CT_WRONG]${RESET}"
            fi
        fi
        echo ""
    done
    echo -e "${CYAN}  $CT_SCORE: $score/6${RESET}"
    press_enter
}

pretexting_module() {
    header
    echo -e "${CYAN}  $CT_C_M8_PRETEXT${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M8_PRETEXT_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_PRETEXT_SCENS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_IT_SCEN${RESET}"
    echo -e "${WHITE}  $CT_C_M8_IT_MSG${RESET}"
    echo -e "${RED}  $CT_C_M8_IT_WARN${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_AUDIT_SCEN${RESET}"
    echo -e "${WHITE}  $CT_C_M8_AUDIT_MSG${RESET}"
    echo -e "${WHITE}  $CT_C_M8_AUDIT_NOTE${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M8_SURVEY${RESET}"
    echo -e "${WHITE}  $CT_C_M8_SURVEY_MSG${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M8_PROTECT${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M8_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M8_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M8_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M8_P4${RESET}"
    echo -e "${WHITE}  $CT_C_M8_P5${RESET}"
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}              $CT_C_M8_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M8_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M8_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M8_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) teori_se ;; 2) phishing_module ;; 3) pretexting_module ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
