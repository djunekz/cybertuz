#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                SOCIAL ENGINEERING AWARENESS"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_se() {
    header
    echo -e "${CYAN}  APA ITU SOCIAL ENGINEERING?${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_SE_DEF${RESET}"
    
    echo ""
    echo -e "${YELLOW}  $CT_C_SE_QUOTE${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_PSY_PRINCIPLES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_AUTHORITY${RESET}"
    echo -e "${WHITE}     Pura-pura menjadi atasan, IT support, atau pejabat.${RESET}"
    echo -e "${WHITE}     Contoh: 'Saya dari IT department, saya perlu password Anda'${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_URGENCY${RESET}"
    echo -e "${WHITE}     Menciptakan rasa panik agar korban tidak berpikir panjang.${RESET}"
    echo -e "${WHITE}     Contoh: 'Akun Anda akan diblokir dalam 1 jam!'${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_SOCIAL_PROOF${RESET}"
    echo -e "${WHITE}     Memanfaatkan kecenderungan mengikuti kelompok.${RESET}"
    echo -e "${WHITE}     Contoh: 'Semua kolega sudah klik link ini'${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_RECIPROCITY${RESET}"
    echo -e "${WHITE}     Memberi sesuatu dulu agar korban merasa berutang.${RESET}"
    echo -e "${WHITE}     Contoh: Beri hadiah kecil sebelum minta info${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_LIKING${RESET}"
    echo -e "${WHITE}     Membangun hubungan dan kepercayaan dulu.${RESET}"
    echo -e "${WHITE}     Contoh: Berpura-pura teman lama di media sosial${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_SCARCITY${RESET}"
    echo -e "${WHITE}     Menciptakan penawaran terbatas.${RESET}"
    echo -e "${WHITE}     Contoh: 'Penawaran hanya untuk 10 orang pertama!'${RESET}"
    press_enter
}

phishing_awareness() {
    header
    echo -e "${CYAN}  PHISHING - DETEKSI DAN PENCEGAHAN${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_PHISHING_DEF${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_PHISHING_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  Email Phishing${RESET}"
    echo -e "${WHITE}  Kirim email palsu seolah dari bank, Google, atau perusahaan besar.${RESET}"
    echo ""
    echo -e "${YELLOW}  Spear Phishing${RESET}"
    echo -e "${WHITE}  Phishing yang ditargetkan ke individu tertentu dengan info personal.${RESET}"
    echo -e "${WHITE}  Lebih efektif karena dipersonalisasi.${RESET}"
    echo ""
    echo -e "${YELLOW}  Whaling${RESET}"
    echo -e "${WHITE}  Spear phishing yang menargetkan eksekutif tinggi (CEO, CFO).${RESET}"
    echo ""
    echo -e "${YELLOW}  Smishing (SMS Phishing)${RESET}"
    echo -e "${WHITE}  Phishing melalui SMS dengan link berbahaya.${RESET}"
    echo -e "${WHITE}  Contoh: 'Paket kamu tertahan, klik link: bit.ly/xxxx'${RESET}"
    echo ""
    echo -e "${YELLOW}  Vishing (Voice Phishing)${RESET}"
    echo -e "${WHITE}  Phishing melalui telepon. Pura-pura jadi bank atau pemerintah.${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_PHISHING_SIGNS${RESET}"
    echo -e "${WHITE}  - Domain pengirim mencurigakan (paypa1.com bukan paypal.com)${RESET}"
    echo -e "${WHITE}  - Tata bahasa buruk atau terlalu formal${RESET}"
    echo -e "${WHITE}  - Urgent/minta tindakan segera${RESET}"
    echo -e "${WHITE}  - Link berbeda dari teks yang ditampilkan${RESET}"
    echo -e "${WHITE}  - Attachment tidak diminta${RESET}"
    echo -e "${WHITE}  - Minta informasi sensitif via email${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_PHISHING_SIM${RESET}"
    echo ""
    declare -a emails=(
        "support@paypa1.com"
        "noreply@google.com"
        "admin@facebook-security.xyz"
        "no-reply@amazon.com"
        "security@bca-alert.net"
        "info@microsoft.com"
    )
    declare -a verdict=("PHISHING" "AMAN" "PHISHING" "AMAN" "PHISHING" "AMAN")
    
    echo -e "${WHITE}  $CT_C_PHISHING_TRY${RESET}"
    echo ""
    for i in "${!emails[@]}"; do
        echo -e "${CYAN}  Email $((i+1)): ${emails[$i]}${RESET}"
        echo -ne "${WHITE}  $CT_C_PHISHING_ASK${RESET}"
        read -r answer
        if [[ "$answer" == "p" && "${verdict[$i]}" == "PHISHING" ]] || [[ "$answer" == "a" && "${verdict[$i]}" == "AMAN" ]]; then
            echo -e "${GREEN}  [$CT_CORRECT] ${verdict[$i]}${RESET}"
        else
            echo -e "${RED}  [$CT_WRONG] $CT_ANS: ${verdict[$i]}${RESET}"
            if [[ "${verdict[$i]}" == "PHISHING" ]]; then
                echo -e "${WHITE}  $CT_C_DOM_SUSPICIOUS${RESET}"
            fi
        fi
        echo ""
    done
    press_enter
}

pretexting() {
    header
    echo -e "${CYAN}  PRETEXTING - PENCIPTAAN SKENARIO PALSU${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_PRETEXTING_DEF${RESET}"
    
    echo ""
    echo -e "${GREEN}  $CT_C_COMMON_SCENARIOS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_IT_SCEN${RESET}"
    echo -e "${WHITE}  $CT_C_IT_SCEN_MSG${RESET}"
    
    echo -e "${RED}  $CT_C_IT_SCEN_WARN${RESET}"
    echo ""
    echo -e "${YELLOW}  Skenario Audit:${RESET}"
    echo -e "${WHITE}  'Saya dari tim audit eksternal. Saya perlu akses ke ruang server.'${RESET}"
    echo -e "${WHITE}  Memanfaatkan otoritas dan rasa takut karyawan${RESET}"
    echo ""
    echo -e "${YELLOW}  Skenario Survey:${RESET}"
    echo -e "${WHITE}  Survey online yang mengumpulkan info seperti nama ibu kandung,${RESET}"
    echo -e "${WHITE}  nama hewan peliharaan - pertanyaan keamanan umum bank!${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_PROTECT_SELF${RESET}"
    echo -e "${WHITE}  - Verifikasi identitas sebelum berbagi informasi${RESET}"
    echo -e "${WHITE}  - Jangan berikan password kepada siapapun (termasuk IT)${RESET}"
    echo -e "${WHITE}  - Ikuti prosedur keamanan perusahaan${RESET}"
    echo -e "${WHITE}  - Laporkan permintaan mencurigakan ke atasan/security${RESET}"
    echo -e "${WHITE}  - Security awareness training berkala${RESET}"
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               SOCIAL ENGINEERING AWARENESS${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M8_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M8_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M8_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_C_CHOOSE_TOPIC${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_se ;;
        2) phishing_awareness ;;
        3) pretexting ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
