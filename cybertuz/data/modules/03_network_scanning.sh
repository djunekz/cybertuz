#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; WHITE='\033[1;37m'; DIM='\033[2m'; RESET='\033[0m'

CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -z "$CYBERTUZ_LANG" ]; then
    source "$CYBERTUZ_DIR/lang.sh"
    ct_load_lang || _ct_set_lang "en"
fi

pause_modul() { echo ""; echo -ne "${DIM}  $CT_ENTER${RESET}"; read -r; }

menu_recon() {
    while true; do
        clear
        echo -e "${RED}=== $CT_MOD_HDR_3 ===${RESET}"
        echo ""
        echo -e "  ${GREEN}[1]${RESET}  $CT_M3_1"
        echo -e "  ${GREEN}[2]${RESET}  $CT_M3_2"
        echo -e "  ${GREEN}[3]${RESET}  $CT_M3_3"
        echo -e "  ${GREEN}[4]${RESET}  $CT_M3_4"
        echo -e "  ${GREEN}[5]${RESET}  $CT_M3_5"
        echo -e "  ${GREEN}[6]${RESET}  $CT_M3_6"
        echo -e "  ${GREEN}[7]${RESET}  $CT_M3_7"
        echo -e "  ${GREEN}[8]${RESET}  $CT_M3_8"
        echo -e "  ${GREEN}[9]${RESET}  $CT_M3_9"
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
    echo -e "${YELLOW}=== $CT_C_M3_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_INTRO"
    echo ""
    echo -e "${WHITE}$CT_C_M3_WHY${RESET}"
    echo ""
    echo "  $CT_C_M3_WHY1"
    echo "  $CT_C_M3_WHY2"
    echo "  $CT_C_M3_WHY3"
    echo "  $CT_C_M3_WHY4"
    echo "  $CT_C_M3_WHY5"
    echo ""
    echo -e "${WHITE}$CT_C_M3_TYPES${RESET}"
    echo ""
    echo -e "  ${GREEN}$CT_C_M3_PASSIVE${RESET}"
    echo "  $CT_C_M3_PASSIVE_DESC"
    echo "  $CT_C_M3_PASSIVE_EX"
    echo ""
    echo -e "  ${RED}$CT_C_M3_ACTIVE${RESET}"
    echo "  $CT_C_M3_ACTIVE_DESC"
    echo "  $CT_C_M3_ACTIVE_EX"
    echo ""
    echo -e "${WHITE}$CT_C_M3_INFO_SOUGHT${RESET}"
    echo ""
    echo "  $CT_C_M3_ORG_INFO"
    echo "  $CT_C_M3_ORG1"
    echo "  $CT_C_M3_ORG2"
    echo "  $CT_C_M3_ORG3"
    echo "  $CT_C_M3_ORG4"
    echo "  $CT_C_M3_ORG5"
    echo ""
    echo "  $CT_C_M3_TECH_INFO"
    echo "  $CT_C_M3_TECH1"
    echo "  $CT_C_M3_TECH2"
    echo "  $CT_C_M3_TECH3"
    echo "  $CT_C_M3_TECH4"
    echo "  $CT_C_M3_TECH5"
    echo ""
    echo -e "${WHITE}$CT_C_M3_TOOLS${RESET}"
    echo ""
    echo "  $CT_C_M3_TOOLS_PASS"
    echo "  $CT_C_M3_TOOLS_ACT"
    echo "  $CT_C_M3_TOOLS_DNS"
    echo "  $CT_C_M3_TOOLS_WEB"
    pause_modul
}

belajar_passive_recon() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_OSINT_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_OSINT_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_OSINT_SRC${RESET}"
    echo ""
    echo -e "  ${CYAN}Search Engines:${RESET}  $CT_C_M3_SRC_SE"
    echo ""
    echo -e "  ${CYAN}WHOIS Databases:${RESET}  $CT_C_M3_SRC_WHOIS"
    echo ""
    echo -e "  ${CYAN}DNS Records:${RESET}  $CT_C_M3_SRC_DNS"
    echo ""
    echo -e "  ${CYAN}Social Media:${RESET}  $CT_C_M3_SRC_SOCIAL"
    echo ""
    echo -e "  ${CYAN}Specialized Databases:${RESET}  $CT_C_M3_SRC_SPEC"
    echo ""
    echo -e "  ${CYAN}Job Postings:${RESET}  $CT_C_M3_SRC_JOBS"
    echo ""
    echo -e "${WHITE}$CT_C_M3_OSINT_EX${RESET}"
    echo ""
    echo "  domain: example.com"
    echo "  Whois      -> Registrant: john@example.com"
    echo "  DNS        -> Subdomain: mail, vpn, dev, staging"
    echo "  LinkedIn   -> 150 employees, CTO: Jane Smith"
    echo "  GitHub     -> Old commit with API key!"
    echo "  Shodan     -> Port 8080 open, Apache 2.4.1 (outdated)"
    echo "  WayBack    -> Old /backup.zip file existed"
    pause_modul
}

belajar_google_dork() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_DORK_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_DORK_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_DORK_OPS${RESET}"
    echo ""
    printf "  %-25s %s\n" "OPERATOR" "$CT_C_M3_DORK_FUNC"
    echo "  ----------------------------------------------------------"
    printf "  %-25s %s\n" "site:example.com"     "$CT_C_M3_DORK_SITE"
    printf "  %-25s %s\n" 'intitle:"keyword"'    "$CT_C_M3_DORK_TITLE2"
    printf "  %-25s %s\n" "inurl:keyword"         "$CT_C_M3_DORK_URL"
    printf "  %-25s %s\n" "intext:keyword"        "$CT_C_M3_DORK_TEXT"
    printf "  %-25s %s\n" "filetype:pdf"          "$CT_C_M3_DORK_FILE"
    printf "  %-25s %s\n" "cache:example.com"    "$CT_C_M3_DORK_CACHE"
    printf "  %-25s %s\n" '"exact phrase"'        "$CT_C_M3_DORK_EXACT"
    printf "  %-25s %s\n" "-keyword"              "$CT_C_M3_DORK_EXCL"
    printf "  %-25s %s\n" "OR"                    "$CT_C_M3_DORK_OR"
    printf "  %-25s %s\n" "related:example.com"  "$CT_C_M3_DORK_REL"
    echo ""
    echo -e "${WHITE}$CT_C_M3_DORK_SEC${RESET}"
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_ADMIN${RESET}"
    echo '  intitle:"admin" site:target.com'
    echo '  inurl:admin OR inurl:administrator site:target.com'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_CFG${RESET}"
    echo '  filetype:env site:target.com'
    echo '  filetype:cfg OR filetype:ini site:target.com'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_SQL${RESET}"
    echo '  filetype:sql site:target.com'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_PWD${RESET}"
    echo '  intitle:"index of" "password.txt"'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_LOGIN${RESET}"
    echo '  inurl:login site:target.com'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_CAM${RESET}"
    echo '  intitle:"IP Camera" inurl:"/view.shtml"'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_WP${RESET}"
    echo '  site:target.com inurl:wp-admin'
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DORK_BAK${RESET}"
    echo '  site:target.com filetype:bak OR filetype:backup'
    echo ""
    echo -e "${RED}$CT_C_M3_DORK_WARN${RESET}"
    echo ""
    echo "$CT_C_M3_DORK_REF"
    pause_modul
}

belajar_whois() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_WHOIS_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_WHOIS_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_WHOIS_INFO${RESET}"
    echo ""
    echo "  Domain Name | Registrar | Creation Date | Updated Date"
    echo "  Expiry Date | Registrant Name | Registrant Email"
    echo "  Registrant Phone | Registrant Address | Name Servers | Status"
    echo ""
    echo -e "${WHITE}$CT_C_M3_WHOIS_EX${RESET}"
    echo ""
    echo "  Domain Name: EXAMPLE.COM"
    echo "  Registrar: IANA"
    echo "  Creation Date: 1995-08-14T04:00:00Z"
    echo "  Registry Expiry Date: 2025-08-13T04:00:00Z"
    echo "  Registrant Organization: Internet Assigned Numbers Authority"
    echo "  Registrant Country: US"
    echo "  Name Server: A.IANA-SERVERS.NET"
    echo "  Name Server: B.IANA-SERVERS.NET"
    echo ""
    echo -e "${WHITE}$CT_C_M3_WHOIS_READ${RESET}"
    echo ""
    echo "  $CT_C_M3_WHOIS_R1"
    echo "  $CT_C_M3_WHOIS_R2"
    echo "  $CT_C_M3_WHOIS_R3"
    echo "  $CT_C_M3_WHOIS_R4"
    echo "  $CT_C_M3_WHOIS_R5"
    echo ""
    echo "$CT_C_M3_WHOIS_PRIV"
    echo ""
    echo "$CT_C_M3_WHOIS_TOOLS"
    pause_modul
}

belajar_dns_enum() {
    clear
    echo -e "${YELLOW}=== DNS ENUMERATION ===${RESET}"
    echo ""
    echo "$CT_C_M3_DNS_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_DNS_TECH${RESET}"
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DNS_T1${RESET}"
    echo "  Command: dig axfr @nameserver domain.com"
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DNS_T2${RESET}"
    echo "  Tools: Sublist3r, Amass, Gobuster (dns mode)"
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DNS_T3${RESET}"
    echo ""
    echo -e "  ${CYAN}$CT_C_M3_DNS_T4${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_M3_DNS_RECORDS${RESET}"
    echo ""
    echo "  $CT_C_M3_DNS_R1"
    echo "  $CT_C_M3_DNS_R2"
    echo "  $CT_C_M3_DNS_R3"
    echo "  $CT_C_M3_DNS_R4"
    echo "  $CT_C_M3_DNS_R5"
    echo "  $CT_C_M3_DNS_R6"
    echo ""
    echo -e "${WHITE}$CT_C_M3_DNS_COMMON${RESET}"
    echo ""
    echo "  www, mail, webmail, smtp, pop, imap"
    echo "  vpn, remote, citrix, sslvpn"
    echo "  dev, staging, test, qa, uat, demo"
    echo "  admin, portal, intranet, extranet"
    echo "  api, api2, v1, v2, v3"
    echo "  cdn, static, assets, ftp, sftp, backup"
    echo "  jira, confluence, gitlab, jenkins, sonar"
    echo ""
    echo -e "${RED}$CT_C_M3_DNS_DANGER${RESET}"
    echo ""
    echo "  $CT_C_M3_DNS_D1"
    echo "  $CT_C_M3_DNS_D2"
    echo "  $CT_C_M3_DNS_D3"
    echo "  $CT_C_M3_DNS_D4"
    pause_modul
}

belajar_email_harvest() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_EMAIL_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_EMAIL_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_EMAIL_WHY${RESET}"
    echo ""
    echo "  $CT_C_M3_EMAIL_W1"
    echo "  $CT_C_M3_EMAIL_W2"
    echo "  $CT_C_M3_EMAIL_W3"
    echo "  $CT_C_M3_EMAIL_W4"
    echo ""
    echo -e "${WHITE}$CT_C_M3_EMAIL_SRC${RESET}"
    echo ""
    echo -e "  ${CYAN}Search Engines:${RESET}"
    echo '  "@company.com" site:linkedin.com'
    echo '  site:company.com filetype:pdf email'
    echo ""
    echo -e "  ${CYAN}LinkedIn:${RESET}"
    echo "  theHarvester -d company.com -b google,bing,linkedin"
    echo "  hunter.io"
    echo ""
    echo -e "${WHITE}$CT_C_M3_EMAIL_FORMATS${RESET}"
    echo ""
    echo "  firstname@company.com"
    echo "  firstname.lastname@company.com"
    echo "  f.lastname@company.com"
    echo "  flastname@company.com"
    echo ""
    echo "  $CT_C_M3_EMAIL_FORMAT_TIP"
    echo ""
    echo -e "${WHITE}$CT_C_M3_EMAIL_MITIGATE${RESET}"
    echo ""
    echo "  $CT_C_M3_EMAIL_M1"
    echo "  $CT_C_M3_EMAIL_M2"
    echo "  $CT_C_M3_EMAIL_M3"
    echo "  $CT_C_M3_EMAIL_M4"
    pause_modul
}

belajar_social_osint() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_SOCIAL_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_SOCIAL_DEF"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_LI${RESET}"
    echo "  $CT_C_M3_SOCIAL_LI_INFO"
    echo "  $CT_C_M3_SOCIAL_LI_HOW"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_GH${RESET}"
    echo "  $CT_C_M3_SOCIAL_GH_LEAK"
    echo ""
    echo '  Search: "company.com" password OR api_key OR secret'
    echo '          filename:.env company.com'
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_TW${RESET}"
    echo "  $CT_C_M3_SOCIAL_TW_INFO"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_IG${RESET}"
    echo "  $CT_C_M3_SOCIAL_IG_INFO"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_TOOLS${RESET}"
    echo ""
    echo "  Maltego | SpiderFoot | Sherlock | Recon-ng | theHarvester | OSRFramework"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SOCIAL_DEFEND${RESET}"
    echo ""
    echo "  $CT_C_M3_SOCIAL_D1"
    echo "  $CT_C_M3_SOCIAL_D2"
    echo "  $CT_C_M3_SOCIAL_D3"
    echo "  $CT_C_M3_SOCIAL_D4"
    echo "  $CT_C_M3_SOCIAL_D5"
    pause_modul
}

simulasi_osint() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_SIM_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_SIM_INTRO"
    echo -e "${WHITE}$CT_C_M3_SIM_TARGET${RESET}"
    echo ""
    echo -e "${DIM}$CT_C_M3_SIM_GATHER${RESET}"
    sleep 1

    echo ""
    echo -e "${CYAN}$CT_C_M3_SIM_STEP1${RESET}"
    echo "  Domain     : fiksicompany.id"
    echo "  Registrar  : ID WebHost Pte. Ltd."
    echo "  Created    : 2019-03-15"
    echo "  Registrant : PT Fiksi Company Indonesia"
    echo "  Email      : admin@fiksicompany.id"
    echo "  NS         : ns1.idwebhost.com, ns2.idwebhost.com"
    sleep 1

    echo ""
    echo -e "${CYAN}$CT_C_M3_SIM_STEP2${RESET}"
    echo "  A    : fiksicompany.id -> 103.45.67.89"
    echo "  MX   : mail.fiksicompany.id -> 103.45.67.90"
    echo -e "  SUB  : dev.fiksicompany.id -> 103.45.67.100  ${RED}[!]${RESET}"
    echo -e "  SUB  : jenkins.fiksicompany.id               ${RED}[!]${RESET}"
    echo "  TXT  : v=spf1 include:_spf.google.com ~all"
    sleep 1

    echo ""
    echo -e "${CYAN}$CT_C_M3_SIM_STEP3${RESET}"
    echo "  IP: 103.45.67.89"
    echo "  Open Ports : 22, 80, 443, 8080"
    echo "  Server     : nginx/1.14.0 (Ubuntu)"
    sleep 1

    echo ""
    echo -e "${CYAN}$CT_C_M3_SIM_STEP4${RESET}"
    echo "  CTO    : Budi Santoso - AWS, Docker, Kubernetes"
    echo "  Dev    : Sari Dewi - Python, Django, PostgreSQL"
    echo "  Email format: firstname.lastname@fiksicompany.id"
    sleep 1

    echo ""
    echo -e "${CYAN}$CT_C_M3_SIM_STEP5${RESET}"
    echo -e "  ${RED}$CT_C_M3_SIM_CRIT${RESET}"
    echo "  DB_PASSWORD=Fiks1P@ss2023"
    echo "  AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE"
    sleep 1

    echo ""
    echo -e "${YELLOW}=== $CT_C_M3_SIM_SUMMARY ===${RESET}"
    echo ""
    echo -e "  ${RED}$CT_C_M3_SIM_HIGH${RESET}"
    echo "  $CT_C_M3_SIM_H1"
    echo "  $CT_C_M3_SIM_H2"
    echo "  $CT_C_M3_SIM_H3"
    echo ""
    echo -e "  ${YELLOW}$CT_C_M3_SIM_MED${RESET}"
    echo "  $CT_C_M3_SIM_M1"
    echo "  $CT_C_M3_SIM_M2"
    echo ""
    echo -e "  ${GREEN}$CT_C_M3_SIM_INFO${RESET}"
    echo "  admin@fiksicompany.id | IP: 103.45.67.0/24"
    echo ""
    echo -e "${WHITE}$CT_C_M3_SIM_REC${RESET}"
    echo "  $CT_C_M3_SIM_R1"
    echo "  $CT_C_M3_SIM_R2"
    echo "  $CT_C_M3_SIM_R3"
    echo "  $CT_C_M3_SIM_R4"
    pause_modul
}

lab_whois_dns() {
    clear
    echo -e "${YELLOW}=== $CT_C_M3_LAB_TITLE ===${RESET}"
    echo ""
    echo "$CT_C_M3_LAB_INTRO"
    echo -e "${DIM}$CT_C_M3_LAB_EX${RESET}"
    echo -ne "$CT_C_M3_LAB_DOM"
    read -r target_domain

    [ -z "$target_domain" ] && target_domain="example.com" && echo "$CT_C_M3_LAB_DEFAULT$target_domain"

    echo ""
    echo -e "${WHITE}=== $CT_C_M3_LAB_WHOIS: $target_domain ===${RESET}"
    if command -v whois &>/dev/null; then
        timeout 10 whois "$target_domain" 2>/dev/null | head -30
    else
        echo "  $CT_C_M3_LAB_NO_WHOIS"
    fi

    echo ""
    echo -e "${WHITE}=== $CT_C_M3_LAB_DNS: $target_domain ===${RESET}"
    if command -v dig &>/dev/null; then
        echo "$CT_C_M3_LAB_A";   timeout 5 dig A   "$target_domain" +short 2>/dev/null
        echo "$CT_C_M3_LAB_MX";  timeout 5 dig MX  "$target_domain" +short 2>/dev/null
        echo "$CT_C_M3_LAB_NS";  timeout 5 dig NS  "$target_domain" +short 2>/dev/null
        echo "$CT_C_M3_LAB_TXT"; timeout 5 dig TXT "$target_domain" +short 2>/dev/null
    elif command -v nslookup &>/dev/null; then
        timeout 5 nslookup "$target_domain" 2>/dev/null
    else
        echo "  $CT_C_M3_LAB_NO_DIG"
    fi

    echo ""
    echo -e "${WHITE}=== $CT_C_M3_LAB_ZONE ===${RESET}"
    if command -v dig &>/dev/null; then
        ns=$(timeout 5 dig NS "$target_domain" +short 2>/dev/null | head -1)
        if [ -n "$ns" ]; then
            echo "  $CT_C_M3_LAB_TRY_ZT$ns..."
            timeout 5 dig axfr "@$ns" "$target_domain" 2>/dev/null | head -10
            echo "  $CT_C_M3_LAB_ZT_OK"
        fi
    fi
    pause_modul
}

menu_recon
