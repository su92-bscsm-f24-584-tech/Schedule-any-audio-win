#!/bin/bash

clear

echo "============================================="
echo "        AUDIO CONFIGURATION UTILITY          "
echo "============================================="

shopt -s nullglob extglob
scan_audio() {

    FILES=( *.@(mp3|wav|m4a|wma|mp2|MP3|WAV|M4A|WMA|MP2) )
}

# Initial scan
scan_audio

# If no files found
if [ ${#FILES[@]} -eq 0 ]; then

    echo ""
    echo "[!] No supported audio files found in:"
    pwd

    echo ""
    read -p "Enter another folder path: " CUSTOM_PATH

    if [ ! -d "$CUSTOM_PATH" ]; then
        echo "[!] Invalid directory."
        exit 1
    fi

    cd "$CUSTOM_PATH" || exit 1

    scan_audio

    if [ ${#FILES[@]} -eq 0 ]; then
        echo "[!] Still no audio files found."
        exit 1
    fi
fi

echo ""
echo "Available Audio Files:"
echo "---------------------------------------------"

for i in "${!FILES[@]}"; do
    echo " [$((i+1))] ${FILES[$i]}"
done

echo "---------------------------------------------"

read -p "Select item number > " CHOICE

if [[ "$CHOICE" =~ ^[0-9]+$ ]] &&
   [ "$CHOICE" -gt 0 ] &&
   [ "$CHOICE" -le "${#FILES[@]}" ]; then

    SELECTED_FILE="${FILES[$((CHOICE-1))]}"

    echo "$PWD/$SELECTED_FILE" > selected.txt

    echo ""
    echo "[+] Selected:"
    echo "$SELECTED_FILE"

else
    echo "[!] Invalid selection."
    exit 1
fi

echo ""
echo "Enter alarm time (24hr format)"
read -p "HH:MM > " ALARM_TIME

if [[ "$ALARM_TIME" =~ ^([01][0-9]|2[0-3]):[0-5][0-9]$ ]]; then

    echo ""
    echo "[+] Creating scheduled task..."

    MSYS_NO_PATHCONV=1 /c/Windows/System32/schtasks.exe \
    /create \
    /tn "AudioCronTask" \
    /tr "\"C:\Program Files\Git\bin\bash.exe\" --login -i -c \"cd /c/Users/imato/drss && ./cron_player_win.sh\"" \
    /sc DAILY \
    /st "$ALARM_TIME" \
    /f

    echo ""
    echo "[+] Scheduled successfully."

else
    echo "[!] Invalid time format."
fi