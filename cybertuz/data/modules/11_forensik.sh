#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CYBERTUZ_LOG_DIR="$CYBERTUZ_DIR/logs"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

press_enter() { echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                     FORENSIK DIGITAL"; echo "  ================================================================="; echo -e "${RESET}"; }

teori_forensik() {
    header
    echo -e "${CYAN}  DIGITAL FORENSICS - INVESTIGASI INSIDEN SIBER${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Digital forensics adalah ilmu mengumpulkan, menganalisis,${RESET}"
    echo -e "${WHITE}  dan melaporkan bukti digital untuk keperluan hukum.${RESET}"
    echo ""
    echo -e "${GREEN}  PRINSIP FORENSIK DIGITAL:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Preserve (Preservasi)${RESET}"
    echo -e "${WHITE}     Jangan ubah barang bukti asli. Buat salinan forensik.${RESET}"
    echo -e "${WHITE}     Gunakan write blocker untuk cegah modifikasi.${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Collect (Pengumpulan)${RESET}"
    echo -e "${WHITE}     Kumpulkan semua bukti digital yang relevan.${RESET}"
    echo -e "${WHITE}     Urutan volatilitas: RAM > Proses > Disk${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Examine (Pemeriksaan)${RESET}"
    echo -e "${WHITE}     Analisis mendalam pada data yang dikumpulkan.${RESET}"
    echo ""
    echo -e "${YELLOW}  4. Analyze (Analisis)${RESET}"
    echo -e "${WHITE}     Interpretasikan temuan dan hubungkan bukti.${RESET}"
    echo ""
    echo -e "${YELLOW}  5. Report (Pelaporan)${RESET}"
    echo -e "${WHITE}     Dokumentasikan temuan dalam laporan yang dapat dipahami.${RESET}"
    echo ""
    echo -e "${GREEN}  CHAIN OF CUSTODY:${RESET}"
    echo -e "${WHITE}  Dokumentasi lengkap siapa yang memegang bukti dan kapan.${RESET}"
    echo -e "${WHITE}  Sangat penting untuk bukti yang akan digunakan di pengadilan.${RESET}"
    echo ""
    echo -e "${GREEN}  TOOLS FORENSIK:${RESET}"
    echo -e "${WHITE}  Autopsy    - GUI untuk analisis disk${RESET}"
    echo -e "${WHITE}  Volatility - Analisis memory dump${RESET}"
    echo -e "${WHITE}  Wireshark  - Analisis packet capture${RESET}"
    echo -e "${WHITE}  FTK Imager - Imaging disk${RESET}"
    echo -e "${WHITE}  Sleuth Kit - Toolkit forensik command line${RESET}"
    press_enter
}

log_analysis() {
    header
    echo -e "${CYAN}  ANALISIS LOG SISTEM${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Log adalah catatan aktivitas sistem yang sangat penting${RESET}"
    echo -e "${WHITE}  untuk forensik dan deteksi insiden.${RESET}"
    echo ""
    echo -e "${GREEN}  LOKASI LOG PENTING DI LINUX:${RESET}"
    echo -e "${WHITE}  /var/log/auth.log     - Autentikasi SSH, sudo, login${RESET}"
    echo -e "${WHITE}  /var/log/syslog       - Log sistem umum${RESET}"
    echo -e "${WHITE}  /var/log/apache2/     - Log web server Apache${RESET}"
    echo -e "${WHITE}  /var/log/nginx/       - Log web server Nginx${RESET}"
    echo -e "${WHITE}  /var/log/kern.log     - Log kernel${RESET}"
    echo -e "${WHITE}  ~/.bash_history       - History perintah user${RESET}"
    echo ""
    echo -e "${GREEN}  PERINTAH ANALISIS LOG:${RESET}"
    echo ""
    echo -e "${YELLOW}  Lihat login gagal:${RESET}"
    echo -e "${WHITE}  grep 'Failed password' /var/log/auth.log | tail -20${RESET}"
    echo ""
    echo -e "${YELLOW}  Lihat login sukses:${RESET}"
    echo -e "${WHITE}  grep 'Accepted password' /var/log/auth.log | tail -20${RESET}"
    echo ""
    echo -e "${YELLOW}  Lihat aktivitas sudo:${RESET}"
    echo -e "${WHITE}  grep 'sudo' /var/log/auth.log | tail -20${RESET}"
    echo ""
    echo -e "${YELLOW}  Analisis Apache access log:${RESET}"
    echo -e "${WHITE}  awk '{print \$1}' /var/log/apache2/access.log | sort | uniq -c | sort -rn | head -10${RESET}"
    echo ""
    echo -e "${GREEN}  ANALISIS LOG LOKAL:${RESET}"
    echo ""
    echo -e "${CYAN}  History perintah terakhir:${RESET}"
    history 2>/dev/null | tail -15 || cat ~/.bash_history 2>/dev/null | tail -15 || echo -e "${WHITE}  Tidak ada history tersedia${RESET}"
    echo ""
    echo -e "${CYAN}  User yang sedang login:${RESET}"
    who 2>/dev/null || w 2>/dev/null | head -10
    press_enter
}

file_analysis() {
    header
    echo -e "${CYAN}  ANALISIS FILE - METADATA & INTEGRITAS${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  File menyimpan banyak metadata yang berguna untuk forensik.${RESET}"
    echo ""
    echo -e "${GREEN}  MENGECEK METADATA FILE:${RESET}"
    echo ""
    echo -e "${YELLOW}  Informasi dasar file:${RESET}"
    echo -e "${WHITE}  stat filename${RESET}"
    echo -e "${WHITE}  file filename  (identifikasi tipe file)${RESET}"
    echo ""
    echo -e "${YELLOW}  Metadata gambar (EXIF):${RESET}"
    echo -e "${WHITE}  exiftool photo.jpg${RESET}"
    echo -e "${WHITE}  identify -verbose photo.jpg${RESET}"
    echo ""
    echo -e "${YELLOW}  Verifikasi integritas file (hash):${RESET}"
    echo -e "${WHITE}  md5sum filename${RESET}"
    echo -e "${WHITE}  sha256sum filename${RESET}"
    echo ""
    echo -e "${GREEN}  MENCARI FILE TERSEMBUNYI:${RESET}"
    echo -e "${WHITE}  find / -name '.*' 2>/dev/null | head -20  (file tersembunyi)${RESET}"
    echo -e "${WHITE}  find / -perm -4000 2>/dev/null            (SUID files)${RESET}"
    echo -e "${WHITE}  find / -newer /tmp/reference 2>/dev/null  (file yang baru diubah)${RESET}"
    echo ""
    echo -e "${GREEN}  PRAKTIK - ANALISIS FILE:${RESET}"
    echo -ne "${WHITE}  Masukkan path file untuk dianalisis: ${RESET}"
    read -r file_path
    if [[ -n "$file_path" && -f "$file_path" ]]; then
        echo ""
        echo -e "${CYAN}  Informasi file:${RESET}"
        stat "$file_path" 2>/dev/null
        echo ""
        echo -e "${CYAN}  Tipe file:${RESET}"
        file "$file_path" 2>/dev/null
        echo ""
        echo -e "${CYAN}  Hash MD5:${RESET}"
        md5sum "$file_path" 2>/dev/null
        echo -e "${CYAN}  Hash SHA256:${RESET}"
        sha256sum "$file_path" 2>/dev/null
    else
        echo -e "${RED}  File tidak ditemukan atau path tidak valid.${RESET}"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}                    FORENSIK DIGITAL${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M11_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M11_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M11_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) teori_forensik ;;
        2) log_analysis ;;
        3) file_analysis ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
