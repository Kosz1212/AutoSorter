# AutoSorter

📂 **Bash Script for Automatic File Sorting by Type**

---

## 🖥️ About

**AutoSorter** is a Bash script that automatically organizes files in a selected directory (e.g., `$HOME/Downloads`) by file type. It helps keep your workspace clean by sorting documents, images, archives, and scripts into appropriate folders.

> 🐧 **Built and tested on [NixOS](https://nixos.org/)** – works on other Linux distributions with standard tools available.

---

## 📁 What It Does

- Recognizes and organizes files based on their extension:

    - **📄 Documents**: `pdf`, `doc`, `docx`, `txt`, `odt`, `rtf`, `xls`, `xlsx`, `ppt`, `pptx`, `csv`, `vcf`, `apkg`
    - **🖼️ Images**: `jpg`, `jpeg`, `png`, `gif`, `bmp`, `svg`, `webp`, `tiff`, `ico`
    - **📦 Archives**: `zip`, `rar`, `tar`, `7z`, `gz`, `bz2`, `xz`
    - **📜 Scripts**: `sh`, `py`, `js`, `rb`, `pl`, `bat`, `ps1`
    - **⚙️ Executables**: `exe`, `msi`, `apk`, `AppImage`, `deb`, `rpm`, `bin`, `run`
    - **🎵 Music**: `mp3`, `wav`, `flac`, `ogg`, `m4a`, `aac`, `aup3`
    - **🎞️ Videos**: `mp4`, `mkv`, `avi`, `mov`, `wmv`, `flv`, `webm`
    - **🧲 Torrents**: `torrent`
    - **💿 Disk Images**: `iso`, `img`, `dmg`
    - **🧠 Source Files**: `c`, `cpp`, `h`, `hpp`, `java`, `cs`, `go`, `ts`, `html`, `css`, `json`, `xml`, `yaml`, `yml`
    - **📝 Logs**: `log`
    - **❔ Other**: files with no extension or with unrecognized types will be skipped

- Moves each file to its corresponding folder (e.g., `Documents`, `Images`)
- Creates folders if they do not already exist	
- Skips files with unsupported or unrecognized extensions (they remain in place)

---

## ⚙️ How to Use

1. Clone or copy the script to your machine  
2. Make it executable:
   ```bash
   chmod +x autosorter.sh
```
3. Run it:
```bash
./autosorter.sh
```
> By default, the script targets the `$HOME/Downloads` directory. You can customize the target folder inside the script.
---
## 🧪 Example

A file named `photo.png` will be moved to `$HOME/Images`

A file named `report.pdf` will be moved to `$HOME/Documents`

Unknown file types remain in place

---
## 🕒 Automation (optional)
You can schedule AutoSorter to run once daily using `cron` or `systemd timers`.
Here’s an example using a systemd user timer (recommended on NixOS):

`~/.config/systemd/user/autosorter.service`
```ini
[Unit]
Description=Run AutoSorter script

[Service]
Type=oneshot
ExecStart=%h/scripts/autosorter.sh
```
`~/.config/systemd/user/autosorter.timer`
```ini
[Unit]
Description=Run AutoSorter daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```
Then enable it:
```bash
systemctl --user daemon-reload
systemctl --user enable --now autosorter.timer
```
---

**Maintained by [Kosz1212](https://github.com/Kosz1212)**
