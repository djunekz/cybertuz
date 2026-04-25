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
    echo "                   KRIPTOGRAFI & ENKRIPSI"
    echo "  ================================================================="
    echo -e "${RESET}"
}

teori_crypto() {
    header
    echo -e "${CYAN}  PENGENALAN KRIPTOGRAFI${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CRYPTO_DEF${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_IMPORTANT_TERMS${RESET}"
    echo -e "${WHITE}  Plaintext   - Pesan asli yang bisa dibaca${RESET}"
    echo -e "${WHITE}  Ciphertext  - Pesan terenkripsi${RESET}"
    echo -e "${WHITE}  Key         - Kunci untuk enkripsi/dekripsi${RESET}"
    echo -e "${WHITE}  Cipher      - Algoritma enkripsi${RESET}"
    echo -e "${WHITE}  Enkripsi    - Mengubah plaintext ke ciphertext${RESET}"
    echo -e "${WHITE}  Dekripsi    - Mengubah ciphertext ke plaintext${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_CRYPTO_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_SYM_CRYPTO${RESET}"
    echo -e "${WHITE}     Kunci enkripsi dan dekripsi SAMA.${RESET}"
    echo -e "${WHITE}     Cepat tapi masalah distribusi kunci.${RESET}"
    echo -e "${WHITE}     Algoritma: AES, DES, 3DES, Blowfish, ChaCha20${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_ASYM_CRYPTO${RESET}"
    echo -e "${WHITE}     Public key untuk enkripsi, Private key untuk dekripsi.${RESET}"
    echo -e "${WHITE}     Lebih lambat tapi aman untuk distribusi kunci.${RESET}"
    echo -e "${WHITE}     Algoritma: RSA, ECC, ElGamal${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_HASH_TYPE${RESET}"
    echo -e "${WHITE}     Menghasilkan fingerprint tetap dari data apapun.${RESET}"
    echo -e "${WHITE}     Tidak bisa di-reverse.${RESET}"
    echo -e "${WHITE}     Algoritma: MD5, SHA-1, SHA-256, SHA-3, bcrypt${RESET}"
    press_enter
}

praktik_hash() {
    header
    echo -e "${CYAN}  PRAKTIK: HASHING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_HASH_DEF${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_HASH_PROPS${RESET}"
    echo -e "${WHITE}  - Deterministic: Input sama = output sama${RESET}"
    echo -e "${WHITE}  - One-way: Tidak bisa dikembalikan ke plaintext${RESET}"
    echo -e "${WHITE}  - Avalanche effect: Perubahan kecil input = output beda total${RESET}"
    echo -e "${WHITE}  - Collision resistant: Susah menemukan 2 input dengan hash sama${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_ENTER_TEXT${RESET}"
    read -r hash_input
    if [[ -n "$hash_input" ]]; then
        echo ""
        echo -e "${CYAN}  $CT_C_HASH_RESULTS '$hash_input'${RESET}"
        echo -e "${CYAN}  =================================================================${RESET}"
        if command -v md5sum &>/dev/null; then
            echo -e "${YELLOW}  MD5   :${RESET} ${WHITE}$(echo -n "$hash_input" | md5sum | cut -d' ' -f1)${RESET}"
        fi
        if command -v sha1sum &>/dev/null; then
            echo -e "${YELLOW}  SHA1  :${RESET} ${WHITE}$(echo -n "$hash_input" | sha1sum | cut -d' ' -f1)${RESET}"
        fi
        if command -v sha256sum &>/dev/null; then
            echo -e "${YELLOW}  SHA256:${RESET} ${WHITE}$(echo -n "$hash_input" | sha256sum | cut -d' ' -f1)${RESET}"
        fi
        if command -v sha512sum &>/dev/null; then
            echo -e "${YELLOW}  SHA512:${RESET} ${WHITE}$(echo -n "$hash_input" | sha512sum | cut -d' ' -f1)${RESET}"
        fi
        echo ""
        echo -e "${GREEN}  $CT_C_HASH_TRY_CHANGE${RESET}"
    fi
    press_enter
}

praktik_openssl() {
    header
    echo -e "${CYAN}  PRAKTIK: ENKRIPSI DENGAN OPENSSL${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_OPENSSL_INTRO${RESET}"
    echo ""
    echo -e "${GREEN}  ENKRIPSI FILE DENGAN AES-256:${RESET}"
    echo -e "${WHITE}  openssl enc -aes-256-cbc -salt -in file.txt -out file.enc -k password${RESET}"
    echo ""
    echo -e "${GREEN}  DEKRIPSI FILE:${RESET}"
    echo -e "${WHITE}  openssl enc -aes-256-cbc -d -in file.enc -out file.txt -k password${RESET}"
    echo ""
    echo -e "${GREEN}  MEMBUAT RSA KEY PAIR:${RESET}"
    echo -e "${WHITE}  openssl genrsa -out private.pem 2048${RESET}"
    echo -e "${WHITE}  openssl rsa -in private.pem -pubout -out public.pem${RESET}"
    echo ""
    echo -e "${GREEN}  ENKRIPSI DENGAN RSA PUBLIC KEY:${RESET}"
    echo -e "${WHITE}  openssl rsautl -encrypt -inkey public.pem -pubin -in msg.txt -out msg.enc${RESET}"
    echo ""
    echo -e "${GREEN}  PRAKTIK LANGSUNG - ENKRIPSI TEKS:${RESET}"
    echo ""
    if command -v openssl &>/dev/null; then
        echo -ne "${WHITE}  $CT_C_ENTER_MSG${RESET}"
        read -r enc_msg
        echo -ne "${WHITE}  $CT_C_ENTER_PASS${RESET}"
        read -r enc_pass
        if [[ -n "$enc_msg" && -n "$enc_pass" ]]; then
            encrypted=$(echo "$enc_msg" | openssl enc -aes-256-cbc -pbkdf2 -pass "pass:$enc_pass" -base64 2>/dev/null)
            echo ""
            echo -e "${GREEN}  $CT_C_ENCRYPTED_MSG${RESET}"
            echo -e "${WHITE}  $encrypted${RESET}"
            echo ""
            echo -e "${GREEN}  $CT_C_DECRYPTED${RESET}"
            decrypted=$(echo "$encrypted" | openssl enc -aes-256-cbc -d -pbkdf2 -pass "pass:$enc_pass" -base64 2>/dev/null)
            echo -e "${WHITE}  $decrypted${RESET}"
        fi
    else
        echo -e "${RED}  $CT_C_OPENSSL_NA${RESET}"
    fi
    press_enter
}

caesar_cipher() {
    header
    echo -e "${CYAN}  CAESAR CIPHER - KRIPTOGRAFI KLASIK${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CAESAR_DEF${RESET}"
    
    echo ""
    echo -e "${YELLOW}  Contoh dengan shift 3:${RESET}"
    echo -e "${WHITE}  Plaintext:  A B C D E F ... X Y Z${RESET}"
    echo -e "${WHITE}  Ciphertext: D E F G H I ... A B C${RESET}"
    echo -e "${WHITE}  Pesan: HELLO -> KHOOR${RESET}"
    echo ""
    caesar_encrypt() {
        local text="$1"
        local shift="$2"
        local result=""
        for ((i=0; i<${#text}; i++)); do
            char="${text:$i:1}"
            if [[ "$char" =~ [A-Za-z] ]]; then
                if [[ "$char" =~ [A-Z] ]]; then
                    result+=$(echo "$char" | tr 'A-Z' "$(echo {A..Z} | tr -d ' ' | cut -c$((shift+1))-26)$(echo {A..Z} | tr -d ' ' | cut -c1-$shift)")
                else
                    result+=$(echo "$char" | tr 'a-z' "$(echo {a..z} | tr -d ' ' | cut -c$((shift+1))-26)$(echo {a..z} | tr -d ' ' | cut -c1-$shift)")
                fi
            else
                result+="$char"
            fi
        done
        echo "$result"
    }
    echo -ne "${WHITE}  Masukkan pesan: ${RESET}"
    read -r caesar_msg
    echo -ne "${WHITE}  $CT_C_ENTER_SHIFT${RESET}"
    read -r caesar_shift
    if [[ -n "$caesar_msg" && "$caesar_shift" =~ ^[0-9]+$ ]]; then
        echo ""
        encrypted_caesar=$(echo "$caesar_msg" | tr 'A-Za-z' "$(for i in $(seq 0 25); do printf '%s' "$(echo {A..Z} | tr -d ' ')"; done | cut -c$((caesar_shift+1))-$((caesar_shift+26)))$(for i in $(seq 0 25); do printf '%s' "$(echo {a..z} | tr -d ' ')"; done | cut -c$((caesar_shift+1))-$((caesar_shift+26)))")
        echo -e "${GREEN}  Shift: $caesar_shift${RESET}"
        echo -e "${WHITE}  $CT_C_ORIGINAL $caesar_msg${RESET}"
        
        upper_cipher=$(echo -n "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | cut -c$((caesar_shift+1))-26)$(echo -n "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | cut -c1-$caesar_shift)
        lower_cipher=$(echo -n "abcdefghijklmnopqrstuvwxyz" | cut -c$((caesar_shift+1))-26)$(echo -n "abcdefghijklmnopqrstuvwxyz" | cut -c1-$caesar_shift)
        result=$(echo "$caesar_msg" | tr 'A-Za-z' "${upper_cipher}${lower_cipher}")
        echo -e "${YELLOW}  $CT_C_ENCRYPTED_LBL $result${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                 KRIPTOGRAFI & ENKRIPSI${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M6_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M6_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M6_3${RESET}"
    echo -e "${GREEN}  [4] $CT_M6_4${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_CHOOSE_TOPIC${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_crypto ;;
        2) praktik_hash ;;
        3) praktik_openssl ;;
        4) caesar_cipher ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
