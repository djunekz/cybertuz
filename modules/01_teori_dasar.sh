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
    echo -e "${YELLOW}=== $CT_M1_1 ===${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_CS_DEF${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_WHY_IMPORTANT${RESET}"
    echo "- $CT_C_WHY_1"
    echo "- $CT_C_WHY_2"
    echo "- $CT_C_WHY_3"
    echo "- $CT_C_WHY_4"
    echo ""
    echo -e "${WHITE}$CT_C_SCOPE${RESET}"
    echo ""
    echo -e "  ${CYAN}1. $CT_C_SCOPE_NET${RESET}"
    echo "     $CT_C_SCOPE_NET_DESC"
    echo "     $CT_C_SCOPE_NET_EX"
    echo ""
    echo -e "  ${CYAN}2. $CT_C_SCOPE_APP${RESET}"
    echo "     $CT_C_SCOPE_APP_DESC"
    echo "     $CT_C_SCOPE_APP_EX"
    echo ""
    echo -e "  ${CYAN}3. $CT_C_SCOPE_INFO${RESET}"
    echo "     $CT_C_SCOPE_INFO_DESC"
    echo "     $CT_C_SCOPE_INFO_EX"
    echo ""
    echo -e "  ${CYAN}4. $CT_C_SCOPE_OPS${RESET}"
    echo "     $CT_C_SCOPE_OPS_DESC"
    echo "     $CT_C_SCOPE_OPS_EX"
    echo ""
    echo -e "  ${CYAN}5. $CT_C_SCOPE_DR${RESET}"
    echo "     $CT_C_SCOPE_DR_DESC"
    echo "     $CT_C_SCOPE_DR_EX"
    echo ""
    echo -e "  ${CYAN}6. $CT_C_SCOPE_EDU${RESET}"
    echo "     $CT_C_SCOPE_EDU_DESC"
    echo "     $CT_C_SCOPE_EDU_EX"
    echo ""
    echo -e "${WHITE}$CT_C_SEC_MODELS${RESET}"
    echo ""
    echo "  $CT_C_DEF_IN_DEPTH"
    echo "  $CT_C_ZERO_TRUST"
    echo "  $CT_C_LEAST_PRIV"
    echo "  $CT_C_NEED_KNOW"
    pause_modul
}

belajar_cia_triad() {
    clear
    echo -e "${YELLOW}=== CIA TRIAD ===${RESET}"
    echo ""
    echo "$CT_C_CIA_INTRO"
    echo ""
    echo -e "${RED}$CT_C_CONF_HDR${RESET}"
    echo "-------------------------------------"
    echo "$CT_C_CONF_DEF"
    echo ""
    echo "$CT_C_CONF_THREATS"
    echo "  - $CT_C_CONF_T1"
    echo "  - $CT_C_CONF_T2"
    echo "  - $CT_C_CONF_T3"
    echo "  - $CT_C_CONF_T4"
    echo ""
    echo "$CT_C_PROTECT"
    echo "  - Encryption (AES, RSA, TLS)"
    echo "  - Access control"
    echo "  - Data classification"
    echo "  - VPN"
    echo ""
    echo -e "${GREEN}$CT_C_INTEG_HDR${RESET}"
    echo "-------------------------------------"
    echo "$CT_C_INTEG_DEF"
    echo ""
    echo "$CT_C_INTEG_THREATS"
    echo "  - Man-in-the-Middle"
    echo "  - SQL Injection"
    echo "  - Malware"
    echo "  - Insider threat"
    echo ""
    echo "$CT_C_PROTECT"
    echo "  - Hash (MD5, SHA-256)"
    echo "  - Digital signature"
    echo "  - Checksum verification"
    echo ""
    echo -e "${CYAN}$CT_C_AVAIL_HDR${RESET}"
    echo "-------------------------------------"
    echo "$CT_C_AVAIL_DEF"
    echo ""
    echo "$CT_C_AVAIL_THREATS"
    echo "  - DDoS"
    echo "  - Ransomware"
    echo "  - Hardware failure"
    echo "  - Natural disaster"
    echo ""
    echo "$CT_C_PROTECT"
    echo "  - Redundancy & failover"
    echo "  - Regular backup"
    echo "  - DDoS protection"
    echo ""
    echo -e "${WHITE}$CT_C_CIA_EXAMPLE${RESET}"
    echo ""
    echo "  $CT_C_CIA_SCENARIO"
    echo "  - $CT_C_CIA_SC_CONF"
    echo "  - $CT_C_CIA_SC_INT"
    echo "  - $CT_C_CIA_SC_AVL"
    pause_modul
}

belajar_ancaman() {
    clear
    echo -e "${YELLOW}=== $CT_M1_3 ===${RESET}"
    echo ""
    echo -e "${RED}$CT_C_MALWARE${RESET}"
    echo "   $CT_C_MALWARE_DEF"
    echo ""
    echo "   Virus | Worm | Trojan | Ransomware | Spyware | Adware | Rootkit | Keylogger"
    echo ""
    echo -e "${RED}$CT_C_NETATTACK${RESET}"
    echo "   Man-in-the-Middle | DoS/DDoS | Packet Sniffing | ARP Poisoning"
    echo ""
    echo -e "${RED}$CT_C_WEBATTACK${RESET}"
    echo "   SQL Injection | XSS | CSRF | Directory Traversal | SSRF"
    echo ""
    echo -e "${RED}$CT_C_SE_ATT${RESET}"
    echo "   Phishing | Spear Phishing | Vishing | Smishing | Baiting | Pretexting"
    echo ""
    echo -e "${RED}$CT_C_INSIDER${RESET}"
    echo "   Malicious | Negligent | Compromised Insider"
    pause_modul
}

belajar_attack_surface() {
    clear
    echo -e "${YELLOW}=== $CT_M1_4 ===${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_ATKSRF_HDR${RESET}"
    echo "$CT_C_ATKSRF_DEF"
    echo ""
    echo "  Digital | Physical | Social Engineering Attack Surface"
    echo ""
    echo -e "${WHITE}$CT_C_ATKVEC_HDR${RESET}"
    echo "$CT_C_ATKVEC_DEF"
    echo ""
    echo "  Email | Web Browser | USB | Wireless | Supply Chain | Insider"
    echo ""
    echo -e "${WHITE}$CT_C_REDUCE_SURFACE${RESET}"
    echo ""
    echo "  1. Disable unnecessary services"
    echo "  2. Close unused ports"
    echo "  3. Implement least privilege"
    echo "  4. Regular patching & updates"
    echo "  5. Network segmentation"
    echo "  6. Input validation"
    echo "  7. Remove default credentials"
    echo ""
    echo -e "${WHITE}Attack Surface Visualization:${RESET}"
    echo ""
    echo "  Internet --> [Firewall] --> [DMZ] --> [Internal FW] --> [Internal Network] --> [Endpoint]"
    pause_modul
}

belajar_ethical_hacking() {
    clear
    echo -e "${YELLOW}=== $CT_M1_5 ===${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_ETHACK_DEF${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_HACKER_TYPES${RESET}"
    echo ""
    echo -e "  ${RED}$CT_C_BLACKHAT${RESET}"
    echo "  $CT_C_BLACKHAT_DESC"
    echo ""
    echo -e "  ${WHITE}$CT_C_WHITEHAT${RESET}"
    echo "  $CT_C_WHITEHAT_DESC"
    echo ""
    echo -e "  ${DIM}$CT_C_GREYHAT${RESET}"
    echo "  $CT_C_GREYHAT_DESC"
    echo ""
    echo -e "${WHITE}$CT_C_PENTEST_METHOD${RESET}"
    echo ""
    echo "  $CT_C_PHASE 1: Reconnaissance"
    echo "  $CT_C_PHASE 2: Scanning & Enumeration"
    echo "  $CT_C_PHASE 3: Gaining Access"
    echo "  $CT_C_PHASE 4: Maintaining Access"
    echo "  $CT_C_PHASE 5: Covering Tracks"
    echo "  $CT_C_PHASE 6: Reporting"
    echo ""
    echo "  Black Box | White Box | Grey Box"
    echo ""
    echo -e "${RED}$CT_C_LEGAL_WARN${RESET}"
    echo "  $CT_C_LEGAL_WARN_MSG"
    pause_modul
}

belajar_terminologi() {
    clear
    echo -e "${YELLOW}=== $CT_M1_6 ===${RESET}"
    echo ""
    echo -e "${WHITE}A - F${RESET}"
    echo "  APT | Authentication | Authorization | Backdoor | Botnet"
    echo "  Buffer Overflow | CVE | DLP | DMZ | Exploit"
    echo ""
    echo -e "${WHITE}G - N${RESET}"
    echo "  Honeypot | IDS | IPS | IOC | Lateral Movement | MFA | MITM"
    echo ""
    echo -e "${WHITE}O - Z${RESET}"
    echo "  OSINT | Payload | Pentest | Pivoting | Privilege Escalation"
    echo "  Rootkit | SIEM | SOC | Social Engineering | TTPs | Zero-day"
    pause_modul
}

belajar_hukum() {
    clear
    echo -e "${YELLOW}=== $CT_M1_7 ===${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_LAW_LOCAL${RESET}"
    echo ""
    echo "  UU ITE No. 11/2008 jo UU No. 19/2016"
    echo "  Pasal 30 | 31 | 32 | 33"
    echo ""
    echo "  CFAA (USA) | Computer Misuse Act (UK) | Budapest Convention | GDPR"
    echo ""
    echo -e "${WHITE}$CT_C_ETHICS_HDR${RESET}"
    echo ""
    echo "  1. Always get written permission"
    echo "  2. Respect privacy"
    echo "  3. Report all findings"
    echo "  4. Do not damage systems"
    echo "  5. Stay within agreed scope"
    echo "  6. Document all activities"
    echo ""
    echo -e "${RED}$CT_C_ETHICS_REMINDER${RESET}"
    pause_modul
}

belajar_karir() {
    clear
    echo -e "${YELLOW}=== $CT_M1_8 ===${RESET}"
    echo ""
    echo -e "${WHITE}$CT_C_CAREER_PATHS${RESET}"
    echo ""
    echo -e "  ${GREEN}Penetration Tester / Ethical Hacker${RESET} - CEH, OSCP, GPEN"
    echo -e "  ${GREEN}Security Analyst (SOC)${RESET}            - Security+, CySA+"
    echo -e "  ${GREEN}Malware Analyst / Reverse Engineer${RESET} - GREM, CREA"
    echo -e "  ${GREEN}Digital Forensic Investigator${RESET}      - GCFE, GCFA, EnCE"
    echo -e "  ${GREEN}Security Architect${RESET}                 - CISSP, SABSA"
    echo -e "  ${GREEN}Bug Bounty Hunter${RESET}                  - HackerOne, Bugcrowd"
    echo ""
    echo -e "${WHITE}$CT_C_ROADMAP${RESET}"
    echo ""
    echo "  1. Networking (TCP/IP, OSI)"
    echo "  2. Linux/Windows"
    echo "  3. Programming (Python, Bash)"
    echo "  4. Security concepts"
    echo "  5. Web tech (HTML, HTTP, SQL)"
    echo "  6. Tools (Nmap, Wireshark, Metasploit)"
    echo "  7. Practice (TryHackMe, HackTheBox)"
    echo "  8. Certification"
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
    echo "$CT_C_QUIZ_Q1"
    echo "$CT_C_QUIZ_Q1A"
    echo "$CT_C_QUIZ_Q1B"
    echo "$CT_C_QUIZ_Q1C"
    echo "$CT_C_QUIZ_Q1D"
    echo -ne "$CT_ANS: "
    read -r ans
    if [[ "$ans" == "b" || "$ans" == "B" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"; ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: $CT_C_QUIZ_A1${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 2:${RESET}"
    echo "$CT_C_QUIZ_Q2"
    echo "$CT_C_QUIZ_Q2A"; echo "$CT_C_QUIZ_Q2B"; echo "$CT_C_QUIZ_Q2C"; echo "$CT_C_QUIZ_Q2D"
    echo -ne "$CT_ANS: "; read -r ans
    if [[ "$ans" == "c" || "$ans" == "C" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"; ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: $CT_C_QUIZ_A2${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 3:${RESET}"
    echo "$CT_C_QUIZ_Q3"
    echo "$CT_C_QUIZ_Q3A"; echo "$CT_C_QUIZ_Q3B"; echo "$CT_C_QUIZ_Q3C"; echo "$CT_C_QUIZ_Q3D"
    echo -ne "$CT_ANS: "; read -r ans
    if [[ "$ans" == "d" || "$ans" == "D" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"; ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: $CT_C_QUIZ_A3${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 4:${RESET}"
    echo "$CT_C_QUIZ_Q4"
    echo "$CT_C_QUIZ_Q4A"; echo "$CT_C_QUIZ_Q4B"; echo "$CT_C_QUIZ_Q4C"; echo "$CT_C_QUIZ_Q4D"
    echo -ne "$CT_ANS: "; read -r ans
    if [[ "$ans" == "b" || "$ans" == "B" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"; ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: $CT_C_QUIZ_A4${RESET}"
    fi
    echo ""

    echo -e "${WHITE}$CT_Q 5:${RESET}"
    echo "$CT_C_QUIZ_Q5"
    echo "$CT_C_QUIZ_Q5A"; echo "$CT_C_QUIZ_Q5B"; echo "$CT_C_QUIZ_Q5C"; echo "$CT_C_QUIZ_Q5D"
    echo -ne "$CT_ANS: "; read -r ans
    if [[ "$ans" == "c" || "$ans" == "C" ]]; then
        echo -e "${GREEN}[$CT_CORRECT]${RESET}"; ((score++))
    else
        echo -e "${RED}[$CT_WRONG] $CT_ANS: $CT_C_QUIZ_A5${RESET}"
    fi
    echo ""

    echo -e "${YELLOW}=== $CT_RESULT ===${RESET}"
    echo -e "$CT_SCORE: ${WHITE}$score / $total${RESET}"
    if [ $score -eq 5 ]; then
        echo -e "${GREEN}[$CT_PASSED] $CT_C_PERFECT${RESET}"
    elif [ $score -ge 3 ]; then
        echo -e "${YELLOW}[$CT_ENOUGH]${RESET}"
    else
        echo -e "${RED}[$CT_NOT_PASSED]${RESET}"
    fi
    pause_modul
}

menu_dasar
