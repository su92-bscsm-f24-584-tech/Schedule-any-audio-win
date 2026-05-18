#!/bin/bash

shopt -s nullglob extglob

clear

echo "============================================="
echo "              AUDIO PLAYER MODE              "
echo "============================================="
echo ""

scan_audio() {
    FILES=( *.@(mp3|wav|m4a|wma|mp2|MP3|WAV|M4A|WMA|MP2) )
}

# Scan current directory
scan_audio

# If files found locally
if [ ${#FILES[@]} -gt 0 ]; then

    echo "Available Audio Files:"
    echo "---------------------------------------------"

    for i in "${!FILES[@]}"; do
        echo " [$((i+1))] ${FILES[$i]}"
    done

    echo "---------------------------------------------"

    read -p "Select item number > " CHOICE

    # Clean input
    CHOICE=$(echo "$CHOICE" | tr -d '\r' | xargs)

    # Validate numeric input
    if [[ "$CHOICE" =~ ^[0-9]+$ ]]; then

        # Validate range
        if [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le "${#FILES[@]}" ]; then

            TARGET_FILE="${FILES[$((CHOICE-1))]}"
            FULL_PATH="$PWD/$TARGET_FILE"

        else
            echo "[!] Selection out of range."
            exit 1
        fi

    else
        echo "[!] Invalid selection."
        exit 1
    fi

else

    echo "[!] No audio files found in current directory."
    echo ""

    echo "Drag & drop audio file OR type full path"
    echo ""

    read -p "Audio Path > " USER_AUDIO_PATH

    CLEAN_PATH=$(echo "$USER_AUDIO_PATH" \
    | sed "s/['\"]//g" \
    | sed 's/[[:cntrl:]]//g' \
    | sed 's|\\|/|g')

    FULL_PATH=$(cygpath -u "$CLEAN_PATH" 2>/dev/null || echo "$CLEAN_PATH")

    if [ ! -f "$FULL_PATH" ]; then
        echo ""
        echo "[!] File not found:"
        echo "$FULL_PATH"
        exit 1
    fi
fi

echo ""
echo "[+] Launching separate VLC instance..."
WINDOWS_PATH=$(cygpath -w "$FULL_PATH")

/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe \
-NoProfile \
-ExecutionPolicy Bypass \
-Command "& {
    \$vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe'
    \$audio = '\"$WINDOWS_PATH\"'

    Start-Process -FilePath \$vlc -ArgumentList \$audio
}"
echo "[+] Player launched successfully."