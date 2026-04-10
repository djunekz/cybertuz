#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CYBERTUZ_DIR/logs"
REPORT_DIR="$CYBERTUZ_DIR/reports"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi
press_enter() { echo ""; echo -ne "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                  LAPORAN & PROGRESS BELAJAR"; echo "  ================================================================="; echo -e "${RESET}"; }

show_progress() {
    header
    echo -e "${CYAN}  PROGRESS BELAJAR KAMU${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    ctf_score=0
    if [[ -f "$LOG_DIR/ctf_score.txt" ]]; then
        ctf_score=$(cat "$LOG_DIR/ctf_score.txt")
    fi
    echo -e "${WHITE}  $CT_SCORE CTF: ${YELLOW}$ctf_score${RESET}"
    echo ""
    if [[ -f "$LOG_DIR/cybertuz.log" ]]; then
        total_actions=$(wc -l < "$LOG_DIR/cybertuz.log")
        echo -e "${WHITE}  Total aktivitas tercatat: ${YELLOW}$total_actions${RESET}"
        echo ""
        echo -e "${GREEN}  Aktivitas terbaru:${RESET}"
        tail -10 "$LOG_DIR/cybertuz.log"
    fi
    echo ""
    echo -e "${GREEN}  ROADMAP BELAJAR CYBER SECURITY:${RESET}"
    echo ""
    echo -e "${WHITE}  BEGINNER (0-3 bulan):${RESET}"
    echo -e "${WHITE}  [ ] Jaringan dasar (TCP/IP, OSI Model, DNS, HTTP)${RESET}"
    echo -e "${WHITE}  [ ] Linux command line dasar${RESET}"
    echo -e "${WHITE}  [ ] CIA Triad dan konsep security dasar${RESET}"
    echo -e "${WHITE}  [ ] Kriptografi dasar${RESET}"
    echo ""
    echo -e "${WHITE}  INTERMEDIATE (3-12 bulan):${RESET}"
    echo -e "${WHITE}  [ ] Penetration testing methodology${RESET}"
    echo -e "${WHITE}  [ ] Web application security (OWASP Top 10)${RESET}"
    echo -e "${WHITE}  [ ] Network scanning dan enumeration${RESET}"
    echo -e "${WHITE}  [ ] CTF challenges (TryHackMe, HackTheBox)${RESET}"
    echo ""
    echo -e "${WHITE}  ADVANCED (1-2 tahun):${RESET}"
    echo -e "${WHITE}  [ ] Exploit development${RESET}"
    echo -e "${WHITE}  [ ] Malware analysis${RESET}"
    echo -e "${WHITE}  [ ] Red team operations${RESET}"
    echo -e "${WHITE}  [ ] Sertifikasi (OSCP, CEH, eJPT)${RESET}"
    press_enter
}

generate_report() {
    header
    echo -e "${CYAN}  BUAT LAPORAN SCANNING${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Template laporan penetration testing sederhana.${RESET}"
    echo ""
    echo -ne "${WHITE}  Nama target: ${RESET}"
    read -r rpt_target
    echo -ne "${WHITE}  Tanggal testing: ${RESET}"
    read -r rpt_date
    echo -ne "${WHITE}  Nama tester: ${RESET}"
    read -r rpt_tester
    
    report_file="$REPORT_DIR/report_$(date '+%Y%m%d_%H%M%S').txt"
    
    cat > "$report_file" << REPORTEOF
=============================================================================
          LAPORAN PENETRATION TESTING - CYBERTUZ
=============================================================================

Target        : $rpt_target
Tanggal       : $rpt_date
Tester        : $rpt_tester
Dibuat dengan : CyberTuz

=============================================================================
RINGKASAN EKSEKUTIF
=============================================================================

[Isi ringkasan temuan di sini]

=============================================================================
SCOPE & METODOLOGI
=============================================================================

Scope       : $rpt_target
Metodologi  : Black box / Grey box / White box (pilih sesuai)
Framework   : OWASP Testing Guide / PTES / OSSTMM

=============================================================================
TEMUAN KERENTANAN
=============================================================================

ID     | Severity | Judul                    | CVSS
-------|----------|--------------------------|------
VULN-1 | Critical | [Nama Kerentanan]        | 9.8
VULN-2 | High     | [Nama Kerentanan]        | 7.5
VULN-3 | Medium   | [Nama Kerentanan]        | 5.0
VULN-4 | Low      | [Nama Kerentanan]        | 2.5

=============================================================================
DETAIL KERENTANAN
=============================================================================

VULN-1: [Nama Kerentanan]
--------------------------
Severity  : Critical
CVSS Score: 9.8
Lokasi    : [URL/IP/Port]

Deskripsi:
[Jelaskan kerentanan ini]

Bukti (Proof of Concept):
[Screenshot atau output]

Dampak:
[Jelaskan dampak jika dieksploitasi]

Rekomendasi:
[Jelaskan cara memperbaiki]

=============================================================================
REKOMENDASI UMUM
=============================================================================

1. Terapkan patch keamanan secara berkala
2. Gunakan password yang kuat dan unik
3. Aktifkan Multi-Factor Authentication (MFA)
4. Monitor log sistem secara rutin
5. Lakukan security training untuk karyawan

=============================================================================
KESIMPULAN
=============================================================================

[Kesimpulan keseluruhan testing]

=============================================================================
REPORTEOF

    echo ""
    echo -e "${GREEN}  Laporan berhasil dibuat: $report_file${RESET}"
    echo ""
    echo -e "${YELLOW}  Isi laporan:${RESET}"
    cat "$report_file"
    press_enter
}

resources() {
    header
    echo -e "${CYAN}  SUMBER BELAJAR CYBER SECURITY${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  PLATFORM BELAJAR ONLINE:${RESET}"
    echo -e "${WHITE}  TryHackMe        : tryhackme.com (pemula, guided)${RESET}"
    echo -e "${WHITE}  HackTheBox       : hackthebox.com (intermediate-advanced)${RESET}"
    echo -e "${WHITE}  PortSwigger Academy: portswigger.net/web-security (web security)${RESET}"
    echo -e "${WHITE}  PicoCTF          : picoctf.org (beginner CTF)${RESET}"
    echo -e "${WHITE}  OWASP            : owasp.org (web security resources)${RESET}"
    echo ""
    echo -e "${GREEN}  SERTIFIKASI YANG DIREKOMENDASIKAN:${RESET}"
    echo -e "${WHITE}  CompTIA Security+ : Entry level, diakui industri${RESET}"
    echo -e "${WHITE}  eJPT (eLearnSecurity): Bagus untuk pemula pentesting${RESET}"
    echo -e "${WHITE}  CEH (EC-Council) : Certified Ethical Hacker${RESET}"
    echo -e "${WHITE}  OSCP (Offensive Security): Gold standard pentesting${RESET}"
    echo -e "${WHITE}  CISSP            : Senior security professional${RESET}"
    echo ""
    echo -e "${GREEN}  BUKU YANG DIREKOMENDASIKAN:${RESET}"
    echo -e "${WHITE}  The Web Application Hacker's Handbook${RESET}"
    echo -e "${WHITE}  Penetration Testing (Georgia Weidman)${RESET}"
    echo -e "${WHITE}  The Art of Exploitation (Jon Erickson)${RESET}"
    echo -e "${WHITE}  Hacking: The Art of Exploitation${RESET}"
    echo ""
    echo -e "${GREEN}  CHANNEL YOUTUBE:${RESET}"
    echo -e "${WHITE}  IppSec           : Walkthrough HackTheBox${RESET}"
    echo -e "${WHITE}  John Hammond     : CTF dan malware analysis${RESET}"
    echo -e "${WHITE}  LiveOverflow     : Security research mendalam${RESET}"
    echo -e "${WHITE}  NetworkChuck     : Networking dan security umum${RESET}"
    echo ""
    echo -e "${GREEN}  KOMUNITAS:${RESET}"
    echo -e "${WHITE}  Reddit: r/netsec, r/hacking, r/cybersecurity${RESET}"
    echo -e "${WHITE}  Discord: HackTheBox, TryHackMe, OWASP${RESET}"
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               LAPORAN & PROGRESS BELAJAR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M15_1${RESET}"
    echo -e "${GREEN}  [2] $CT_M15_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M15_3${RESET}"
    echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"
    read -r pilihan
    case $pilihan in
        1) show_progress ;;
        2) generate_report ;;
        3) resources ;;
        0) exit 0 ;;
        *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
