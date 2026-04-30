#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                 $CT_C_M7_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_password() {
    header
    echo -e "${CYAN}  $CT_C_M7_THEORY${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_ATK_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_BF${RESET}"
    echo -e "${WHITE}  $CT_C_M7_BF_DESC${RESET}"; echo -e "${WHITE}  $CT_C_M7_BF_EX${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_DICT${RESET}"
    echo -e "${WHITE}  $CT_C_M7_DICT_DESC${RESET}"; echo -e "${WHITE}  $CT_C_M7_DICT_WORD${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_RAINBOW${RESET}"
    echo -e "${WHITE}  $CT_C_M7_RAINBOW_DESC${RESET}"; echo -e "${WHITE}  $CT_C_M7_RAINBOW_PREV${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_CRED${RESET}"
    echo -e "${WHITE}  $CT_C_M7_CRED_DESC${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_SPRAY${RESET}"
    echo -e "${WHITE}  $CT_C_M7_SPRAY_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_STRONG${RESET}"
    echo -e "${WHITE}  $CT_C_M7_S1${RESET}"; echo -e "${WHITE}  $CT_C_M7_S2${RESET}"
    echo -e "${WHITE}  $CT_C_M7_S3${RESET}"; echo -e "${WHITE}  $CT_C_M7_S4${RESET}"
    echo -e "${WHITE}  $CT_C_M7_S5${RESET}"
    press_enter
}

password_strength() {
    header
    echo -e "${CYAN}  $CT_C_M7_ANALYZE${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_M7_ENTER_PWD${RESET}"; read -r -s test_pass; echo ""
    echo ""
    len=${#test_pass}; score=0; feedback=()
    [[ $len -ge 8  ]] && ((score++)) || feedback+=("$CT_C_M7_TOO_SHORT")
    [[ $len -ge 12 ]] && ((score++))
    [[ $len -ge 16 ]] && ((score++))
    echo "$test_pass" | grep -q '[A-Z]' && ((score++)) || feedback+=("$CT_C_M7_ADD_UPPER")
    echo "$test_pass" | grep -q '[a-z]' && ((score++)) || feedback+=("$CT_C_M7_ADD_LOWER")
    echo "$test_pass" | grep -q '[0-9]' && ((score++)) || feedback+=("$CT_C_M7_ADD_NUM")
    echo "$test_pass" | grep -qE '[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]' && ((score++)) || feedback+=("$CT_C_M7_ADD_SPEC")
    echo -e "${CYAN}  $CT_C_M7_ANALYSIS${RESET}"
    echo -e "${WHITE}  $CT_C_M7_LEN $len $CT_C_M7_CHARS${RESET}"
    echo ""
    if   [[ $score -le 2 ]]; then echo -e "${RED}  $CT_C_M7_VERY_WEAK (score: $score/7)${RESET}"; echo -e "${RED}  $CT_C_M7_CRACK_SEC${RESET}"
    elif [[ $score -le 4 ]]; then echo -e "${YELLOW}  $CT_C_M7_WEAK (score: $score/7)${RESET}";    echo -e "${YELLOW}  $CT_C_M7_CRACK_MIN${RESET}"
    elif [[ $score -le 6 ]]; then echo -e "${GREEN}  $CT_C_M7_MEDIUM (score: $score/7)${RESET}";   echo -e "${GREEN}  $CT_C_M7_CRACK_DAY${RESET}"
    else                          echo -e "${GREEN}  $CT_C_M7_STRONG2 (score: $score/7)${RESET}";   echo -e "${GREEN}  $CT_C_M7_CRACK_YR${RESET}"; fi
    if [[ ${#feedback[@]} -gt 0 ]]; then
        echo ""; echo -e "${YELLOW}  $CT_C_M7_SUGGEST${RESET}"
        for tip in "${feedback[@]}"; do echo -e "${WHITE}  - $tip${RESET}"; done
    fi
    for common in "password" "123456" "password123" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "master"; do
        [[ "${test_pass,,}" == "$common" ]] && echo "" && echo -e "${RED}  $CT_C_M7_COMMON_WARN${RESET}" && break
    done
    press_enter
}

hash_cracking_demo() {
    header
    echo -e "${CYAN}  $CT_C_M7_CRACK_DEMO${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M7_CRACK_INTRO${RESET}"
    echo -e "${WHITE}  $CT_C_M7_CRACK_WARN${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_TOOLS${RESET}"
    echo ""
    echo -e "${YELLOW}  John the Ripper:${RESET}"
    echo -e "${WHITE}  john --wordlist=rockyou.txt hash.txt${RESET}"
    echo ""
    echo -e "${YELLOW}  Hashcat:${RESET}"
    echo -e "${WHITE}  hashcat -m 0 hash.txt rockyou.txt    (MD5)${RESET}"
    echo -e "${WHITE}  hashcat -m 100 hash.txt rockyou.txt  (SHA1)${RESET}"
    echo -e "${WHITE}  hashcat -m 3200 hash.txt rockyou.txt (bcrypt)${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_HASHCAT_MODES${RESET}"
    echo -e "${WHITE}  -a 0: Dictionary | -a 1: Combination | -a 3: Brute force${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_CRACK_DEMO:${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_M7_ENTER_HASH${RESET}"; read -r target_hash
    if [[ -n "$target_hash" ]]; then
        common_words=("password" "123456" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "pass" "hello" "world" "test" "root" "toor" "secret")
        echo ""; echo -e "${CYAN}  $CT_C_M7_TRYING${RESET}"; found=false
        for word in "${common_words[@]}"; do
            if command -v md5sum &>/dev/null; then
                hash_calc=$(echo -n "$word" | md5sum | cut -d' ' -f1)
                echo -e "${WHITE}  $CT_C_M7_TRY_WORD $word${RESET}"; sleep 0.1
                if [[ "$hash_calc" == "${target_hash,,}" ]]; then
                    echo ""; echo -e "${RED}  $CT_C_M7_CRACKED $word${RESET}"; found=true; break
                fi
            fi
        done
        if [[ "$found" == false ]]; then
            echo ""; echo -e "${YELLOW}  $CT_C_M7_NOT_FOUND${RESET}"; echo -e "${WHITE}  $CT_C_M7_REAL_WORLD${RESET}"
        fi
    fi
    press_enter
}

password_generator() {
    header
    echo -e "${CYAN}  $CT_C_M7_GEN${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M7_GEN_INTRO${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_GEN_METHODS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M7_PASSPHRASE${RESET}"
    echo -e "${WHITE}  $CT_C_M7_PASS_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M7_PASS_EX${RESET}"
    echo -e "${WHITE}  $CT_C_M7_PASS_BETTER${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M7_GEN_RANDOM${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_M7_ENTER_LEN${RESET}"; read -r pass_len
    if [[ "$pass_len" =~ ^[0-9]+$ ]] && [[ $pass_len -ge 8 ]] && [[ $pass_len -le 64 ]]; then
        echo ""
        if command -v openssl &>/dev/null; then
            echo -e "${GREEN}  $CT_C_M7_RAND_PWD${RESET}"
            openssl rand -base64 $((pass_len * 3 / 4 + 1)) | tr -d '\n' | head -c "$pass_len"; echo ""
            echo ""; echo -e "${GREEN}  $CT_C_M7_HEX_PWD${RESET}"
            openssl rand -hex $((pass_len / 2 + 1)) | head -c "$pass_len"; echo ""
        else
            echo -e "${GREEN}  $CT_C_M7_URANDOM${RESET}"
            tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c "$pass_len"; echo ""
        fi
        echo ""; echo -e "${YELLOW}  $CT_C_M7_SAVE${RESET}"; echo -e "${WHITE}  $CT_C_M7_RECO${RESET}"
    else
        echo -e "${RED}  $CT_C_M7_INVALID${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               $CT_C_M7_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M7_1${RESET}"; echo -e "${GREEN}  [2] $CT_M7_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M7_3${RESET}"; echo -e "${GREEN}  [4] $CT_M7_4${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) teori_password ;; 2) password_strength ;; 3) hash_cracking_demo ;; 4) password_generator ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
