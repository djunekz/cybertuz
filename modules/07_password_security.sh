#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'


CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() {
    clear
    echo -e "${RED}"
    echo "  ================================================================="
    echo "                 PASSWORD SECURITY & CRACKING"
    echo "  ================================================================="
    echo -e "${RESET}"
}

teori_password() {
    header
    echo -e "${CYAN}  KEAMANAN PASSWORD${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_PWD_ATTACK_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_BRUTE_FORCE${RESET}"
    echo -e "${WHITE}     Mencoba semua kombinasi karakter yang mungkin.${RESET}"
    echo -e "${WHITE}     Lambat tapi pasti berhasil jika tidak ada batasan.${RESET}"
    echo -e "${WHITE}     Contoh: aa, ab, ac... zz, aaa, aab...${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_DICT_ATTACK${RESET}"
    echo -e "${WHITE}     Menggunakan daftar kata-kata umum sebagai password.${RESET}"
    echo -e "${WHITE}     Lebih cepat dari brute force.${RESET}"
    echo -e "${WHITE}     Wordlist populer: rockyou.txt (14 juta password)${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_RAINBOW${RESET}"
    echo -e "${WHITE}     Database hash yang sudah dihitung sebelumnya.${RESET}"
    echo -e "${WHITE}     Sangat cepat tapi perlu storage besar.${RESET}"
    echo -e "${WHITE}     Pencegahan: SALT (nilai random sebelum hash)${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_CRED_STUFF${RESET}"
    echo -e "${WHITE}     Menggunakan username/password dari data breach lain.${RESET}"
    echo -e "${WHITE}     Memanfaatkan kebiasaan reuse password${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_PWD_SPRAY${RESET}"
    echo -e "${WHITE}     Mencoba 1 password umum ke banyak akun.${RESET}"
    echo -e "${WHITE}     Menghindari lockout akun${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_STRONG_PWD${RESET}"
    echo -e "${WHITE}  - $CT_C_STRONG_1${RESET}"
    echo -e "${WHITE}  - $CT_C_STRONG_2${RESET}"
    echo -e "${WHITE}  - $CT_C_STRONG_3${RESET}"
    echo -e "${WHITE}  - $CT_C_STRONG_4${RESET}"
    echo -e "${WHITE}  - $CT_C_STRONG_5${RESET}"
    press_enter
}

password_strength() {
    header
    echo -e "${CYAN}  ANALISIS KEKUATAN PASSWORD${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_ENTER_PWD${RESET}"
    read -r -s test_pass
    echo ""
    echo ""
    
    len=${#test_pass}
    score=0
    feedback=()
    
    if [[ $len -ge 8 ]]; then
        score=$((score + 1))
    else
        feedback+=("$CT_C_PWD_TOO_SHORT")
    fi
    
    if [[ $len -ge 12 ]]; then
        score=$((score + 1))
    fi
    
    if [[ $len -ge 16 ]]; then
        score=$((score + 1))
    fi
    
    if echo "$test_pass" | grep -q '[A-Z]'; then
        score=$((score + 1))
    else
        feedback+=("$CT_C_ADD_UPPER")
    fi
    
    if echo "$test_pass" | grep -q '[a-z]'; then
        score=$((score + 1))
    else
        feedback+=("$CT_C_ADD_LOWER")
    fi
    
    if echo "$test_pass" | grep -q '[0-9]'; then
        score=$((score + 1))
    else
        feedback+=("$CT_C_ADD_NUMBERS")
    fi
    
    if echo "$test_pass" | grep -q '[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'; then
        score=$((score + 1))
    else
        feedback+=("$CT_C_ADD_SPECIAL")
    fi
    
    echo -e "${CYAN}  Analisis Password:${RESET}"
    echo -e "${WHITE}  $CT_C_PWD_LEN $len $CT_C_PWD_CHARS${RESET}"
    echo ""
    
    if [[ $score -le 2 ]]; then
        echo -e "${RED}  $CT_C_PWD_VERY_WEAK${RESET}"
        echo -e "${RED}  $CT_C_CRACK_TIME_S${RESET}"
    elif [[ $score -le 4 ]]; then
        echo -e "${YELLOW}  $CT_C_PWD_WEAK${RESET}"
        echo -e "${YELLOW}  $CT_C_CRACK_TIME_M${RESET}"
    elif [[ $score -le 6 ]]; then
        echo -e "${GREEN}  $CT_C_PWD_MEDIUM${RESET}"
        echo -e "${GREEN}  $CT_C_CRACK_TIME_D${RESET}"
    else
        echo -e "${GREEN}  $CT_C_PWD_STRONG${RESET}"
        echo -e "${GREEN}  $CT_C_CRACK_TIME_Y${RESET}"
    fi
    
    if [[ ${#feedback[@]} -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}  $CT_C_IMPROVEMENT${RESET}"
        for tip in "${feedback[@]}"; do
            echo -e "${WHITE}  - $tip${RESET}"
        done
    fi
    
    common_passwords=("password" "123456" "password123" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "master")
    for common in "${common_passwords[@]}"; do
        if [[ "${test_pass,,}" == "$common" ]]; then
            echo ""
            echo -e "${RED}  $CT_C_COMMON_PWD_WARN${RESET}"
            break
        fi
    done
    
    press_enter
}

hash_cracking_demo() {
    header
    echo -e "${CYAN}  DEMO: HASH CRACKING (DICTIONARY ATTACK)${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_HASH_CRACK_INTRO${RESET}"
    echo -e "${WHITE}  $CT_C_HASH_CRACK_WARN${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_POPULAR_TOOLS${RESET}"
    echo ""
    echo -e "${YELLOW}  John the Ripper:${RESET}"
    echo -e "${WHITE}  john --wordlist=rockyou.txt hash.txt${RESET}"
    echo -e "${WHITE}  john --format=md5crypt hash.txt${RESET}"
    echo ""
    echo -e "${YELLOW}  Hashcat:${RESET}"
    echo -e "${WHITE}  hashcat -m 0 hash.txt rockyou.txt         (MD5)${RESET}"
    echo -e "${WHITE}  hashcat -m 100 hash.txt rockyou.txt       (SHA1)${RESET}"
    echo -e "${WHITE}  hashcat -m 1800 hash.txt rockyou.txt      (SHA512crypt)${RESET}"
    echo -e "${WHITE}  hashcat -m 3200 hash.txt rockyou.txt      (bcrypt)${RESET}"
    echo ""
    echo -e "${YELLOW}  Mode Hashcat:${RESET}"
    echo -e "${WHITE}  -a 0 : Dictionary attack${RESET}"
    echo -e "${WHITE}  -a 1 : Combination attack${RESET}"
    echo -e "${WHITE}  -a 3 : Brute force (mask attack)${RESET}"
    echo ""
    echo -e "${GREEN}  SIMULASI DICTIONARY ATTACK SEDERHANA:${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_ENTER_HASH${RESET}"
    read -r target_hash
    
    if [[ -n "$target_hash" ]]; then
        common_words=("password" "123456" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "pass" "hello" "world" "test" "root" "toor" "secret")
        echo ""
        echo -e "${CYAN}  $CT_C_TRYING_DICT${RESET}"
        found=false
        for word in "${common_words[@]}"; do
            if command -v md5sum &>/dev/null; then
                hash_calc=$(echo -n "$word" | md5sum | cut -d' ' -f1)
                echo -e "${WHITE}  $CT_C_TRYING $word -> $hash_calc${RESET}"
                sleep 0.1
                if [[ "$hash_calc" == "${target_hash,,}" ]]; then
                    echo ""
                    echo -e "${RED}  $CT_C_CRACK_SUCCESS $word${RESET}"
                    found=true
                    break
                fi
            fi
        done
        if [[ "$found" == false ]]; then
            echo ""
            echo -e "${YELLOW}  $CT_C_NOT_FOUND${RESET}"
            echo -e "${WHITE}  $CT_C_IN_PRACTICE${RESET}"
        fi
    fi
    press_enter
}

password_generator() {
    header
    echo -e "${CYAN}  GENERATOR PASSWORD KUAT${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_GEN_INTRO${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_GEN_METHODS${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Passphrase (lebih mudah diingat dan kuat)${RESET}"
    echo -e "${WHITE}     Gabungkan 4-5 kata random dengan pemisah.${RESET}"
    echo -e "${WHITE}     Contoh: correct-horse-battery-staple${RESET}"
    echo -e "${WHITE}     Lebih kuat dari: Tr0ub4dor&3${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_GEN_RANDOM${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_ENTER_LEN${RESET}"
    read -r pass_len
    
    if [[ "$pass_len" =~ ^[0-9]+$ ]] && [[ $pass_len -ge 8 ]] && [[ $pass_len -le 64 ]]; then
        echo ""
        if command -v openssl &>/dev/null; then
            echo -e "${GREEN}  $CT_C_RAND_PWD${RESET}"
            openssl rand -base64 $((pass_len * 3 / 4 + 1)) | tr -d '\n' | head -c "$pass_len"
            echo ""
            echo ""
            echo -e "${GREEN}  $CT_C_HEX_PWD${RESET}"
            openssl rand -hex $((pass_len / 2 + 1)) | head -c "$pass_len"
            echo ""
        else
            echo -e "${GREEN}  Password dari /dev/urandom:${RESET}"
            tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c "$pass_len"
            echo ""
        fi
        echo ""
        echo -e "${YELLOW}  $CT_C_SAVE_TO_PM${RESET}"
        echo -e "${WHITE}  $CT_C_PM_RECO${RESET}"
    else
        echo -e "${RED}  $CT_C_INVALID_INPUT${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               PASSWORD SECURITY & CRACKING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M7_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M7_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M7_3${RESET}"
    echo -e "${GREEN}  [4] $CT_M7_4${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_CHOOSE_TOPIC${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_password ;;
        2) password_strength ;;
        3) hash_cracking_demo ;;
        4) password_generator ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
