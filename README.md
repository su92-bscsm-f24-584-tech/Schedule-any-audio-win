# 🎵 Windows Audio Scheduler Utility
ONLY FOR WINDOW
A lightweight Bash-based automation utility for Windows that lets you:

- Scan local folders for audio files
- Select a preferred alarm track
- Save the selected track automatically
- Schedule daily playback using Windows Task Scheduler
- Run silently in the background through Git Bash

Perfect for alarms, reminders, scheduled ambient sounds, or lightweight automation tasks.

---

# ✨ Features

- ✅ Interactive audio selector
- ✅ Automatic task scheduling
- ✅ Native Windows Task Scheduler integration
- ✅ Supports `.mp3`, `.wav`, `.m4a`, `.wma`
- ✅ Works through Git Bash
- ✅ Lightweight and dependency-free (except media player)

---

# 📂 Project Structure

```text
.
├── audio_config.sh      # Interactive setup & scheduling utility
├── cron_player.sh       # Background playback script
├── selected.txt         # Auto-generated selected audio state file
└── README.md
```

| File | Purpose |
|------|----------|
| `audio_config.sh` | Main interactive utility for selecting audio and creating scheduled tasks |
| `cron_player.sh` | Executed automatically by Windows Task Scheduler |
| `selected.txt` | Stores the currently selected audio filename |

---

# 🛠️ Requirements

Before using the utility, install the following:

## 1. Git for Windows

Install:

- Git Bash
- Unix shell tools

Default installation path:

```text
C:\Program Files\Git
```

Download:

https://git-scm.com/download/win

---

## 2. Audio Player (CLI Supported)

Install at least one command-line media player:

- `mpv`
- `vlc`
- `ffplay`

Add the player executable to your Windows `PATH`.

Example:

```bash
mpv song.mp3
```

should work from terminal.

---

# 🚀 Setup Guide

# 1. Clone or Copy the Project

Example folder:

```text
C:\Users\YourName\audio_scheduler
```

Place these files inside:

```text
audio_config.sh
cron_player.sh
```

Also place your audio files in the same folder.

Example:

```text
morning_alarm.mp3
birds.wav
focus_music.m4a
```

---

# 2. Grant Execution Permission

Open Git Bash inside the project folder and run:

```bash
chmod +x audio_config.sh
chmod +x cron_player.sh
```

---

# 3. Run the Configuration Utility

Start the setup utility:

```bash
./audio_config.sh
```

---

# 4. Select an Audio File

Example interface:

```text
=============================================
         AUDIO CONFIGURATION UTILITY
=============================================

 [1] morning_alarm.mp3
 [2] birds.wav
 [3] focus_music.m4a

---------------------------------------------
Select item number to register > 1
```

After selection:

```text
[+] Configuration saved: morning_alarm.mp3
```

This creates:

```text
selected.txt
```

---

# 5. Configure Alarm Time

Enter the desired trigger time using 24-hour format.

Example:

```text
Target Alarm Time (HH:MM) > 07:30
```

Output:

```text
[+] Scheduling background task trigger for 07:30...
[+] Integration Complete! Task configured successfully.
```

---

# ⚙️ How It Works

The utility creates a scheduled Windows task using:

```bash
schtasks
```

At the configured time Windows executes:

```bash
"C:\Program Files\Git\bin\bash.exe" --login -i -c "cd /c/Users/YourName/audio_scheduler && ./cron_player.sh"
```

Workflow:

1. `audio_config.sh`
   - scans audio files
   - saves selected file

2. Windows Task Scheduler
   - launches daily at scheduled time

3. `cron_player.sh`
   - reads `selected.txt`
   - plays the audio using your CLI player

---

# 🔊 Example cron_player.sh

Example using `mpv`:

```bash
#!/bin/bash

FILE=$(cat selected.txt)

mpv "$FILE"
```

Example using VLC:

```bash
#!/bin/bash

FILE=$(cat selected.txt)

vlc "$FILE"
```

---

# 🧩 Creating a Windows `.exe`

You can convert the launcher into a standalone executable for easier usage.

---

# Method 1 — Create `.exe` Using Batch File + IExpress

## Step 1 — Create `launch.bat`

Create:

```bat
@echo off
"C:\Program Files\Git\bin\bash.exe" --login -i -c "cd /c/Users/YourName/audio_scheduler && ./audio_config.sh"
pause
```

Save as:

```text
launch.bat
```

---

## Step 2 — Open IExpress

Press:

```text
Win + R
```

Type:

```text
iexpress
```

Press Enter.

---

## Step 3 — Create EXE Package

Follow the wizard:

### Select:

```text
Create new Self Extraction Directive file
```

### Choose:

```text
Extract files and run an installation command
```

### Add:

```text
launch.bat
```

### Install Program:

```text
launch.bat
```

### Save Output As:

```text
AudioScheduler.exe
```

Done ✅

---

# Method 2 — Convert BAT to EXE (Recommended)

Use:

- Bat To Exe Converter

Download:

https://bat-to-exe-converter.en.lo4d.com/windows

---

## Configure

### Batch File:

```text
launch.bat
```

### Output:

```text
AudioScheduler.exe
```

Optional:

- Add icon
- Hide console
- Compress executable

Build EXE.

---

# 📌 Optional Improvements

You can enhance the project by adding:

- GUI file selector
- Notification support
- Volume control
- Multiple alarms
- Weekly schedules
- Playlist mode
- Auto-start on boot
- Portable standalone package

---

# 🔍 Troubleshooting

# Task Creation Fails

Run Git Bash as Administrator.

Steps:

1. Close Git Bash
2. Right-click Git Bash
3. Select:

```text
Run as administrator
```

4. Retry setup

---

# Audio Does Not Play

Verify:

- media player is installed
- media player is added to `PATH`
- correct folder path is used
- audio file exists

Test manually:

```bash
mpv test.mp3
```

---

# Incorrect Path Errors

Update paths inside:

```bash
audio_config.sh
```

and

```bat
launch.bat
```

Example:

```bash
cd /c/Users/YourName/audio_scheduler
```

---

# 🧠 Notes

- Git Bash path conversion is bypassed using:

```bash
MSYS_NO_PATHCONV=1
```

- Windows Task Scheduler handles the automation reliably even after reboot.

---

# 📜 License

MIT License

Free to use, modify, and distribute.

---

# ❤️ Contributing

Pull requests and improvements are welcome.

Feel free to fork and expand the project.

---
