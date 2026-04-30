#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; WHITE='\033[1;37m'; MAGENTA='\033[0;35m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CYBERTUZ_DIR/logs"
SCORE_FILE="$CYBERTUZ_DIR/logs/ctf_score.txt"

if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -ne "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() {
    clear
    echo -e "${RED}"
    echo "  ================================================================="
    echo "                   $CT_M13"
    echo "  ================================================================="
    echo -e "${RESET}"
}

load_score() { [ -f "$SCORE_FILE" ] && cat "$SCORE_FILE" || echo "0"; }
save_score() { mkdir -p "$LOG_DIR"; echo "$1" > "$SCORE_FILE"; }

current_score=$(load_score)

ctf_encoding() {
    header
    echo -e "${CYAN}  $CT_M13_1${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CTF_ENC_INTRO${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_CTF_ENC_FORMATS${RESET}"
    echo ""
    echo -e "${YELLOW}  Base64:${RESET}"
    echo -e "${WHITE}  Encode: echo 'text' | base64${RESET}"
    echo -e "${WHITE}  Decode: echo 'dGVrcw==' | base64 -d${RESET}"
    echo ""
    echo -e "${YELLOW}  Hex:${RESET}"
    echo -e "${WHITE}  Encode: echo 'text' | xxd${RESET}"
    echo -e "${WHITE}  Decode: echo '74656b73' | xxd -r -p${RESET}"
    echo ""
    echo -e "${YELLOW}  ROT13:${RESET}"
    echo -e "${WHITE}  echo 'text' | tr 'A-Za-z' 'N-ZA-Mn-za-m'${RESET}"
    echo ""
    echo -e "${MAGENTA}  $CT_C_CTF_CHAL1${RESET}"
    challenge1="Q3liZXJUdXogYWRhbGFoIHRvb2wgZWR1a2FzaSB0ZXJiYWlrIQ=="
    echo -e "${YELLOW}  $challenge1${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r ans1
    decoded1=$(echo "$challenge1" | base64 -d 2>/dev/null)
    if [[ "${ans1,,}" == "${decoded1,,}" ]] || echo "$ans1" | grep -qi "cybertuz"; then
        echo -e "${GREEN}  [$CT_CORRECT] +10 $CT_SCORE!${RESET}"
        echo -e "${WHITE}  $CT_ANS: $decoded1${RESET}"
        current_score=$((current_score + 10))
        save_score "$current_score"
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: $decoded1${RESET}"
        echo -e "${WHITE}  $CT_HINT: echo '$challenge1' | base64 -d${RESET}"
    fi
    echo ""
    echo -e "${MAGENTA}  $CT_C_CTF_CHAL2${RESET}"
    echo -e "${YELLOW}  48 61 63 6b 54 68 65 50 6c 61 6e 65 74${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r ans2
    decoded2="HackThePlanet"
    if [[ "${ans2,,}" == "${decoded2,,}" ]]; then
        echo -e "${GREEN}  [$CT_CORRECT] +15 $CT_SCORE!${RESET}"
        current_score=$((current_score + 15))
        save_score "$current_score"
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: $decoded2${RESET}"
        echo -e "${WHITE}  $CT_HINT: echo '48 61 63...' | xxd -r -p${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  $CT_SCORE: $current_score${RESET}"
    press_enter
}

ctf_hash_crack() {
    header
    echo -e "${CYAN}  $CT_C_CTF_HASH_TITLE${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CTF_HASH_INTRO${RESET}"
    echo ""
    echo -e "${MAGENTA}  $CT_C_CTF_HASH_CHAL${RESET}"
    echo -e "${YELLOW}  5f4dcc3b5aa765d61d8327deb882cf99${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_HINT: $CT_C_CTF_HASH_HINT${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r hash_ans
    if [[ "${hash_ans,,}" == "password" ]]; then
        echo -e "${GREEN}  [$CT_CORRECT] MD5('password') = 5f4dcc3b5aa765d61d8327deb882cf99${RESET}"
        echo -e "${GREEN}  +20 $CT_SCORE!${RESET}"
        current_score=$((current_score + 20))
        save_score "$current_score"
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: password${RESET}"
        echo -e "${WHITE}  $CT_C_CTF_HASH_LESSON${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  $CT_SCORE: $current_score${RESET}"
    press_enter
}

ctf_networking() {
    header
    echo -e "${CYAN}  $CT_C_CTF_NET_TITLE${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CTF_NET_INTRO${RESET}"
    echo ""
    total_correct=0

    echo -e "${MAGENTA}  Q1: $CT_C_CTF_NET_Q1${RESET}"
    echo -e "${WHITE}  a) 21   b) 22   c) 23   d) 80${RESET}"
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r q1
    if [[ "$q1" == "b" || "$q1" == "22" ]]; then
        echo -e "${GREEN}  [$CT_CORRECT] $CT_C_CTF_NET_Q1_ANS${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: b (port 22)${RESET}"
    fi
    echo ""

    echo -e "${MAGENTA}  Q2: $CT_C_CTF_NET_Q2${RESET}"
    echo -e "${WHITE}  a) Hyper Text Transfer Protocol Secure${RESET}"
    echo -e "${WHITE}  b) High Transfer Protocol System${RESET}"
    echo -e "${WHITE}  c) Hyperlink Transfer Protocol Security${RESET}"
    echo -ne "${WHITE}  $CT_ANS (a/b/c): ${RESET}"
    read -r q2
    if [[ "$q2" == "a" ]]; then
        echo -e "${GREEN}  [$CT_CORRECT]${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: a${RESET}"
    fi
    echo ""

    echo -e "${MAGENTA}  Q3: $CT_C_CTF_NET_Q3${RESET}"
    echo -e "${WHITE}  a) SQL Injection   b) Man-in-the-Middle   c) Brute Force${RESET}"
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r q3
    if [[ "$q3" == "b" ]]; then
        echo -e "${GREEN}  [$CT_CORRECT] $CT_C_CTF_NET_Q3_ANS${RESET}"
        total_correct=$((total_correct + 1))
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: b (Man-in-the-Middle)${RESET}"
    fi
    echo ""

    points=$((total_correct * 10))
    current_score=$((current_score + points))
    save_score "$current_score"
    echo -e "${YELLOW}  $CT_Q: $total_correct / 3 | +$points $CT_SCORE${RESET}"
    echo -e "${YELLOW}  $CT_SCORE: $current_score${RESET}"
    press_enter
}

ctf_web_challenge() {
    header
    echo -e "${CYAN}  $CT_C_CTF_WEB_TITLE${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_CTF_WEB_INTRO${RESET}"
    echo ""
    echo -e "${CYAN}  === VULNERABLE PHP CODE ===${RESET}"
    echo -e "${YELLOW}  \$username = \$_POST['username'];${RESET}"
    echo -e "${YELLOW}  \$password = \$_POST['password'];${RESET}"
    echo -e "${YELLOW}  \$query = \"SELECT * FROM users WHERE username='\$username'${RESET}"
    echo -e "${YELLOW}             AND password='\$password'\";${RESET}"
    echo -e "${YELLOW}  \$result = mysqli_query(\$conn, \$query);${RESET}"
    echo ""
    echo -e "${MAGENTA}  Q1: $CT_C_CTF_WEB_Q1${RESET}"
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r web_q1
    if echo "$web_q1" | grep -qi "sql injection\|sqli\|sql"; then
        echo -e "${GREEN}  [$CT_CORRECT] $CT_C_CTF_WEB_Q1_ANS +15 $CT_SCORE${RESET}"
        current_score=$((current_score + 15))
        save_score "$current_score"
    else
        echo -e "${RED}  [$CT_WRONG] $CT_ANS: SQL Injection${RESET}"
    fi
    echo ""
    echo -e "${MAGENTA}  Q2: $CT_C_CTF_WEB_Q2${RESET}"
    echo -ne "${WHITE}  $CT_ANS: ${RESET}"
    read -r web_q2
    if echo "$web_q2" | grep -qi "or.*1.*1\|--\|admin'"; then
        echo -e "${GREEN}  [$CT_CORRECT] +10 $CT_SCORE${RESET}"
        echo -e "${WHITE}  $CT_C_CTF_WEB_Q2_EX${RESET}"
        current_score=$((current_score + 10))
        save_score "$current_score"
    else
        echo -e "${RED}  $CT_C_CTF_WEB_Q2_EX${RESET}"
    fi
    echo ""
    echo -e "${YELLOW}  $CT_SCORE: $current_score${RESET}"
    press_enter
}

show_score() {
    header
    echo -e "${CYAN}  $CT_C_CTF_SCOREBOARD${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    current_score=$(load_score)
    echo -e "${WHITE}  $CT_SCORE: ${YELLOW}$current_score${RESET}"
    echo ""
    if [[ $current_score -ge 100 ]]; then
        echo -e "${GREEN}  $CT_LEVEL: $CT_LVL_EXP${RESET}"
    elif [[ $current_score -ge 60 ]]; then
        echo -e "${YELLOW}  $CT_LEVEL: $CT_LVL_INT${RESET}"
    elif [[ $current_score -ge 30 ]]; then
        echo -e "${CYAN}  $CT_LEVEL: $CT_LVL_NB${RESET}"
    else
        echo -e "${WHITE}  $CT_LEVEL: $CT_LVL_NB${RESET}"
    fi
    echo ""
    echo -e "${GREEN}  $CT_C_CTF_PLATFORMS${RESET}"
    echo -e "${WHITE}  - HackTheBox     : hackthebox.com${RESET}"
    echo -e "${WHITE}  - TryHackMe      : tryhackme.com${RESET}"
    echo -e "${WHITE}  - PicoCTF        : picoctf.org${RESET}"
    echo -e "${WHITE}  - OverTheWire    : overthewire.org${RESET}"
    echo -e "${WHITE}  - CTFtime        : ctftime.org${RESET}"
    echo -e "${WHITE}  - Root-Me        : root-me.org${RESET}"
    press_enter
}

while true; do
    header
    current_score=$(load_score)
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                  $CT_M13${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${YELLOW}  $CT_SCORE: $current_score${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M13_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M13_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M13_3${RESET}"
    echo -e "${GREEN}  [4] $CT_M13_4${RESET}"
    echo -e "${GREEN}  [5] $CT_M13_5${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"
    read -r pilihan
    case $pilihan in
        1) ctf_encoding ;;
        2) ctf_hash_crack ;;
        3) ctf_networking ;;
        4) ctf_web_challenge ;;
        5) show_score ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
