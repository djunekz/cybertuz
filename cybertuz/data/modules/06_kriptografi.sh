#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                   $CT_C_M6_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_crypto() {
    header
    echo -e "${CYAN}  $CT_C_M6_INTRO_HDR${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M6_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_TERMS${RESET}"
    echo -e "${WHITE}  $CT_C_M6_PLAINTEXT${RESET}";  echo -e "${WHITE}  $CT_C_M6_CIPHERTEXT${RESET}"
    echo -e "${WHITE}  $CT_C_M6_KEY${RESET}";         echo -e "${WHITE}  $CT_C_M6_CIPHER${RESET}"
    echo -e "${WHITE}  $CT_C_M6_ENCRYPT${RESET}";     echo -e "${WHITE}  $CT_C_M6_DECRYPT${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M6_SYM${RESET}"
    echo -e "${WHITE}  $CT_C_M6_SYM_DESC${RESET}";   echo -e "${WHITE}  $CT_C_M6_SYM_ALGO${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M6_ASYM${RESET}"
    echo -e "${WHITE}  $CT_C_M6_ASYM_DESC${RESET}";  echo -e "${WHITE}  $CT_C_M6_ASYM_ALGO${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M6_HASH${RESET}"
    echo -e "${WHITE}  $CT_C_M6_HASH_DESC${RESET}";  echo -e "${WHITE}  $CT_C_M6_HASH_ALGO${RESET}"
    press_enter
}

praktik_hash() {
    header
    echo -e "${CYAN}  $CT_C_M6_HASH_TITLE${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M6_HASH_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_HASH_PROPS${RESET}"
    echo -e "${WHITE}  $CT_C_M6_HASH_P1${RESET}"; echo -e "${WHITE}  $CT_C_M6_HASH_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M6_HASH_P3${RESET}"; echo -e "${WHITE}  $CT_C_M6_HASH_P4${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_M6_ENTER_TEXT${RESET}"; read -r hash_input
    if [[ -n "$hash_input" ]]; then
        echo ""; echo -e "${CYAN}  $CT_C_M6_HASH_RESULTS '$hash_input'${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        command -v md5sum    &>/dev/null && echo -e "${YELLOW}  MD5   :${RESET} ${WHITE}$(echo -n "$hash_input" | md5sum | cut -d' ' -f1)${RESET}"
        command -v sha1sum   &>/dev/null && echo -e "${YELLOW}  SHA1  :${RESET} ${WHITE}$(echo -n "$hash_input" | sha1sum | cut -d' ' -f1)${RESET}"
        command -v sha256sum &>/dev/null && echo -e "${YELLOW}  SHA256:${RESET} ${WHITE}$(echo -n "$hash_input" | sha256sum | cut -d' ' -f1)${RESET}"
        command -v sha512sum &>/dev/null && echo -e "${YELLOW}  SHA512:${RESET} ${WHITE}$(echo -n "$hash_input" | sha512sum | cut -d' ' -f1)${RESET}"
        echo ""; echo -e "${GREEN}  $CT_C_M6_HASH_CHANGE${RESET}"
    fi
    press_enter
}

praktik_openssl() {
    header
    echo -e "${CYAN}  $CT_C_M6_OPENSSL_TITLE${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M6_OPENSSL_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_ENC_FILE${RESET}"
    echo -e "${WHITE}  openssl enc -aes-256-cbc -salt -in file.txt -out file.enc -k password${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_DEC_FILE${RESET}"
    echo -e "${WHITE}  openssl enc -aes-256-cbc -d -in file.enc -out file.txt -k password${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_RSA_KEY${RESET}"
    echo -e "${WHITE}  openssl genrsa -out private.pem 2048${RESET}"
    echo -e "${WHITE}  openssl rsa -in private.pem -pubout -out public.pem${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M6_PRACTICE${RESET}"
    echo ""
    if command -v openssl &>/dev/null; then
        echo -ne "${WHITE}  $CT_C_M6_ENTER_MSG${RESET}"; read -r enc_msg
        echo -ne "${WHITE}  $CT_C_M6_ENTER_PASS${RESET}"; read -r enc_pass
        if [[ -n "$enc_msg" && -n "$enc_pass" ]]; then
            encrypted=$(echo "$enc_msg" | openssl enc -aes-256-cbc -pbkdf2 -pass "pass:$enc_pass" -base64 2>/dev/null)
            echo ""; echo -e "${GREEN}  $CT_C_M6_ENC_RESULT${RESET}"; echo -e "${WHITE}  $encrypted${RESET}"
            decrypted=$(echo "$encrypted" | openssl enc -aes-256-cbc -d -pbkdf2 -pass "pass:$enc_pass" -base64 2>/dev/null)
            echo ""; echo -e "${GREEN}  $CT_C_M6_DECRYPTED${RESET}"; echo -e "${WHITE}  $decrypted${RESET}"
        fi
    else
        echo -e "${RED}  $CT_C_M6_OPENSSL_NA${RESET}"
    fi
    press_enter
}

caesar_cipher() {
    header
    echo -e "${CYAN}  $CT_C_M6_CAESAR_TITLE${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M6_CAESAR_DEF${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M6_CAESAR_EX${RESET}"
    echo -e "${WHITE}  Plaintext:  A B C D E F ... X Y Z${RESET}"
    echo -e "${WHITE}  Ciphertext: D E F G H I ... A B C${RESET}"
    echo -e "${WHITE}  $CT_C_M6_CAESAR_MSG${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_M6_ENTER_MSG2${RESET}"; read -r caesar_msg
    echo -ne "${WHITE}  $CT_C_M6_ENTER_SHIFT${RESET}"; read -r caesar_shift
    if [[ -n "$caesar_msg" && "$caesar_shift" =~ ^[0-9]+$ && $caesar_shift -ge 1 && $caesar_shift -le 25 ]]; then
        upper_cipher=$(echo -n "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | cut -c$((caesar_shift+1))-26)$(echo -n "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | cut -c1-$caesar_shift)
        lower_cipher=$(echo -n "abcdefghijklmnopqrstuvwxyz" | cut -c$((caesar_shift+1))-26)$(echo -n "abcdefghijklmnopqrstuvwxyz" | cut -c1-$caesar_shift)
        result=$(echo "$caesar_msg" | tr 'A-Za-z' "${upper_cipher}${lower_cipher}")
        echo ""
        echo -e "${GREEN}  $CT_C_M6_SHIFT_LBL$caesar_shift${RESET}"
        echo -e "${WHITE}  $CT_C_M6_ORIGINAL$caesar_msg${RESET}"
        echo -e "${YELLOW}  $CT_C_M6_ENCRYPTED$result${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                 $CT_C_M6_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M6_1${RESET}"; echo -e "${GREEN}  [2] $CT_M6_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M6_3${RESET}"; echo -e "${GREEN}  [4] $CT_M6_4${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) teori_crypto ;; 2) praktik_hash ;; 3) praktik_openssl ;; 4) caesar_cipher ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
