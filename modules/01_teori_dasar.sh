#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

pause_modul() {
    echo ""
    echo -ne "${DIM}  $CT_ENTER${RESET}"
    read -r
}

menu_dasar() {
    while true; do
        clear
        echo -e "${RED}=== $CT_MOD_HDR_1 ===${RESET}"
        echo ""
        echo -e "  ${GREEN}[1]${RESET}  $CT_M1_1"
        echo -e "  ${GREEN}[2]${RESET}  $CT_M1_2"
        echo -e "  ${GREEN}[3]${RESET}  $CT_M1_3"
        echo -e "  ${GREEN}[4]${RESET}  $CT_M1_4"
        echo -e "  ${GREEN}[5]${RESET}  $CT_M1_5"
        echo -e "  ${GREEN}[6]${RESET}  $CT_M1_6"
        echo -e "  ${GREEN}[7]${RESET}  $CT_M1_7"
        echo -e "  ${GREEN}[8]${RESET}  $CT_M1_8"
        echo -e "  ${GREEN}[9]${RESET}  $CT_M1_9"
        echo -e "  ${RED}[0]${RESET}  $CT_BACK"
        echo ""
        echo -ne "  ${CYAN}$CT_MPROMPT${RESET}"
        read -r choice
        case $choice in
            1) belajar_pengertian ;;
            2) belajar_cia_triad ;;
            3) belajar_ancaman ;;
            4) belajar_attack_surface ;;
            5) belajar_ethical_hacking ;;
            6) belajar_terminologi ;;
            7) belajar_hukum ;;
            8) belajar_karir ;;
            9) quiz_dasar ;;
            0) return ;;
            *) echo -e "${RED}$CT_INVALID${RESET}"; sleep 1 ;;
        esac
    done
}

belajar_pengertian() {
    clear
    echo -e "${YELLOW}=== APA ITU CYBER SECURITY? ===${RESET}"
    echo ""
    echo -e "${WHITE}DEFINISI:${RESET}"
    echo "Cyber Security adalah praktik melindungi sistem komputer, jaringan,"
    echo "program, dan data dari serangan digital, kerusakan, atau akses tidak sah."
    echo ""
    echo -e "${WHITE}MENGAPA PENTING?${RESET}"
    echo "- Setiap hari terjadi lebih dari 2.200 serangan siber di seluruh dunia"
    echo "- Kerugian global akibat cybercrime mencapai triliunan dolar per tahun"
    echo "- Data pribadi, keuangan, dan rahasia negara menjadi target utama"
    echo "- Infrastruktur kritis seperti listrik dan air pun rentan diserang"
    echo ""
    echo -e "${WHITE}RUANG LINGKUP CYBER SECURITY:${RESET}"
    echo ""
    echo -e "  ${CYAN}1. Network Security${RESET}"
    echo "     Melindungi jaringan dari intrusi, eavesdropping, dan serangan"
    echo "     Contoh: Firewall, IDS/IPS, VPN"
    echo ""
    echo -e "  ${CYAN}2. Application Security${RESET}"
    echo "     Memastikan aplikasi bebas dari celah keamanan"
    echo "     Contoh: Code review, penetration testing aplikasi"
    echo ""
    echo -e "  ${CYAN}3. Information Security${RESET}"
    echo "     Melindungi integritas dan privasi data"
    echo "     Contoh: Enkripsi, DLP (Data Loss Prevention)"
    echo ""
    echo -e "  ${CYAN}4. Operational Security (OPSEC)${RESET}"
    echo "     Proses dan keputusan untuk menangani aset data"
    echo "     Contoh: Permission management, prosedur keamanan"
    echo ""
    echo -e "  ${CYAN}5. Disaster Recovery${RESET}"
    echo "     Respons terhadap insiden dan pemulihan sistem"
    echo "     Contoh: Backup, incident response plan"
    echo ""
    echo -e "  ${CYAN}6. End-user Education${RESET}"
    echo "     Melatih pengguna tentang praktik keamanan"
    echo "     Contoh: Training anti-phishing, password hygiene"
    echo ""
    echo -e "${WHITE}MODEL KEAMANAN:${RESET}"
    echo ""
    echo "  Defense in Depth - Berlapis-lapis pertahanan"
    echo "  Zero Trust - Jangan percaya siapapun tanpa verifikasi"
    echo "  Least Privilege - Berikan akses minimal yang diperlukan"
    echo "  Need to Know - Informasi hanya untuk yang perlu tahu"
    pause_modul
}

belajar_cia_triad() {
    clear
    echo -e "${YELLOW}=== CIA TRIAD ===${RESET}"
    echo ""
    echo "CIA Triad adalah fondasi utama keamanan informasi yang terdiri dari"
    echo "tiga prinsip inti yang saling melengkapi."
    echo ""
    echo -e "${RED}C - CONFIDENTIALITY (KERAHASIAAN)${RESET}"
    echo "-------------------------------------"
    echo "Definisi: Memastikan informasi hanya dapat diakses oleh pihak yang berwenang"
    echo ""
    echo "Ancaman terhadap Confidentiality:"
    echo "  - Eavesdropping: Menyadap komunikasi"
    echo "  - Data breach: Kebocoran data"
    echo "  - Social engineering: Manipulasi psikologis"
    echo "  - Shoulder surfing: Mengintip layar"
    echo ""
    echo "Cara Melindungi:"
    echo "  - Enkripsi data (AES, RSA, TLS)"
    echo "  - Access control (username/password, biometrik)"
    echo "  - Data classification"
    echo "  - VPN untuk komunikasi aman"
    echo ""
    echo -e "${GREEN}I - INTEGRITY (INTEGRITAS)${RESET}"
    echo "-------------------------------------"
    echo "Definisi: Memastikan data tidak dimodifikasi secara tidak sah"
    echo ""
    echo "Ancaman terhadap Integrity:"
    echo "  - Man-in-the-Middle: Mengubah data saat transmisi"
    echo "  - SQL Injection: Memodifikasi database"
    echo "  - Malware: Mengubah file sistem"
    echo "  - Insider threat: Modifikasi oleh orang dalam"
    echo ""
    echo "Cara Melindungi:"
    echo "  - Hash function (MD5, SHA-256)"
    echo "  - Digital signature"
    echo "  - Checksum verification"
    echo "  - Version control"
    echo ""
    echo -e "${CYAN}A - AVAILABILITY (KETERSEDIAAN)${RESET}"
    echo "-------------------------------------"
    echo "Definisi: Memastikan sistem dan data selalu tersedia saat dibutuhkan"
    echo ""
    echo "Ancaman terhadap Availability:"
    echo "  - DDoS (Distributed Denial of Service)"
    echo "  - Ransomware: Mengenkripsi data dan meminta tebusan"
    echo "  - Hardware failure"
    echo "  - Natural disaster"
    echo ""
    echo "Cara Melindungi:"
    echo "  - Redundancy dan failover"
    echo "  - Load balancing"
    echo "  - Regular backup"
    echo "  - DDoS protection"
    echo "  - UPS (Uninterruptible Power Supply)"
    echo ""
    echo -e "${WHITE}CONTOH NYATA CIA TRIAD:${RESET}"
    echo ""
    echo "  Skenario: Sistem perbankan online"
    echo "  - Confidentiality: PIN dan nomor rekening terenkripsi"
    echo "  - Integrity: Transaksi tidak bisa dimanipulasi"
    echo "  - Availability: ATM harus 24/7 bisa diakses"
    pause_modul
}

belajar_ancaman() {
    clear
    echo -e "${YELLOW}=== JENIS-JENIS ANCAMAN SIBER ===${RESET}"
    echo ""
    echo -e "${RED}1. MALWARE${RESET}"
    echo "   Software berbahaya yang dirancang untuk merusak sistem"
    echo ""
    echo "   Virus        : Menempel pada file, menyebar saat file dijalankan"
    echo "   Worm         : Menyebar sendiri tanpa interaksi pengguna"
    echo "   Trojan       : Menyamar sebagai software legitimate"
    echo "   Ransomware   : Mengenkripsi data dan meminta tebusan"
    echo "   Spyware      : Mencuri informasi diam-diam"
    echo "   Adware       : Menampilkan iklan berbahaya"
    echo "   Rootkit      : Menyembunyikan keberadaannya di sistem"
    echo "   Keylogger    : Merekam semua ketikan keyboard"
    echo ""
    echo -e "${RED}2. SERANGAN JARINGAN${RESET}"
    echo "   Man-in-the-Middle (MitM)"
    echo "     Penyerang berada di antara dua pihak yang berkomunikasi"
    echo "     Dapat membaca dan mengubah data yang dikirim"
    echo ""
    echo "   Denial of Service (DoS/DDoS)"
    echo "     Membanjiri server dengan request sehingga tidak bisa melayani user"
    echo "     DDoS menggunakan banyak komputer (botnet)"
    echo ""
    echo "   Packet Sniffing"
    echo "     Menangkap dan menganalisis paket data di jaringan"
    echo "     Bisa mendapatkan password, session token, dll"
    echo ""
    echo "   ARP Poisoning/Spoofing"
    echo "     Mengasosiasikan MAC address penyerang dengan IP korban"
    echo "     Memungkinkan intersepsi komunikasi jaringan"
    echo ""
    echo -e "${RED}3. SERANGAN WEB${RESET}"
    echo "   SQL Injection : Menyisipkan query SQL berbahaya"
    echo "   XSS           : Cross-Site Scripting, inject kode JavaScript"
    echo "   CSRF          : Cross-Site Request Forgery"
    echo "   Directory Traversal : Akses file diluar direktori yang diizinkan"
    echo "   RFI/LFI       : Remote/Local File Inclusion"
    echo "   SSRF          : Server-Side Request Forgery"
    echo ""
    echo -e "${RED}4. SOCIAL ENGINEERING${RESET}"
    echo "   Phishing      : Email palsu untuk mencuri kredensial"
    echo "   Spear Phishing: Phishing yang ditarget ke individu spesifik"
    echo "   Vishing       : Phishing via telepon"
    echo "   Smishing      : Phishing via SMS"
    echo "   Baiting       : Meninggalkan USB drive berbahaya"
    echo "   Pretexting    : Membuat skenario palsu"
    echo "   Tailgating    : Masuk area restricted mengikuti orang lain"
    echo ""
    echo -e "${RED}5. INSIDER THREAT${RESET}"
    echo "   Malicious Insider : Karyawan yang sengaja merusak"
    echo "   Negligent Insider : Karyawan yang tidak sengaja membuka celah"
    echo "   Compromised Insider: Karyawan yang akunnya dibajak"
    pause_modul
}

belajar_attack_surface() {
    clear
    echo -e "${YELLOW}=== ATTACK SURFACE DAN ATTACK VECTOR ===${RESET}"
    echo ""
    echo -e "${WHITE}ATTACK SURFACE${RESET}"
    echo "Attack Surface adalah keseluruhan titik-titik dimana penyerang"
    echo "bisa mencoba mendapatkan akses atau mengekstrak data."
    echo ""
    echo "Komponen Attack Surface:"
    echo ""
    echo "  Digital Attack Surface:"
    echo "  - Aplikasi web dan API yang bisa diakses publik"
    echo "  - Port dan layanan jaringan yang terbuka"
    echo "  - Software dan sistem operasi (patch vulnerability)"
    echo "  - Kode sumber aplikasi"
    echo "  - Konfigurasi sistem yang salah"
    echo ""
    echo "  Physical Attack Surface:"
    echo "  - Perangkat keras yang bisa diakses fisik"
    echo "  - USB port, CD drive"
    echo "  - Printer, scanner, kamera"
    echo ""
    echo "  Social Engineering Attack Surface:"
    echo "  - Karyawan (target phishing)"
    echo "  - Vendor dan third party"
    echo "  - Kontraktor"
    echo ""
    echo -e "${WHITE}ATTACK VECTOR${RESET}"
    echo "Attack Vector adalah jalur atau metode yang digunakan penyerang"
    echo "untuk mengeksploitasi kerentanan."
    echo ""
    echo "  Email          : Phishing, attachment berbahaya"
    echo "  Web Browser    : Drive-by download, malicious website"
    echo "  USB/Removable  : AutoRun malware, BadUSB"
    echo "  Wireless       : Wi-Fi attack, Bluetooth exploit"
    echo "  Supply Chain   : Kompromi software vendor"
    echo "  Insider        : Akses langsung dari dalam"
    echo ""
    echo -e "${WHITE}PRINSIP MEMPERKECIL ATTACK SURFACE:${RESET}"
    echo ""
    echo "  1. Disable layanan yang tidak diperlukan"
    echo "  2. Tutup port yang tidak digunakan"
    echo "  3. Implementasikan least privilege"
    echo "  4. Regular patching dan update"
    echo "  5. Segmentasi jaringan"
    echo "  6. Input validation pada semua aplikasi"
    echo "  7. Remove default credentials"
    echo ""
    echo -e "${WHITE}VISUALISASI ATTACK SURFACE:${RESET}"
    echo ""
    echo "  Internet"
    echo "     |"
    echo "  [Firewall] <-- Filter traffic masuk"
    echo "     |"
    echo "  [DMZ Zone]   <-- Web server, mail server"
    echo "     |"
    echo "  [Internal Firewall]"
    echo "     |"
    echo "  [Internal Network] <-- Database, file server"
    echo "     |"
    echo "  [Endpoint]  <-- Workstation, laptop"
    pause_modul
}

belajar_ethical_hacking() {
    clear
    echo -e "${YELLOW}=== ETHICAL HACKING DAN PENETRATION TESTING ===${RESET}"
    echo ""
    echo -e "${WHITE}APA ITU ETHICAL HACKING?${RESET}"
    echo "Ethical hacking adalah proses mencoba membobol sistem komputer, jaringan,"
    echo "atau aplikasi dengan izin pemiliknya untuk menemukan kelemahan keamanan"
    echo "sebelum penyerang jahat menemukannya."
    echo ""
    echo -e "${WHITE}JENIS-JENIS PENETRATION TESTER:${RESET}"
    echo ""
    echo -e "  ${RED}Black Hat Hacker${RESET}"
    echo "  Hacker jahat yang menyerang tanpa izin untuk keuntungan pribadi"
    echo "  Melanggar hukum dan etika"
    echo ""
    echo -e "  ${WHITE}White Hat Hacker${RESET}"
    echo "  Ethical hacker yang bekerja dengan izin untuk meningkatkan keamanan"
    echo "  Biasanya memiliki sertifikasi seperti CEH, OSCP"
    echo ""
    echo -e "  ${DIM}Grey Hat Hacker${RESET}"
    echo "  Kombinasi dari keduanya, mungkin menemukan celah tanpa izin"
    echo "  tapi tidak mengeksploitasinya untuk kejahatan"
    echo ""
    echo -e "${WHITE}METODOLOGI PENETRATION TESTING:${RESET}"
    echo ""
    echo "  Phase 1: Reconnaissance (Pengintaian)"
    echo "  - Passive Recon: OSINT, Google dork, Whois"
    echo "  - Active Recon: Port scanning, service enumeration"
    echo ""
    echo "  Phase 2: Scanning and Enumeration"
    echo "  - Network scanning (nmap)"
    echo "  - Vulnerability scanning"
    echo "  - Service dan version detection"
    echo ""
    echo "  Phase 3: Gaining Access"
    echo "  - Exploit vulnerabilities"
    echo "  - Password cracking"
    echo "  - Social engineering"
    echo ""
    echo "  Phase 4: Maintaining Access"
    echo "  - Install backdoor"
    echo "  - Privilege escalation"
    echo "  - Lateral movement"
    echo ""
    echo "  Phase 5: Covering Tracks"
    echo "  - Clear logs"
    echo "  - Remove artifacts"
    echo ""
    echo "  Phase 6: Reporting"
    echo "  - Dokumentasi temuan"
    echo "  - Rekomendasi perbaikan"
    echo ""
    echo -e "${WHITE}JENIS PENTEST BERDASARKAN INFORMASI:${RESET}"
    echo ""
    echo "  Black Box : Tidak ada informasi awal tentang target"
    echo "  White Box : Informasi lengkap diberikan (source code, network diagram)"
    echo "  Grey Box  : Informasi parsial diberikan"
    echo ""
    echo -e "${RED}PERINGATAN LEGAL:${RESET}"
    echo "  Selalu dapatkan izin tertulis sebelum melakukan penetration testing!"
    echo "  Menyerang sistem tanpa izin adalah tindakan kriminal!"
    pause_modul
}

belajar_terminologi() {
    clear
    echo -e "${YELLOW}=== TERMINOLOGI PENTING CYBER SECURITY ===${RESET}"
    echo ""
    echo -e "${WHITE}A - F${RESET}"
    echo "  APT (Advanced Persistent Threat)"
    echo "    Serangan siber yang canggih, terencana, dan berlangsung lama"
    echo "    Biasanya disponsori negara atau kelompok terorganisir"
    echo ""
    echo "  Authentication : Proses verifikasi identitas"
    echo "  Authorization  : Proses pemberian hak akses"
    echo "  Backdoor       : Akses tersembunyi ke sistem"
    echo "  Botnet         : Jaringan komputer yang terinfeksi malware"
    echo "  Buffer Overflow: Memasukkan data melebihi kapasitas buffer"
    echo "  CVE            : Common Vulnerabilities and Exposures"
    echo "  DLP            : Data Loss Prevention"
    echo "  DMZ            : Demilitarized Zone, zona jaringan semi-terpercaya"
    echo "  Exploit        : Kode yang memanfaatkan kerentanan"
    echo ""
    echo -e "${WHITE}G - N${RESET}"
    echo "  Honeypot    : Sistem umpan untuk menarik dan menganalisis penyerang"
    echo "  IDS         : Intrusion Detection System"
    echo "  IPS         : Intrusion Prevention System"
    echo "  IOC         : Indicator of Compromise"
    echo "  Lateral Movement: Gerakan penyerang dalam jaringan setelah masuk"
    echo "  MFA         : Multi-Factor Authentication"
    echo "  MITM        : Man-in-the-Middle Attack"
    echo ""
    echo -e "${WHITE}O - Z${RESET}"
    echo "  OSINT       : Open Source Intelligence"
    echo "  Payload     : Kode berbahaya dalam exploit atau malware"
    echo "  Pentest     : Penetration Testing"
    echo "  Pivoting    : Menggunakan sistem yang sudah dikompromikan untuk menyerang sistem lain"
    echo "  Privilege Escalation: Mendapatkan hak akses lebih tinggi"
    echo "  Rootkit     : Software untuk menyembunyikan aktivitas berbahaya"
    echo "  SIEM        : Security Information and Event Management"
    echo "  SOC         : Security Operations Center"
    echo "  Social Engineering: Manipulasi psikologis untuk mendapatkan informasi"
    echo "  TTPs        : Tactics, Techniques, and Procedures"
    echo "  Threat Actor: Individu/kelompok yang melakukan serangan"
    echo "  Zero-day    : Kerentanan yang belum diketahui vendor"
    echo "  Zombie      : Komputer yang dikendalikan oleh penyerang (bagian botnet)"
    pause_modul
}

belajar_hukum() {
    clear
    echo -e "${YELLOW}=== HUKUM DAN ETIKA DALAM CYBER SECURITY ===${RESET}"
    echo ""
    echo -e "${WHITE}HUKUM CYBER SECURITY DI INDONESIA:${RESET}"
    echo ""
    echo "  UU ITE (Undang-Undang Informasi dan Transaksi Elektronik)"
    echo "  No. 11 Tahun 2008 jo UU No. 19 Tahun 2016"
    echo ""
    echo "  Pasal-pasal penting:"
    echo "  - Pasal 30: Akses illegal ke sistem elektronik"
    echo "    Ancaman: Pidana 6-8 tahun, denda 600 juta - 800 juta rupiah"
    echo ""
    echo "  - Pasal 31: Intersepsi/penyadapan ilegal"
    echo "    Ancaman: Pidana 10-15 tahun, denda 800 juta - 5 milyar rupiah"
    echo ""
    echo "  - Pasal 32: Pengubahan data"
    echo "    Ancaman: Pidana 8-10 tahun, denda 2-5 milyar rupiah"
    echo ""
    echo "  - Pasal 33: Gangguan terhadap sistem"
    echo "    Ancaman: Pidana 10 tahun, denda 10 milyar rupiah"
    echo ""
    echo -e "${WHITE}HUKUM INTERNASIONAL:${RESET}"
    echo ""
    echo "  Computer Fraud and Abuse Act (CFAA) - Amerika Serikat"
    echo "  Computer Misuse Act - Inggris"
    echo "  Budapest Convention on Cybercrime - Eropa"
    echo "  GDPR - Regulasi perlindungan data di Eropa"
    echo ""
    echo -e "${WHITE}KODE ETIK ETHICAL HACKER:${RESET}"
    echo ""
    echo "  1. Selalu dapatkan izin tertulis sebelum testing"
    echo "  2. Hormati privasi dan jaga kerahasiaan data"
    echo "  3. Laporkan semua temuan kepada klien"
    echo "  4. Jangan merusak atau mengubah sistem"
    echo "  5. Jangan akses data yang tidak relevan dengan pentest"
    echo "  6. Patuhi scope yang sudah disepakati"
    echo "  7. Dokumentasikan semua aktivitas"
    echo "  8. Jangan gunakan teknik yang bisa merusak produksi"
    echo ""
    echo -e "${RED}INGAT: Ethical hacker yang baik adalah yang bisa menjelaskan${RESET}"
    echo -e "${RED}setiap tindakannya dengan dasar hukum yang jelas!${RESET}"
    pause_modul
}

belajar_karir() {
    clear
    echo -e "${YELLOW}=== KARIR DI BIDANG CYBER SECURITY ===${RESET}"
    echo ""
    echo -e "${WHITE}JALUR KARIR POPULER:${RESET}"
    echo ""
    echo -e "  ${GREEN}Penetration Tester / Ethical Hacker${RESET}"
    echo "  Gaji rata-rata: Rp 8-25 juta/bulan"
    echo "  Skills: Hacking tools, programming, networking"
    echo "  Sertifikasi: CEH, OSCP, GPEN"
    echo ""
    echo -e "  ${GREEN}Security Analyst (SOC Analyst)${RESET}"
    echo "  Gaji rata-rata: Rp 6-15 juta/bulan"
    echo "  Skills: Log analysis, SIEM, incident response"
    echo "  Sertifikasi: CompTIA Security+, CySA+"
    echo ""
    echo -e "  ${GREEN}Malware Analyst / Reverse Engineer${RESET}"
    echo "  Gaji rata-rata: Rp 10-30 juta/bulan"
    echo "  Skills: Assembly, debugger, disassembler"
    echo "  Sertifikasi: GREM, CREA"
    echo ""
    echo -e "  ${GREEN}Digital Forensic Investigator${RESET}"
    echo "  Gaji rata-rata: Rp 8-20 juta/bulan"
    echo "  Skills: Evidence collection, forensic tools, chain of custody"
    echo "  Sertifikasi: GCFE, GCFA, EnCE"
    echo ""
    echo -e "  ${GREEN}Security Architect${RESET}"
    echo "  Gaji rata-rata: Rp 20-50 juta/bulan"
    echo "  Skills: Network design, security frameworks, risk management"
    echo "  Sertifikasi: CISSP, SABSA, TOGAF"
    echo ""
    echo -e "  ${GREEN}Bug Bounty Hunter${RESET}"
    echo "  Penghasilan: Bervariasi, bisa ratusan juta per temuan"
    echo "  Skills: Web hacking, mobile hacking, API testing"
    echo "  Platform: HackerOne, Bugcrowd, Synack"
    echo ""
    echo -e "${WHITE}SERTIFIKASI POPULER (Berdasarkan $CT_LEVEL):${RESET}"
    echo ""
    echo "  $CT_LVL_NB  : CompTIA A+, Network+, Security+"
    echo "  $CT_LVL_INT : CEH, CASP+, eJPT, PNPT"
    echo "  $CT_LVL_ADV : OSCP, GPEN, GXPN, CISSP"
    echo "  Spesialis: GREM (malware), GCFE (forensic), GWAPT (web)"
    echo ""
    echo -e "${WHITE}ROADMAP BELAJAR CYBER SECURITY:${RESET}"
    echo ""
    echo "  1. Networking dasar (TCP/IP, OSI Model)"
    echo "  2. Linux/Windows dasar"
    echo "  3. Programming (Python, Bash)"
    echo "  4. Konsep keamanan dasar"
    echo "  5. Web technologies (HTML, HTTP, SQL)"
    echo "  6. Tools keamanan (Nmap, Wireshark, Metasploit)"
    echo "  7. Praktik di lab (TryHackMe, HackTheBox)"
    echo "  8. Sertifikasi"
    echo "  9. Bug bounty / CTF"
    echo "  10. Specialized skills"
    pause_modul
}

quiz_dasar() {
    clear
    echo -e "${YELLOW}=== QUIZ: $CT_MOD_HDR_1 ===${RESET}"
    echo ""
    local score=0
    local total=5

    echo -e "${WHITE}$CT_Q 1:${RESET}"
    echo "Apa singkatan dari CIA dalam CIA Triad?"
    echo "a) Computer, Internet, Access"
    echo "b) Confidentiality, Integrity, Availability"
    echo "c) Cybersecurity, Intelligence, Analysis"
    echo "d) Control, Identify, Authenticate"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "b" || "$ans" == "B" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"
        ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: b) Confidentiality, Integrity, Availability${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 2:${RESET}"
    echo "Serangan yang membanjiri server dengan request sehingga tidak bisa melayani"
    echo "user normal disebut serangan:"
    echo "a) SQL Injection"
    echo "b) Phishing"
    echo "c) DoS/DDoS"
    echo "d) Man-in-the-Middle"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "c" || "$ans" == "C" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"
        ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: c) DoS/DDoS${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 3:${RESET}"
    echo "Ethical hacker yang bekerja dengan izin untuk meningkatkan keamanan disebut:"
    echo "a) Black Hat Hacker"
    echo "b) Grey Hat Hacker"
    echo "c) Script Kiddie"
    echo "d) White Hat Hacker"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "d" || "$ans" == "D" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"
        ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: d) White Hat Hacker${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 4:${RESET}"
    echo "Kerentanan yang belum diketahui oleh vendor disebut:"
    echo "a) Old-day vulnerability"
    echo "b) Zero-day vulnerability"
    echo "c) N-day vulnerability"
    echo "d) First-day vulnerability"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "b" || "$ans" == "B" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"
        ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: b) Zero-day vulnerability${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 5:${RESET}"
    echo "Dalam penetration testing, informasi apa yang diberikan pada Black Box testing?"
    echo "a) Semua informasi tentang target"
    echo "b) Sebagian informasi tentang target"
    echo "c) Tidak ada informasi tentang target"
    echo "d) Hanya source code aplikasi"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "c" || "$ans" == "C" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"
        ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: c) Tidak ada informasi tentang target${RESET}"
    fi
    echo ""

    echo -e "${YELLOW}=== $CT_RESULT ===${RESET}"
    echo -e "$CT_SCORE: ${WHITE}$score / $total${RESET}"
    if [ $score -eq 5 ]; then
        echo -e "${GREEN}[$CT_PASSED] Sempurna!${RESET}"
    elif [ $score -ge 3 ]; then
        echo -e "${YELLOW}[$CT_ENOUGH]${RESET}"
    else
        echo -e "${RED}[$CT_NOT_PASSED]${RESET}"
    fi
    pause_modul
}

# Jalankan menu utama modul
menu_dasar
