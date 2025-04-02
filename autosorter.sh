#!/usr/bin/env bash

# Create Logs folder if not exists
mkdir -p "$HOME/Logs"

# Redirect all output to a timestamped log file
logfile="$HOME/Logs/sorter-$(date +%Y-%m-%d).log"
exec >> "$logfile" 2>&1

declare -A extension_map

extension_map["pdf"]="Documents"
extension_map["doc"]="Documents"
extension_map["docx"]="Documents"
extension_map["txt"]="Documents"
extension_map["odt"]="Documents"
extension_map["rtf"]="Documents"
extension_map["xls"]="Documents"
extension_map["xlsx"]="Documents"
extension_map["ppt"]="Documents"
extension_map["pptx"]="Documents"
extension_map["csv"]="Documents"
extension_map["vcf"]="Documents"
extension_map["apkg"]="Documents"
extension_map["jpg"]="Images"
extension_map["jpeg"]="Images"
extension_map["png"]="Images"
extension_map["gif"]="Images"
extension_map["bmp"]="Images"
extension_map["svg"]="Images"
extension_map["webp"]="Images"
extension_map["tiff"]="Images"
extension_map["ico"]="Images"
extension_map["zip"]="Archives"
extension_map["rar"]="Archives"
extension_map["tar"]="Archives"
extension_map["7z"]="Archives"
extension_map["gz"]="Archives"
extension_map["bz2"]="Archives"
extension_map["xz"]="Archives"
extension_map["sh"]="Scripts"
extension_map["py"]="Scripts"
extension_map["js"]="Scripts"
extension_map["rb"]="Scripts"
extension_map["pl"]="Scripts"
extension_map["bat"]="Scripts"
extension_map["ps1"]="Scripts"
extension_map["exe"]="Executables"
extension_map["msi"]="Executables"
extension_map["apk"]="Executables"
extension_map["AppImage"]="Executables"
extension_map["deb"]="Executables"
extension_map["rpm"]="Executables"
extension_map["bin"]="Executables"
extension_map["run"]="Executables"
extension_map["mp3"]="Music"
extension_map["wav"]="Music"
extension_map["flac"]="Music"
extension_map["ogg"]="Music"
extension_map["m4a"]="Music"
extension_map["aac"]="Music"
extension_map["aup3"]="Music"
extension_map["mp4"]="Videos"
extension_map["mkv"]="Videos"
extension_map["avi"]="Videos"
extension_map["mov"]="Videos"
extension_map["wmv"]="Videos"
extension_map["flv"]="Videos"
extension_map["webm"]="Videos"
extension_map["torrent"]="Torrents"
extension_map["iso"]="Disk_images"
extension_map["img"]="Disk_images"
extension_map["dmg"]="Disk_images"
extension_map["c"]="Source_files"
extension_map["cpp"]="Source_files"
extension_map["h"]="Source_files"
extension_map["hpp"]="Source_files"
extension_map["java"]="Source_files"
extension_map["cs"]="Source_files"
extension_map["go"]="Source_files"
extension_map["ts"]="Source_files"
extension_map["html"]="Source_files"
extension_map["css"]="Source_files"
extension_map["json"]="Source_files"
extension_map["xml"]="Source_files"
extension_map["yaml"]="Source_files"
extension_map["yml"]="Source_files"
extension_map["log"]="Logs"
extension_map[""]="Other"

if [[ -d ~/Downloads ]]; then
    cd ~/Downloads || exit 1
else
    echo "~/Downloads doesn't exist!"
    exit 1
fi

# Fetching list of files (excluding directories), even if filenames contain spaces
mapfile -t files < <(find . -maxdepth 1 -type f | sed 's|^\./||')

file_number=0
file="${files[$file_number]}"

while [[ "$file" ]]; do
    echo "Processing file: $file"
    ext="${file##*.}"
    ext="${ext,,}"

    if [[ -z "${extension_map[$ext]}" ]]; then
        echo "No folder mapped for .$ext -> skipping"
    else
        folder="${extension_map[$ext]}"
        
        echo "Moving $file to directory: $folder"
        echo "Extension: .$ext"
        echo "Target directory: $folder"

        # Create folder if not exists
        mkdir -p "$HOME/$folder"

        # Move file
        mv "$file" "$HOME/$folder/"
    fi

    # Next file
    ((file_number++))
    file="${files[$file_number]}"
done

echo "Done processing files."