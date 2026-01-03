#!/bin/bash

cyan="\e[96m"
green="\e[92m"
red="\e[91m"
nc="\e[0m"

BROWSER="firefox"

banner() {
    echo -e "${cyan}"
    echo "=============================="
    echo "      BLACK HAWKS OSINT"
    echo "      By ELIOTH MIKABOU "
    echo "      BLACK HAWK Edition"
    echo "=============================="
    echo -e "${nc}"
}

pause() {
    read -p "Appuyez sur Entrée pour continuer..."
}

open_window() {
    url="$1"
    $BROWSER --new-window "$url" >/dev/null 2>&1 &
    sleep 0.5
}

email_osint() {
    read -p "Entrez l'adresse email : " email

    echo -e "${green}[+] Ouverture HaveIBeenPwned...${nc}"
    open_window "https://haveibeenpwned.com/account/$email"

    echo -e "${green}[+] DuckDuckGo...${nc}"
    open_window "https://duckduckgo.com/?q=$email"

    echo -e "${green}[+] Google...${nc}"
    open_window "https://www.google.com/search?q=$email"

    pause
}

phone_osint() {
    read -p "Entrez le numéro (format international) : " num

    echo -e "${green}[+] Google Dork...${nc}"
    open_window "https://www.google.com/search?q=\"$num\""

    echo -e "${green}[+] Facebook...${nc}"
    open_window "https://www.facebook.com/search/top/?q=$num"

    echo -e "${green}[+] Truecaller (web)...${nc}"
    open_window "https://www.truecaller.com/search/$num"

    pause
}

imei_osint() {
    read -p "Entrez IMEI : " imei

    echo -e "${green}[+] imei24.com...${nc}"
    open_window "https://www.imei24.com/imei_check/$imei/"

    echo -e "${green}[+] imei.info...${nc}"
    open_window "https://www.imei.info/$imei/"

    echo -e "${green}[+] imeipro.info...${nc}"
    open_window "https://www.imeipro.info/check_imei/$imei/"

    pause
}

name_osint() {
    read -p "Nom : " nom
    read -p "Prénom : " prenom
    query="$nom+$prenom"

    echo -e "${green}[+] Google...${nc}"
    open_window "https://www.google.com/search?q=$query"

    echo -e "${green}[+] DuckDuckGo...${nc}"
    open_window "https://duckduckgo.com/?q=$query"

    echo -e "${green}[+] Facebook...${nc}"
    open_window "https://www.facebook.com/search/top/?q=$query"

    echo -e "${green}[+] LinkedIn...${nc}"
    open_window "https://www.linkedin.com/search/results/all/?keywords=$query"

    pause
}

menu() {
    while true; do
        clear
        banner
        echo -e "${green}[1] OSINT Email"
        echo "[2] OSINT Numéro"
        echo "[3] OSINT IMEI"
        echo "[4] OSINT Nom & Prénom"
        echo -e "[0] Quitter${nc}"
        read -p "Choix : " c

        case $c in
            1) email_osint ;;
            2) phone_osint ;;
            3) imei_osint ;;
            4) name_osint ;;
            0) exit 0 ;;
            *) echo -e "${red}Choix invalide${nc}" && sleep 1 ;;
        esac
    done
}

menu
