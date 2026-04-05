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

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'

pause_modul() {
    echo ""
    echo -e "${DIM}Tekan ENTER untuk melanjutkan...${RESET}"
    read -r
}

menu_recon() {
    while true; do
        clear
        echo -e "${RED}=== MODUL 3: RECONNAISSANCE & INFORMATION GATHERING ===${RESET}"
        echo ""
        echo -e "  ${GREEN}[1]${RESET}  Apa itu Reconnaissance?"
        echo -e "  ${GREEN}[2]${RESET}  Passive Reconnaissance (OSINT)"
        echo -e "  ${GREEN}[3]${RESET}  Google Dorking"
        echo -e "  ${GREEN}[4]${RESET}  WHOIS Lookup"
        echo -e "  ${GREEN}[5]${RESET}  DNS Enumeration"
        echo -e "  ${GREEN}[6]${RESET}  Email Harvesting"
        echo -e "  ${GREEN}[7]${RESET}  Social Media OSINT"
        echo -e "  ${GREEN}[8]${RESET}  Simulasi OSINT Investigation"
        echo -e "  ${GREEN}[9]${RESET}  Lab: WHOIS dan DNS Lookup"
        echo -e "  ${RED}[0]${RESET}  $CT_BACK"
        echo ""
        echo -ne "  ${CYAN}$CT_MPROMPT${RESET}"
        read -r choice
        case $choice in
            1) belajar_recon_intro ;;
            2) belajar_passive_recon ;;
            3) belajar_google_dork ;;
            4) belajar_whois ;;
            5) belajar_dns_enum ;;
            6) belajar_email_harvest ;;
            7) belajar_social_osint ;;
            8) simulasi_osint ;;
            9) lab_whois_dns ;;
            0) return ;;
            *) echo -e "${RED}$CT_INVALID${RESET}"; sleep 1 ;;
        esac
    done
}

belajar_recon_intro() {
    clear
    echo -e "${YELLOW}=== APA ITU RECONNAISSANCE? ===${RESET}"
    echo ""
    echo "Reconnaissance (recon) adalah fase pertama dalam penetration testing"
    echo "dimana tester mengumpulkan informasi sebanyak mungkin tentang target"
    echo "SEBELUM melakukan serangan."
    echo ""
    echo -e "${WHITE}MENGAPA RECON PENTING?${RESET}"
    echo ""
    echo "  - Memahami infrastruktur target"
    echo "  - Menemukan entry point yang potensial"
    echo "  - Mengidentifikasi teknologi yang digunakan"
    echo "  - Menemukan informasi yang bisa dieksploitasi"
    echo "  - Mengurangi kemungkinan terdeteksi"
    echo ""
    echo -e "${WHITE}JENIS RECONNAISSANCE:${RESET}"
    echo ""
    echo -e "  ${GREEN}Passive Reconnaissance${RESET}"
    echo "  Mengumpulkan informasi TANPA berinteraksi langsung dengan target"
    echo "  Menggunakan sumber publik (OSINT)"
    echo "  Tidak meninggalkan jejak di server target"
    echo "  Contoh: Google dork, Whois, LinkedIn scraping"
    echo ""
    echo -e "  ${RED}Active Reconnaissance${RESET}"
    echo "  Berinteraksi LANGSUNG dengan sistem target"
    echo "  Meninggalkan jejak di log server"
    echo "  Memerlukan izin (dalam konteks pentest resmi)"
    echo "  Contoh: Port scanning, web crawling"
    echo ""
    echo -e "${WHITE}INFORMASI YANG DICARI:${RESET}"
    echo ""
    echo "  Target Organisasi:"
    echo "  - Nama perusahaan, lokasi, struktur organisasi"
    echo "  - Daftar karyawan dan jabatan"
    echo "  - Alamat email format"
    echo "  - Nomor telepon, fax"
    echo "  - Partner bisnis dan vendor"
    echo ""
    echo "  Target Teknis:"
    echo "  - Domain dan subdomain"
    echo "  - IP address ranges"
    echo "  - Teknologi yang digunakan (CMS, framework, server)"
    echo "  - Port dan layanan terbuka"
    echo "  - Kebijakan keamanan"
    echo ""
    echo -e "${WHITE}TOOLS RECON POPULER:${RESET}"
    echo ""
    echo "  Passive: theHarvester, Maltego, SpiderFoot, Recon-ng"
    echo "  Active: Nmap, Nikto, DirBuster, Gobuster"
    echo "  DNS: DNSdumpster, Subfinder, Amass"
    echo "  Web: Shodan, Censys, BuiltWith"
    pause_modul
}

belajar_passive_recon() {
    clear
    echo -e "${YELLOW}=== PASSIVE RECONNAISSANCE (OSINT) ===${RESET}"
    echo ""
    echo "OSINT = Open Source Intelligence"
    echo "Mengumpulkan informasi dari sumber yang tersedia untuk publik"
    echo ""
    echo -e "${WHITE}SUMBER OSINT:${RESET}"
    echo ""
    echo -e "  ${CYAN}Search Engines:${RESET}"
    echo "  Google, Bing, DuckDuckGo, Yandex"
    echo "  Gunakan operator pencarian canggih (dork)"
    echo ""
    echo -e "  ${CYAN}WHOIS Databases:${RESET}"
    echo "  Informasi registrasi domain"
    echo "  Nama registrant, alamat, nomor telepon"
    echo "  Situs: whois.domaintools.com, who.is"
    echo ""
    echo -e "  ${CYAN}DNS Records:${RESET}"
    echo "  MX records (mail server)"
    echo "  A records (IP address)"
    echo "  Subdomain enumeration"
    echo "  Situs: DNSdumpster.com, SecurityTrails"
    echo ""
    echo -e "  ${CYAN}Social Media:${RESET}"
    echo "  LinkedIn: Karyawan, jabatan, teknologi"
    echo "  Twitter: Informasi perusahaan, karyawan"
    echo "  GitHub: Source code, credential yang bocor"
    echo "  Instagram: Informasi lokasi, jadwal"
    echo ""
    echo -e "  ${CYAN}Specialized Databases:${RESET}"
    echo "  Shodan.io      : Perangkat yang terkoneksi internet"
    echo "  Censys.io      : Sertifikat SSL, open ports"
    echo "  BuiltWith.com  : Teknologi website"
    echo "  WaybackMachine : Arsip website lama"
    echo "  HaveIBeenPwned : Data breach"
    echo "  Pastebin/Github: Leaked credentials"
    echo ""
    echo -e "  ${CYAN}Job Postings:${RESET}"
    echo "  Iklan lowongan kerja mengungkap:"
    echo "  - Teknologi yang digunakan (Apache, Nginx, AWS)"
    echo "  - Kualifikasi yang dicari (Python, Java)"
    echo "  - Tim dan struktur organisasi"
    echo ""
    echo -e "${WHITE}CONTOH INFORMASI DARI OSINT:${RESET}"
    echo ""
    echo "  Domain: example.com"
    echo "  Dari Whois     : Registrant: John Doe, john@example.com"
    echo "  Dari DNS       : Subdomain: mail, vpn, dev, staging"
    echo "  Dari LinkedIn  : 150 karyawan, CTO: Jane Smith"
    echo "  Dari GitHub    : Repo publik dengan API key di commit lama"
    echo "  Dari Shodan    : Port 8080 terbuka, Apache 2.4.1 (outdated)"
    echo "  Dari WayBack   : Website lama ada file /backup.zip"
    pause_modul
}

belajar_google_dork() {
    clear
    echo -e "${YELLOW}=== GOOGLE DORKING ===${RESET}"
    echo ""
    echo "Google Dorking (Google Hacking) adalah teknik menggunakan operator"
    echo "pencarian Google yang canggih untuk menemukan informasi sensitif."
    echo ""
    echo -e "${WHITE}OPERATOR GOOGLE DASAR:${RESET}"
    echo ""
    printf "  %-25s %s\n" "OPERATOR" "FUNGSI"
    echo "  ----------------------------------------------------------"
    printf "  %-25s %s\n" 'site:example.com' "Cari hanya di domain tertentu"
    printf "  %-25s %s\n" 'intitle:"kata"' "Cari di judul halaman"
    printf "  %-25s %s\n" 'inurl:kata' "Cari di URL"
    printf "  %-25s %s\n" 'intext:kata' "Cari dalam konten halaman"
    printf "  %-25s %s\n" 'filetype:pdf' "Cari tipe file tertentu"
    printf "  %-25s %s\n" 'cache:example.com' "Lihat cached version"
    printf "  %-25s %s\n" '"kata exact"' "Cari frasa persis"
    printf "  %-25s %s\n" '-kata' "Exclude kata dari hasil"
    printf "  %-25s %s\n" 'OR' "Salah satu dari dua kata"
    printf "  %-25s %s\n" 'related:example.com' "Cari situs yang mirip"
    echo ""
    echo -e "${WHITE}GOOGLE DORK UNTUK SECURITY RESEARCH:${RESET}"
    echo ""
    echo -e "  ${CYAN}Temukan halaman admin:${RESET}"
    echo '  intitle:"admin" site:target.com'
    echo '  inurl:admin OR inurl:administrator site:target.com'
    echo ""
    echo -e "  ${CYAN}Temukan file konfigurasi:${RESET}"
    echo '  filetype:env site:target.com'
    echo '  filetype:cfg site:target.com'
    echo '  filetype:ini site:target.com'
    echo '  intitle:"index of" ".env"'
    echo ""
    echo -e "  ${CYAN}Temukan database dumps:${RESET}"
    echo '  filetype:sql site:target.com'
    echo '  intitle:"index of" filetype:sql'
    echo ""
    echo -e "  ${CYAN}Temukan password files:${RESET}"
    echo '  intitle:"index of" "password.txt"'
    echo '  filetype:txt intext:"password"'
    echo ""
    echo -e "  ${CYAN}Temukan login pages:${RESET}"
    echo '  inurl:login site:target.com'
    echo '  intitle:"login" site:target.com'
    echo ""
    echo -e "  ${CYAN}Temukan exposed cameras:${RESET}"
    echo '  intitle:"IP Camera" inurl:"/view.shtml"'
    echo '  inurl:"/live/ch00_0" OR inurl:"/axis-cgi/mjpg"'
    echo ""
    echo -e "  ${CYAN}Temukan WordPress vulnerabilities:${RESET}"
    echo '  site:target.com inurl:wp-content'
    echo '  site:target.com inurl:wp-admin'
    echo ""
    echo -e "  ${CYAN}Temukan backup files:${RESET}"
    echo '  site:target.com filetype:bak'
    echo '  site:target.com filetype:backup'
    echo '  intitle:"index of" "backup"'
    echo ""
    echo -e "${RED}PENTING: Gunakan hanya untuk target yang Anda punya izin!${RESET}"
    echo "Google Dorking pada sistem tanpa izin bisa melanggar hukum."
    echo ""
    echo -e "${WHITE}REFERENSI:${RESET}"
    echo "  Google Hacking Database (GHDB): exploit-db.com/google-hacking-database"
    pause_modul
}

belajar_whois() {
    clear
    echo -e "${YELLOW}=== WHOIS LOOKUP ===${RESET}"
    echo ""
    echo "WHOIS adalah database publik yang berisi informasi tentang"
    echo "pemilik domain, registrar, dan tanggal registrasi."
    echo ""
    echo -e "${WHITE}INFORMASI DALAM WHOIS:${RESET}"
    echo ""
    echo "  Domain Name          : Nama domain"
    echo "  Registrar            : Perusahaan yang menjual domain"
    echo "  Creation Date        : Tanggal domain dibuat"
    echo "  Updated Date         : Terakhir diupdate"
    echo "  Expiry Date          : Kapan domain kedaluwarsa"
    echo "  Registrant Name      : Nama pemilik domain"
    echo "  Registrant Email     : Email pemilik"
    echo "  Registrant Phone     : Telepon pemilik"
    echo "  Registrant Address   : Alamat pemilik"
    echo "  Name Servers         : DNS server"
    echo "  Status               : Status domain"
    echo ""
    echo -e "${WHITE}CONTOH OUTPUT WHOIS (simulasi):${RESET}"
    echo ""
    echo "  Domain Name: EXAMPLE.COM"
    echo "  Registry Domain ID: 2336799_DOMAIN_COM-VRSN"
    echo "  Registrar: IANA"
    echo "  Registrar WHOIS Server: whois.iana.org"
    echo "  Creation Date: 1995-08-14T04:00:00Z"
    echo "  Registry Expiry Date: 2024-08-13T04:00:00Z"
    echo "  Registrant Organization: Internet Assigned Numbers Authority"
    echo "  Registrant State/Province: CA"
    echo "  Registrant Country: US"
    echo "  Name Server: A.IANA-SERVERS.NET"
    echo "  Name Server: B.IANA-SERVERS.NET"
    echo ""
    echo -e "${WHITE}CARA MEMBACA WHOIS UNTUK RECON:${RESET}"
    echo ""
    echo "  1. Email registrant -> target social engineering"
    echo "  2. Name servers -> bisa ada lebih banyak subdomain di sana"
    echo "  3. Tanggal expiry -> domain kedaluwarsa bisa di-squat"
    echo "  4. Registrar -> kadang ada celah di panel registrar"
    echo "  5. IP range -> cek apakah ada IP lain yang dimiliki target"
    echo ""
    echo -e "${WHITE}PRIVACY PROTECTION:${RESET}"
    echo "Banyak domain sekarang menggunakan WHOIS Privacy/Domain Privacy"
    echo "yang menyembunyikan informasi pemilik asli."
    echo ""
    echo -e "${WHITE}TOOLS WHOIS:${RESET}"
    echo "  Command line: whois domain.com"
    echo "  Online: who.is, whois.domaintools.com"
    echo "  Historical: DomainTools (berbayar)"
    pause_modul
}

belajar_dns_enum() {
    clear
    echo -e "${YELLOW}=== DNS ENUMERATION ===${RESET}"
    echo ""
    echo "DNS Enumeration adalah proses mencari semua record DNS dari target"
    echo "untuk memahami infrastruktur mereka."
    echo ""
    echo -e "${WHITE}TEKNIK DNS ENUMERATION:${RESET}"
    echo ""
    echo -e "  ${CYAN}1. Zone Transfer (AXFR)${RESET}"
    echo "  Mencoba mendapatkan salinan lengkap DNS zone"
    echo "  Jika berhasil = semua record DNS terungkap"
    echo "  Seharusnya hanya diizinkan ke trusted DNS server"
    echo "  Command: dig axfr @nameserver domain.com"
    echo ""
    echo -e "  ${CYAN}2. Brute Force Subdomain${RESET}"
    echo "  Mencoba semua kemungkinan subdomain dari wordlist"
    echo "  Contoh: www, mail, vpn, dev, staging, api, admin"
    echo "  Tools: Sublist3r, Amass, Gobuster (dns mode)"
    echo ""
    echo -e "  ${CYAN}3. Certificate Transparency Logs${RESET}"
    echo "  Setiap SSL cert yang diterbitkan masuk ke log publik"
    echo "  Mengungkap semua subdomain yang punya SSL cert"
    echo "  Situs: crt.sh, censys.io"
    echo ""
    echo -e "  ${CYAN}4. Passive DNS${RESET}"
    echo "  Database historis DNS resolution"
    echo "  Situs: SecurityTrails, DNSdumpster"
    echo ""
    echo -e "${WHITE}RECORD DNS YANG DICARI:${RESET}"
    echo ""
    echo "  A records    : Semua IP yang terhubung ke domain"
    echo "  MX records   : Mail server (target phishing/SMTP)"
    echo "  NS records   : Name server (potensial zone transfer)"
    echo "  TXT records  : SPF, DKIM, verifikasi, info kebocoran"
    echo "  CNAME        : Subdomain yang menggunakan layanan pihak ketiga"
    echo "  SRV          : Layanan seperti SIP, XMPP"
    echo ""
    echo -e "${WHITE}CONTOH SUBDOMAIN YANG SERING DITEMUKAN:${RESET}"
    echo ""
    echo "  www, mail, webmail, smtp, pop, imap"
    echo "  vpn, remote, citrix, sslvpn"
    echo "  dev, staging, test, qa, uat, demo"
    echo "  admin, portal, intranet, extranet"
    echo "  api, api2, v1, v2, v3"
    echo "  cdn, static, assets, media"
    echo "  ftp, sftp, backup"
    echo "  jira, confluence, gitlab, jenkins, sonar"
    echo ""
    echo -e "${WHITE}CONTOH TEMUAN BERBAHAYA:${RESET}"
    echo ""
    echo "  dev.company.com -> environment development yang tidak secure"
    echo "  staging.company.com -> environment staging dengan data real"
    echo "  jenkins.company.com -> CI/CD terbuka tanpa auth"
    echo "  old.company.com -> aplikasi lawas yang tidak di-update"
    pause_modul
}

belajar_email_harvest() {
    clear
    echo -e "${YELLOW}=== EMAIL HARVESTING ===${RESET}"
    echo ""
    echo "Email Harvesting adalah teknik mengumpulkan alamat email"
    echo "yang terkait dengan organisasi target."
    echo ""
    echo -e "${WHITE}MENGAPA EMAIL PENTING?${RESET}"
    echo ""
    echo "  - Target utama phishing dan spear phishing"
    echo "  - Bisa digunakan untuk credential stuffing"
    echo "  - Mengungkap format email organisasi"
    echo "  - Mengidentifikasi karyawan dan jabatan"
    echo ""
    echo -e "${WHITE}SUMBER EMAIL HARVESTING:${RESET}"
    echo ""
    echo -e "  ${CYAN}Search Engines:${RESET}"
    echo '  Google: "@company.com" site:linkedin.com'
    echo '  Google: site:company.com filetype:pdf email'
    echo ""
    echo -e "  ${CYAN}LinkedIn:${RESET}"
    echo "  Profil karyawan sering menampilkan email"
    echo "  Sales Navigator untuk data lebih lengkap"
    echo ""
    echo -e "  ${CYAN}theHarvester Tool:${RESET}"
    echo "  theHarvester -d company.com -b google,bing,linkedin"
    echo ""
    echo -e "  ${CYAN}Hunter.io:${RESET}"
    echo "  Database email profesional"
    echo "  Menunjukkan format email yang digunakan"
    echo ""
    echo -e "${WHITE}FORMAT EMAIL UMUM:${RESET}"
    echo ""
    echo "  firstname@company.com"
    echo "  firstname.lastname@company.com"
    echo "  f.lastname@company.com"
    echo "  flastname@company.com"
    echo "  lastname@company.com"
    echo ""
    echo "  Setelah tahu formatnya, bisa prediksi email karyawan lain!"
    echo ""
    echo -e "${WHITE}VERIFIKASI EMAIL:${RESET}"
    echo ""
    echo "  Email Verifier tools:"
    echo "  - verify-email.org"
    echo "  - hunter.io email verifier"
    echo ""
    echo "  Cara manual via SMTP:"
    echo '  telnet mail.company.com 25'
    echo '  EHLO test.com'
    echo '  VRFY user@company.com'
    echo "  (Banyak server disable VRFY untuk alasan keamanan)"
    echo ""
    echo -e "${WHITE}MITIGASI:${RESET}"
    echo ""
    echo "  - Jangan tampilkan email format yang konsisten"
    echo "  - Gunakan contact form daripada langsung tampilkan email"
    echo "  - Implement SPF, DKIM, DMARC untuk cegah email spoofing"
    echo "  - Security awareness training untuk phishing"
    pause_modul
}

belajar_social_osint() {
    clear
    echo -e "${YELLOW}=== SOCIAL MEDIA OSINT ===${RESET}"
    echo ""
    echo "Social media menyimpan banyak informasi berharga yang bisa"
    echo "digunakan dalam reconnaissance."
    echo ""
    echo -e "${WHITE}LINKEDIN OSINT:${RESET}"
    echo ""
    echo "  Informasi yang bisa didapat:"
    echo "  - Nama karyawan dan jabatan"
    echo "  - Koneksi antar karyawan"
    echo "  - Teknologi yang disebutkan dalam profil/pekerjaan"
    echo "  - Email dan nomor telepon (kadang terlihat)"
    echo "  - Proyek dan pengalaman kerja"
    echo ""
    echo "  Cara akses:"
    echo "  - Buat profil palsu (fake persona)"
    echo "  - Gunakan LinkedIn Sales Navigator"
    echo "  - Scraping dengan tools"
    echo ""
    echo -e "${WHITE}GITHUB OSINT:${RESET}"
    echo ""
    echo "  Apa yang bisa bocor di GitHub:"
    echo "  - API Keys (AWS, Google, Stripe)"
    echo "  - Database credentials"
    echo "  - Password hardcoded"
    echo "  - Internal IP addresses"
    echo "  - Email developer"
    echo "  - Struktur internal aplikasi"
    echo ""
    echo "  Search di GitHub:"
    echo '  "company.com" password'
    echo '  "company.com" api_key'
    echo '  "company.com" secret'
    echo '  filename:.env company.com'
    echo ""
    echo -e "${WHITE}TWITTER/X OSINT:${RESET}"
    echo ""
    echo "  - Karyawan sering posting tentang masalah teknis"
    echo "  - Mengungkap teknologi yang digunakan"
    echo "  - Jadwal maintenance"
    echo "  - Nama sistem internal"
    echo ""
    echo -e "${WHITE}INSTAGRAM/FACEBOOK OSINT:${RESET}"
    echo ""
    echo "  - Foto kantor mengungkap tata letak fisik"
    echo "  - Name badge terlihat dalam foto"
    echo "  - Jadwal kunjungan client"
    echo "  - Screen foto dengan informasi sensitif"
    echo ""
    echo -e "${WHITE}TOOLS OSINT:${RESET}"
    echo ""
    echo "  Maltego          : Platform OSINT visual"
    echo "  SpiderFoot       : Automated OSINT scanning"
    echo "  Sherlock         : Cari username di semua platform"
    echo "  Recon-ng         : Framework OSINT modular"
    echo "  theHarvester     : Email dan subdomain harvesting"
    echo "  OSRFramework     : OSINT untuk identitas digital"
    echo ""
    echo -e "${WHITE}CARA MELINDUNGI DIRI (Defensive):${RESET}"
    echo ""
    echo "  - Audit informasi yang ada tentang Anda secara online"
    echo "  - Batasi informasi di profil social media"
    echo "  - Jangan posting foto yang mengungkap info sensitif"
    echo "  - Bedakan profil personal dan profesional"
    echo "  - Gunakan privacy settings"
    pause_modul
}

simulasi_osint() {
    clear
    echo -e "${YELLOW}=== SIMULASI OSINT INVESTIGATION ===${RESET}"
    echo ""
    echo "Kita akan melakukan simulasi OSINT pada target fiktif:"
    echo -e "${WHITE}Target: fiksicompany.id (PERUSAHAAN FIKTIF)${RESET}"
    echo ""
    echo -e "${DIM}[SIMULASI] Mengumpulkan informasi OSINT...${RESET}"
    sleep 1
    echo ""
    echo -e "${CYAN}STEP 1: WHOIS Lookup${RESET}"
    echo "  Domain     : fiksicompany.id"
    echo "  Registrar  : ID WebHost Pte. Ltd."
    echo "  Created    : 2019-03-15"
    echo "  Expires    : 2025-03-15"
    echo "  Registrant : PT Fiksi Company Indonesia"
    echo "  Email      : admin@fiksicompany.id"
    echo "  Phone      : +62-21-1234567"
    echo "  Address    : Jl. Sudirman No. 123, Jakarta"
    echo "  Name Server: ns1.idwebhost.com, ns2.idwebhost.com"
    sleep 1
    echo ""
    echo -e "${CYAN}STEP 2: DNS Enumeration${RESET}"
    echo "  A Record   : fiksicompany.id -> 103.45.67.89"
    echo "  MX Record  : mail.fiksicompany.id -> 103.45.67.90"
    echo "  Subdomain  : www -> 103.45.67.89"
    echo "  Subdomain  : mail -> 103.45.67.90"
    echo "  Subdomain  : dev -> 103.45.67.100 [INTERESTING!]"
    echo "  Subdomain  : vpn -> 103.45.67.101"
    echo "  Subdomain  : jenkins -> 103.45.67.102 [INTERESTING!]"
    echo "  TXT Record : v=spf1 include:_spf.google.com ~all"
    sleep 1
    echo ""
    echo -e "${CYAN}STEP 3: Shodan Lookup${RESET}"
    echo "  IP: 103.45.67.89"
    echo "  Open Ports : 22, 80, 443, 8080"
    echo "  Server     : nginx/1.14.0 (Ubuntu)"
    echo "  SSL Cert   : Issued for: www.fiksicompany.id, dev.fiksicompany.id"
    echo "  Country    : Indonesia"
    sleep 1
    echo ""
    echo -e "${CYAN}STEP 4: LinkedIn Search${RESET}"
    echo "  Karyawan ditemukan: 47 orang"
    echo "  CTO          : Budi Santoso - menggunakan AWS, Docker, Kubernetes"
    echo "  Lead Dev     : Sari Dewi - Python, Django, PostgreSQL"
    echo "  IT Security  : Andi Rahman - Cisco, Fortinet"
    echo "  Format email : firstname.lastname@fiksicompany.id"
    sleep 1
    echo ""
    echo -e "${CYAN}STEP 5: GitHub Search${RESET}"
    echo "  Repo ditemukan: github.com/fiksicompany/webapp"
    echo -e "  ${RED}TEMUAN KRITIS: Dalam commit lama ditemukan:${RESET}"
    echo "  DB_PASSWORD=Fiks1P@ss2023"
    echo "  AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE"
    echo "  SMTP_PASS=mailpass123"
    sleep 1
    echo ""
    echo -e "${YELLOW}=== SUMMARY OSINT FINDINGS ===${RESET}"
    echo ""
    echo -e "  ${RED}HIGH RISK:${RESET}"
    echo "  - Credentials terekspos di GitHub"
    echo "  - Subdomain dev dan jenkins terekspos"
    echo "  - nginx 1.14.0 (outdated, banyak CVE)"
    echo ""
    echo -e "  ${YELLOW}MEDIUM RISK:${RESET}"
    echo "  - Format email diketahui -> risiko spear phishing"
    echo "  - Teknologi stack terekspos (Django, PostgreSQL)"
    echo ""
    echo -e "  ${GREEN}INFO BERGUNA:${RESET}"
    echo "  - Email admin: admin@fiksicompany.id"
    echo "  - IP range: 103.45.67.0/24"
    echo "  - VPN server: 103.45.67.101"
    echo ""
    echo -e "${WHITE}REKOMENDASI:${RESET}"
    echo "  1. Segera revoke semua credentials yang bocor di GitHub"
    echo "  2. Block akses publik ke jenkins.fiksicompany.id"
    echo "  3. Update nginx ke versi terbaru"
    echo "  4. Implementasikan security awareness training"
    pause_modul
}

lab_whois_dns() {
    clear
    echo -e "${YELLOW}=== LAB: WHOIS DAN DNS LOOKUP ===${RESET}"
    echo ""
    echo "Masukkan domain yang ingin kamu analisis"
    echo -e "${DIM}(Contoh: google.com, example.com)${RESET}"
    echo -ne "Domain: "
    read -r target_domain

    if [ -z "$target_domain" ]; then
        target_domain="example.com"
        echo "Menggunakan domain default: $target_domain"
    fi

    echo ""
    echo -e "${WHITE}=== WHOIS LOOKUP: $target_domain ===${RESET}"
    if command -v whois &>/dev/null; then
        timeout 10 whois "$target_domain" 2>/dev/null | head -40
    else
        echo "whois tidak terinstall. Install: pkg install whois"
    fi

    echo ""
    echo -e "${WHITE}=== DNS RECORDS: $target_domain ===${RESET}"
    if command -v dig &>/dev/null; then
        echo "--- A Records ---"
        timeout 5 dig A "$target_domain" +short 2>/dev/null
        echo "--- MX Records ---"
        timeout 5 dig MX "$target_domain" +short 2>/dev/null
        echo "--- NS Records ---"
        timeout 5 dig NS "$target_domain" +short 2>/dev/null
        echo "--- TXT Records ---"
        timeout 5 dig TXT "$target_domain" +short 2>/dev/null
    elif command -v nslookup &>/dev/null; then
        echo "--- nslookup ---"
        timeout 5 nslookup "$target_domain" 2>/dev/null
    else
        echo "dig/nslookup tidak terinstall. Install: pkg install dnsutils"
    fi

    echo ""
    echo -e "${WHITE}=== ZONE TRANSFER TEST (harusnya GAGAL): ===${RESET}"
    if command -v dig &>/dev/null; then
        ns=$(timeout 5 dig NS "$target_domain" +short 2>/dev/null | head -1)
        if [ -n "$ns" ]; then
            echo "Mencoba zone transfer dari $ns..."
            timeout 5 dig axfr "@$ns" "$target_domain" 2>/dev/null | head -20
            echo "(Jika gagal = server dikonfigurasi dengan benar)"
        fi
    fi
    pause_modul
}

# Jalankan menu utama modul
menu_recon
