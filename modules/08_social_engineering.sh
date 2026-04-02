#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                SOCIAL ENGINEERING AWARENESS"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_se() {
    header
    echo -e "${CYAN}  APA ITU SOCIAL ENGINEERING?${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Social engineering adalah manipulasi psikologis terhadap manusia${RESET}"
    echo -e "${WHITE}  untuk mendapatkan informasi rahasia atau akses ke sistem.${RESET}"
    echo ""
    echo -e "${YELLOW}  'The weakest link in security is always human.' - Kevin Mitnick${RESET}"
    echo ""
    echo -e "${GREEN}  PRINSIP PSIKOLOGIS YANG DIEKSPLOITASI:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Authority (Otoritas)${RESET}"
    echo -e "${WHITE}     Pura-pura menjadi atasan, IT support, atau pejabat.${RESET}"
    echo -e "${WHITE}     Contoh: 'Saya dari IT department, saya perlu password Anda'${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Urgency (Urgensi)${RESET}"
    echo -e "${WHITE}     Menciptakan rasa panik agar korban tidak berpikir panjang.${RESET}"
    echo -e "${WHITE}     Contoh: 'Akun Anda akan diblokir dalam 1 jam!'${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Social Proof (Bukti Sosial)${RESET}"
    echo -e "${WHITE}     Memanfaatkan kecenderungan mengikuti kelompok.${RESET}"
    echo -e "${WHITE}     Contoh: 'Semua kolega sudah klik link ini'${RESET}"
    echo ""
    echo -e "${YELLOW}  4. Reciprocity (Timbal Balik)${RESET}"
    echo -e "${WHITE}     Memberi sesuatu dulu agar korban merasa berutang.${RESET}"
    echo -e "${WHITE}     Contoh: Beri hadiah kecil sebelum minta info${RESET}"
    echo ""
    echo -e "${YELLOW}  5. Liking (Rasa Suka)${RESET}"
    echo -e "${WHITE}     Membangun hubungan dan kepercayaan dulu.${RESET}"
    echo -e "${WHITE}     Contoh: Berpura-pura teman lama di media sosial${RESET}"
    echo ""
    echo -e "${YELLOW}  6. Scarcity (Kelangkaan)${RESET}"
    echo -e "${WHITE}     Menciptakan penawaran terbatas.${RESET}"
    echo -e "${WHITE}     Contoh: 'Penawaran hanya untuk 10 orang pertama!'${RESET}"
    press_enter
}

phishing_awareness() {
    header
    echo -e "${CYAN}  PHISHING - DETEKSI DAN PENCEGAHAN${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Phishing adalah upaya penipuan untuk mencuri informasi sensitif${RESET}"
    echo -e "${WHITE}  dengan berpura-pura menjadi entitas terpercaya.${RESET}"
    echo ""
    echo -e "${GREEN}  JENIS PHISHING:${RESET}"
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
    echo -e "${GREEN}  TANDA-TANDA EMAIL PHISHING:${RESET}"
    echo -e "${WHITE}  - Domain pengirim mencurigakan (paypa1.com bukan paypal.com)${RESET}"
    echo -e "${WHITE}  - Tata bahasa buruk atau terlalu formal${RESET}"
    echo -e "${WHITE}  - Urgent/minta tindakan segera${RESET}"
    echo -e "${WHITE}  - Link berbeda dari teks yang ditampilkan${RESET}"
    echo -e "${WHITE}  - Attachment tidak diminta${RESET}"
    echo -e "${WHITE}  - Minta informasi sensitif via email${RESET}"
    echo ""
    echo -e "${GREEN}  SIMULASI DETEKSI PHISHING:${RESET}"
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
    
    echo -e "${WHITE}  Coba identifikasi mana yang phishing:${RESET}"
    echo ""
    for i in "${!emails[@]}"; do
        echo -e "${CYAN}  Email $((i+1)): ${emails[$i]}${RESET}"
        echo -ne "${WHITE}  Phishing atau Aman? (p/a): ${RESET}"
        read -r answer
        if [[ "$answer" == "p" && "${verdict[$i]}" == "PHISHING" ]] || [[ "$answer" == "a" && "${verdict[$i]}" == "AMAN" ]]; then
            echo -e "${GREEN}  BENAR! ${verdict[$i]}${RESET}"
        else
            echo -e "${RED}  SALAH! Jawaban: ${verdict[$i]}${RESET}"
            if [[ "${verdict[$i]}" == "PHISHING" ]]; then
                echo -e "${WHITE}  Domain ini mencurigakan karena tidak resmi.${RESET}"
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
    echo -e "${WHITE}  Pretexting adalah membuat skenario palsu yang meyakinkan${RESET}"
    echo -e "${WHITE}  untuk mendapatkan informasi dari target.${RESET}"
    echo ""
    echo -e "${GREEN}  SKENARIO PRETEXTING UMUM:${RESET}"
    echo ""
    echo -e "${YELLOW}  Skenario IT Support:${RESET}"
    echo -e "${WHITE}  'Halo, saya dari helpdesk IT. Ada masalah dengan akun Anda.${RESET}"
    echo -e "${WHITE}  Saya perlu password sementara untuk reset akun Anda.'${RESET}"
    echo -e "${RED}  BAHAYA: IT support yang sah TIDAK PERNAH minta password!${RESET}"
    echo ""
    echo -e "${YELLOW}  Skenario Audit:${RESET}"
    echo -e "${WHITE}  'Saya dari tim audit eksternal. Saya perlu akses ke ruang server.'${RESET}"
    echo -e "${WHITE}  Memanfaatkan otoritas dan rasa takut karyawan${RESET}"
    echo ""
    echo -e "${YELLOW}  Skenario Survey:${RESET}"
    echo -e "${WHITE}  Survey online yang mengumpulkan info seperti nama ibu kandung,${RESET}"
    echo -e "${WHITE}  nama hewan peliharaan - pertanyaan keamanan umum bank!${RESET}"
    echo ""
    echo -e "${GREEN}  CARA MELINDUNGI DIRI:${RESET}"
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
    echo -e "${GREEN}  [1] Teori Social Engineering${RESET}"
    echo -e "${GREEN}  [2] Phishing Awareness & Simulasi${RESET}"
    echo -e "${GREEN}  [3] Pretexting & Skenario Penipuan${RESET}"
    echo -e "${YELLOW}  [0] Kembali ke Menu Utama${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_se ;;
        2) phishing_awareness ;;
        3) pretexting ;;
        0) exit 0 ;;
        *) echo -e "${RED}  Pilihan tidak valid!${RESET}"; sleep 1 ;;
    esac
done
