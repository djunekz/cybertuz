#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
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
    echo -e "${GREEN}  JENIS SERANGAN PASSWORD:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Brute Force Attack${RESET}"
    echo -e "${WHITE}     Mencoba semua kombinasi karakter yang mungkin.${RESET}"
    echo -e "${WHITE}     Lambat tapi pasti berhasil jika tidak ada batasan.${RESET}"
    echo -e "${WHITE}     Contoh: aa, ab, ac... zz, aaa, aab...${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Dictionary Attack${RESET}"
    echo -e "${WHITE}     Menggunakan daftar kata-kata umum sebagai password.${RESET}"
    echo -e "${WHITE}     Lebih cepat dari brute force.${RESET}"
    echo -e "${WHITE}     Wordlist populer: rockyou.txt (14 juta password)${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Rainbow Table Attack${RESET}"
    echo -e "${WHITE}     Database hash yang sudah dihitung sebelumnya.${RESET}"
    echo -e "${WHITE}     Sangat cepat tapi perlu storage besar.${RESET}"
    echo -e "${WHITE}     Pencegahan: SALT (nilai random sebelum hash)${RESET}"
    echo ""
    echo -e "${YELLOW}  4. Credential Stuffing${RESET}"
    echo -e "${WHITE}     Menggunakan username/password dari data breach lain.${RESET}"
    echo -e "${WHITE}     Memanfaatkan kebiasaan reuse password${RESET}"
    echo ""
    echo -e "${YELLOW}  5. Password Spraying${RESET}"
    echo -e "${WHITE}     Mencoba 1 password umum ke banyak akun.${RESET}"
    echo -e "${WHITE}     Menghindari lockout akun${RESET}"
    echo ""
    echo -e "${GREEN}  PASSWORD YANG KUAT:${RESET}"
    echo -e "${WHITE}  - Minimal 12 karakter${RESET}"
    echo -e "${WHITE}  - Kombinasi huruf besar, kecil, angka, simbol${RESET}"
    echo -e "${WHITE}  - Tidak menggunakan kata yang ada di kamus${RESET}"
    echo -e "${WHITE}  - Unik untuk setiap akun${RESET}"
    echo -e "${WHITE}  - Gunakan password manager${RESET}"
    press_enter
}

password_strength() {
    header
    echo -e "${CYAN}  ANALISIS KEKUATAN PASSWORD${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -ne "${WHITE}  Masukkan password untuk dianalisis: ${RESET}"
    read -r -s test_pass
    echo ""
    echo ""
    
    len=${#test_pass}
    score=0
    feedback=()
    
    if [[ $len -ge 8 ]]; then
        score=$((score + 1))
    else
        feedback+=("Terlalu pendek, minimal 8 karakter")
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
        feedback+=("Tambahkan huruf kapital")
    fi
    
    if echo "$test_pass" | grep -q '[a-z]'; then
        score=$((score + 1))
    else
        feedback+=("Tambahkan huruf kecil")
    fi
    
    if echo "$test_pass" | grep -q '[0-9]'; then
        score=$((score + 1))
    else
        feedback+=("Tambahkan angka")
    fi
    
    if echo "$test_pass" | grep -q '[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'; then
        score=$((score + 1))
    else
        feedback+=("Tambahkan karakter spesial (!@#\$%^&*)")
    fi
    
    echo -e "${CYAN}  Analisis Password:${RESET}"
    echo -e "${WHITE}  Panjang: $len karakter${RESET}"
    echo ""
    
    if [[ $score -le 2 ]]; then
        echo -e "${RED}  Kekuatan: SANGAT LEMAH (score: $score/7)${RESET}"
        echo -e "${RED}  Perkiraan waktu crack: Detik hingga menit${RESET}"
    elif [[ $score -le 4 ]]; then
        echo -e "${YELLOW}  Kekuatan: LEMAH (score: $score/7)${RESET}"
        echo -e "${YELLOW}  Perkiraan waktu crack: Menit hingga jam${RESET}"
    elif [[ $score -le 6 ]]; then
        echo -e "${GREEN}  Kekuatan: SEDANG (score: $score/7)${RESET}"
        echo -e "${GREEN}  Perkiraan waktu crack: Hari hingga bulan${RESET}"
    else
        echo -e "${GREEN}  Kekuatan: KUAT (score: $score/7)${RESET}"
        echo -e "${GREEN}  Perkiraan waktu crack: Tahun hingga dekade${RESET}"
    fi
    
    if [[ ${#feedback[@]} -gt 0 ]]; then
        echo ""
        echo -e "${YELLOW}  Saran perbaikan:${RESET}"
        for tip in "${feedback[@]}"; do
            echo -e "${WHITE}  - $tip${RESET}"
        done
    fi
    
    common_passwords=("password" "123456" "password123" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "master")
    for common in "${common_passwords[@]}"; do
        if [[ "${test_pass,,}" == "$common" ]]; then
            echo ""
            echo -e "${RED}  PERINGATAN: Password ini ada di daftar password umum!${RESET}"
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
    echo -e "${WHITE}  Ini adalah simulasi bagaimana hash password bisa di-crack.${RESET}"
    echo -e "${WHITE}  INGAT: Hanya gunakan pada hash milikmu sendiri!${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS POPULER UNTUK HASH CRACKING:${RESET}"
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
    echo -ne "${WHITE}  Masukkan hash MD5 yang ingin di-crack: ${RESET}"
    read -r target_hash
    
    if [[ -n "$target_hash" ]]; then
        common_words=("password" "123456" "admin" "qwerty" "letmein" "welcome" "monkey" "dragon" "pass" "hello" "world" "test" "root" "toor" "secret")
        echo ""
        echo -e "${CYAN}  Mencoba dictionary attack dengan kata umum...${RESET}"
        found=false
        for word in "${common_words[@]}"; do
            if command -v md5sum &>/dev/null; then
                hash_calc=$(echo -n "$word" | md5sum | cut -d' ' -f1)
                echo -e "${WHITE}  Mencoba: $word -> $hash_calc${RESET}"
                sleep 0.1
                if [[ "$hash_calc" == "${target_hash,,}" ]]; then
                    echo ""
                    echo -e "${RED}  [CRACK BERHASIL] Password ditemukan: $word${RESET}"
                    found=true
                    break
                fi
            fi
        done
        if [[ "$found" == false ]]; then
            echo ""
            echo -e "${YELLOW}  Password tidak ditemukan dalam wordlist kecil ini.${RESET}"
            echo -e "${WHITE}  Dalam praktik nyata, rockyou.txt berisi 14 juta kata!${RESET}"
        fi
    fi
    press_enter
}

password_generator() {
    header
    echo -e "${CYAN}  GENERATOR PASSWORD KUAT${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Mari buat password yang kuat menggunakan berbagai metode.${RESET}"
    echo ""
    echo -e "${GREEN}  METODE MEMBUAT PASSWORD KUAT:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Passphrase (lebih mudah diingat dan kuat)${RESET}"
    echo -e "${WHITE}     Gabungkan 4-5 kata random dengan pemisah.${RESET}"
    echo -e "${WHITE}     Contoh: correct-horse-battery-staple${RESET}"
    echo -e "${WHITE}     Lebih kuat dari: Tr0ub4dor&3${RESET}"
    echo ""
    echo -e "${GREEN}  GENERATE PASSWORD RANDOM:${RESET}"
    echo ""
    echo -ne "${WHITE}  Panjang password yang diinginkan (8-64): ${RESET}"
    read -r pass_len
    
    if [[ "$pass_len" =~ ^[0-9]+$ ]] && [[ $pass_len -ge 8 ]] && [[ $pass_len -le 64 ]]; then
        echo ""
        if command -v openssl &>/dev/null; then
            echo -e "${GREEN}  Password Random (huruf+angka+simbol):${RESET}"
            openssl rand -base64 $((pass_len * 3 / 4 + 1)) | tr -d '\n' | head -c "$pass_len"
            echo ""
            echo ""
            echo -e "${GREEN}  Password Hex:${RESET}"
            openssl rand -hex $((pass_len / 2 + 1)) | head -c "$pass_len"
            echo ""
        else
            echo -e "${GREEN}  Password dari /dev/urandom:${RESET}"
            tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c "$pass_len"
            echo ""
        fi
        echo ""
        echo -e "${YELLOW}  SIMPAN DI PASSWORD MANAGER!${RESET}"
        echo -e "${WHITE}  Rekomendasi: Bitwarden, KeePass, 1Password${RESET}"
    else
        echo -e "${RED}  Input tidak valid. Masukkan angka 8-64.${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               PASSWORD SECURITY & CRACKING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] Teori Serangan Password${RESET}"
    echo -e "${GREEN}  [2] Analisis Kekuatan Password${RESET}"
    echo -e "${GREEN}  [3] Demo Hash Cracking (Dictionary Attack)${RESET}"
    echo -e "${GREEN}  [4] Generator Password Kuat${RESET}"
    echo -e "${YELLOW}  [0] Kembali ke Menu Utama${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_password ;;
        2) password_strength ;;
        3) hash_cracking_demo ;;
        4) password_generator ;;
        0) exit 0 ;;
        *) echo -e "${RED}  Pilihan tidak valid!${RESET}"; sleep 1 ;;
    esac
done
