#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; MAGENTA='\033[0;35m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CYBERTUZ_DIR/logs"
SCORE_FILE="$CYBERTUZ_DIR/logs/ctf_score.txt"
press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                   CTF & TANTANGAN LATIHAN"; echo "  ================================================================="; echo -e "${RESET}"; }

load_score() {
    if [[ -f "$SCORE_FILE" ]]; then
        cat "$SCORE_FILE"
    else
        echo "0"
    fi
}

save_score() {
    echo "$1" > "$SCORE_FILE"
}

current_score=$(load_score)

ctf_encoding() {
    header
    echo -e "${CYAN}  CTF CHALLENGE 1: ENCODING & DECODING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Dalam CTF, sering ditemui data yang di-encode.${RESET}"
    echo -e "${WHITE}  Tantangan ini menguji kemampuanmu decode berbagai format.${RESET}"
    echo ""
    echo -e "${GREEN}  FORMAT ENCODING UMUM:${RESET}"
    echo ""
    echo -e "${YELLOW}  Base64:${RESET}"
    echo -e "${WHITE}  Encode: echo 'teks' | base64${RESET}"
    echo -e "${WHITE}  Decode: echo 'dGVrcw==' | base64 -d${RESET}"
    echo ""
    echo -e "${YELLOW}  Hex:${RESET}"
    echo -e "${WHITE}  Encode: echo 'teks' | xxd${RESET}"
    echo -e "${WHITE}  Decode: echo '74656b73' | xxd -r -p${RESET}"
    echo ""
    echo -e "${YELLOW}  ROT13:${RESET}"
    echo -e "${WHITE}  echo 'teks' | tr 'A-Za-z' 'N-ZA-Mn-za-m'${RESET}"
    echo ""
    echo -e "${MAGENTA}  TANTANGAN 1: Decode Base64 ini:${RESET}"
    challenge1="Q3liZXJUdXogYWRhbGFoIHRvb2wgZWR1a2FzaSB0ZXJiYWlrIQ=="
    echo -e "${YELLOW}  $challenge1${RESET}"
    echo ""
    echo -ne "${WHITE}  Masukkan jawaban kamu: ${RESET}"
    read -r ans1
    decoded1=$(echo "$challenge1" | base64 -d 2>/dev/null)
    if [[ "${ans1,,}" == "${decoded1,,}" ]] || echo "$ans1" | grep -qi "cybertuz"; then
        echo -e "${GREEN}  BENAR! +10 poin!${RESET}"
        echo -e "${WHITE}  Jawaban: $decoded1${RESET}"
        current_score=$((current_score + 10))
        save_score "$current_score"
    else
        echo -e "${RED}  Belum tepat. Jawaban: $decoded1${RESET}"
        echo -e "${WHITE}  Hint: gunakan 'echo <text> | base64 -d'${RESET}"
    fi
    echo ""
    echo -e "${MAGENTA}  TANTANGAN 2: Decode Hex ini:${RESET}"
    echo -e "${YELLOW}  48 61 63 6b 54 68 65 50 6c 61 6e 65 74${RESET}"
    echo ""
    echo -ne "${WHITE}  Masukkan jawaban kamu: ${RESET}"
    read -r ans2
    decoded2="HackThePlanet"
    if [[ "${ans2,,}" == "${decoded2,,}" ]]; then
        echo -e "${GREEN}  BENAR! +15 poin!${RESET}"
        current_score=$((current_score + 15))
        save_score "$current_score"
    else
        echo -e "${RED}  Belum tepat. Jawaban: $decoded2${RESET}"
        echo -e "${WHITE}  Hint: echo '48 61 63...' | xxd -r -p${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  Skor kamu: $current_score poin${RESET}"
    press_enter
}

ctf_hash_crack() {
    header
    echo -e "${CYAN}  CTF CHALLENGE 2: HASH CRACKING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Dalam CTF web security, sering ditemukan hash yang harus di-crack.${RESET}"
    echo ""
    echo -e "${MAGENTA}  TANTANGAN: Crack hash MD5 berikut:${RESET}"
    echo -e "${YELLOW}  5f4dcc3b5aa765d61d8327deb882cf99${RESET}"
    echo ""
    echo -e "${WHITE}  Petunjuk: Kata yang sangat umum digunakan sebagai password${RESET}"
    echo -e "${WHITE}  Cara: cari di Google atau pakai tools seperti hashcat/john${RESET}"
    echo ""
    echo -ne "${WHITE}  Masukkan jawaban (plaintext password): ${RESET}"
    read -r hash_ans
    if [[ "${hash_ans,,}" == "password" ]]; then
        echo -e "${GREEN}  BENAR! Hash MD5 dari 'password' = 5f4dcc3b5aa765d61d8327deb882cf99${RESET}"
        echo -e "${GREEN}  +20 poin!${RESET}"
        current_score=$((current_score + 20))
        save_score "$current_score"
    else
        echo -e "${RED}  Salah. Jawaban: password${RESET}"
        echo -e "${WHITE}  Lesson: Jangan pernah pakai password umum!${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  Skor kamu: $current_score poin${RESET}"
    press_enter
}

ctf_networking() {
    header
    echo -e "${CYAN}  CTF CHALLENGE 3: NETWORKING QUIZ${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Tes pengetahuan jaringan kamu dengan pertanyaan ini.${RESET}"
    echo ""
    total_correct=0
    
    echo -e "${MAGENTA}  Q1: Port mana yang digunakan SSH?${RESET}"
    echo -e "${WHITE}  a) 21   b) 22   c) 23   d) 80${RESET}"
    echo -ne "${WHITE}  Jawaban: ${RESET}"
    read -r q1
    if [[ "$q1" == "b" || "$q1" == "22" ]]; then
        echo -e "${GREEN}  BENAR! SSH menggunakan port 22${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  Salah. Jawaban: b (port 22)${RESET}"
    fi
    echo ""
    
    echo -e "${MAGENTA}  Q2: Apa kepanjangan dari HTTPS?${RESET}"
    echo -e "${WHITE}  a) Hyper Text Transfer Protocol Secure${RESET}"
    echo -e "${WHITE}  b) High Transfer Protocol System${RESET}"
    echo -e "${WHITE}  c) Hyperlink Transfer Protocol Security${RESET}"
    echo -ne "${WHITE}  Jawaban (a/b/c): ${RESET}"
    read -r q2
    if [[ "$q2" == "a" ]]; then
        echo -e "${GREEN}  BENAR!${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  Salah. Jawaban: a${RESET}"
    fi
    echo ""
    
    echo -e "${MAGENTA}  Q3: Serangan apa yang bisa dicegah dengan HTTPS?${RESET}"
    echo -e "${WHITE}  a) SQL Injection   b) Man-in-the-Middle   c) Brute Force${RESET}"
    echo -ne "${WHITE}  Jawaban: ${RESET}"
    read -r q3
    if [[ "$q3" == "b" ]]; then
        echo -e "${GREEN}  BENAR! HTTPS mengenkripsi traffic sehingga mencegah MitM${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  Salah. Jawaban: b (Man-in-the-Middle)${RESET}"
    fi
    echo ""
    
    points=$((total_correct * 10))
    current_score=$((current_score + points))
    save_score "$current_score"
    echo -e "${YELLOW}  Kamu menjawab $total_correct dari 3 pertanyaan. +$points poin${RESET}"
    echo -e "${YELLOW}  Total skor: $current_score poin${RESET}"
    press_enter
}

ctf_web_challenge() {
    header
    echo -e "${CYAN}  CTF CHALLENGE 4: WEB SECURITY${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Tantangan web security. Analisis kode di bawah:${RESET}"
    echo ""
    echo -e "${CYAN}  === KODE PHP RENTAN ====${RESET}"
    echo -e "${YELLOW}  \$username = \$_POST['username'];${RESET}"
    echo -e "${YELLOW}  \$password = \$_POST['password'];${RESET}"
    echo -e "${YELLOW}  \$query = \"SELECT * FROM users WHERE username='\$username'${RESET}"
    echo -e "${YELLOW}             AND password='\$password'\";${RESET}"
    echo -e "${YELLOW}  \$result = mysqli_query(\$conn, \$query);${RESET}"
    echo ""
    echo -e "${MAGENTA}  Q1: Apa kerentanan yang ada di kode ini?${RESET}"
    echo -ne "${WHITE}  Jawaban: ${RESET}"
    read -r web_q1
    if echo "$web_q1" | grep -qi "sql injection\|sqli\|sql"; then
        echo -e "${GREEN}  BENAR! Kode ini rentan terhadap SQL Injection! +15 poin${RESET}"
        current_score=$((current_score + 15))
        save_score "$current_score"
    else
        echo -e "${RED}  Kurang tepat. Jawaban: SQL Injection${RESET}"
    fi
    echo ""
    echo -e "${MAGENTA}  Q2: Payload apa yang bisa kamu gunakan untuk bypass login?${RESET}"
    echo -ne "${WHITE}  Jawaban: ${RESET}"
    read -r web_q2
    if echo "$web_q2" | grep -qi "or.*1.*1\|--\|admin'"; then
        echo -e "${GREEN}  BENAR! +10 poin${RESET}"
        echo -e "${WHITE}  Contoh: admin'-- atau ' OR '1'='1${RESET}"
        current_score=$((current_score + 10))
        save_score "$current_score"
    else
        echo -e "${RED}  Contoh payload: ' OR '1'='1'-- atau admin'--${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  Total skor: $current_score poin${RESET}"
    press_enter
}

show_score() {
    header
    echo -e "${CYAN}  PAPAN SKOR CTF${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    current_score=$(load_score)
    echo -e "${WHITE}  Total Poin kamu: ${YELLOW}$current_score${RESET}"
    echo ""
    if [[ $current_score -ge 100 ]]; then
        echo -e "${GREEN}  Peringkat: MASTER HACKER${RESET}"
    elif [[ $current_score -ge 60 ]]; then
        echo -e "${YELLOW}  Peringkat: INTERMEDIATE${RESET}"
    elif [[ $current_score -ge 30 ]]; then
        echo -e "${CYAN}  Peringkat: BEGINNER${RESET}"
    else
        echo -e "${WHITE}  Peringkat: NEWBIE - Terus berlatih!${RESET}"
    fi
    echo ""
    echo -e "${GREEN}  PLATFORM CTF UNTUK LATIHAN LANJUTAN:${RESET}"
    echo -e "${WHITE}  - HackTheBox     : hackthebox.com${RESET}"
    echo -e "${WHITE}  - TryHackMe      : tryhackme.com${RESET}"
    echo -e "${WHITE}  - PicoCTF        : picoctf.org${RESET}"
    echo -e "${WHITE}  - OverTheWire    : overthewire.org${RESET}"
    echo -e "${WHITE}  - CTFtime        : ctftime.org (daftar event CTF)${RESET}"
    echo -e "${WHITE}  - Root-Me        : root-me.org${RESET}"
    press_enter
}

while true; do
    header
    current_score=$(load_score)
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                  CTF & TANTANGAN LATIHAN${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${YELLOW}  Skor saat ini: $current_score poin${RESET}"
    echo ""
    echo -e "${GREEN}  [1] Challenge 1: Encoding & Decoding${RESET}"
    echo -e "${GREEN}  [2] Challenge 2: Hash Cracking${RESET}"
    echo -e "${GREEN}  [3] Challenge 3: Networking Quiz${RESET}"
    echo -e "${GREEN}  [4] Challenge 4: Web Security${RESET}"
    echo -e "${GREEN}  [5] Lihat Skor & Platform CTF${RESET}"
    echo -e "${YELLOW}  [0] Kembali ke Menu Utama${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) ctf_encoding ;;
        2) ctf_hash_crack ;;
        3) ctf_networking ;;
        4) ctf_web_challenge ;;
        5) show_score ;;
        0) exit 0 ;;
        *) echo -e "${RED}  Pilihan tidak valid!${RESET}"; sleep 1 ;;
    esac
done
