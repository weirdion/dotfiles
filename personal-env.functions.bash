#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-helpers.bash"
source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-git.bash"

function pidinfo() {
  if [ "$#" -eq 1 ]; then
    ps -p "$1" -o pid,user,comm,cmd
  else
    __printInRed "Unable to execute the command."
    __printInWhite "Usage: pidname PID"
  fi
}

function convertToMp4() {
	if [ "$#" -eq 1 ]
	then
		local newName="${1%.*}-new.mp4"
		local finalName="${1%.*}.mp4"
		ffmpeg -i "$1" -f mp4 -vcodec libx264 -preset slow -acodec aac "$newName" -hide_banner && \
		rm -v "$1" && mv "$newName" "$finalName"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: convertToMp4 source"
	fi
}

function convertToMkv() {
	if [ "$#" -eq 1 ]
    then
		local newName="${1%.*}-new.mkv"
		local finalName="${1%.*}.mkv"
		ffmpeg -i "$1" -f matroska -vcodec libx264 -preset slow -acodec libvorbis "$newName" -hide_banner && \
		rm -v "$1" && mv "$newName" "$finalName"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: convertToMkv source"
	fi
}

function stripMetaDataFromVideo() {
	if [ "$#" -eq 1 ]
	then
		# shellcheck disable=SC2155
		local extensionName=$(echo "$1" | rev | cut -d '.' -f1 | rev)
		local newFileName="${1%.*}-new.$extensionName"
		ffmpeg -i "$1" -map_metadata -1 -c:v copy -c:a copy "$newFileName" -hide_banner && \
		mv -v "$newFileName" "$1"
	else
		__printInRed "Unable to execute the command"
		__printInWhite "Usage: stripMetaDataFromVideo videoFile.mkv"
	fi
}

function pullSSLCert() {
	if [ "$#" -eq 1 ]
	then
		openssl s_client -showcerts -connect "${1}":443 < /dev/null 2> /dev/null | openssl x509 -noout -text
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: pullSSLCert webaddress"	
	fi
}

# Get keys from mit liscence keys
function getGPGKey() {
	if [ "$#" -eq 1 ]
	then
		gpg --recv-keys --keyserver hkp://pgp.mit.edu "$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: getGPGKey keyID"
	fi
}

function getCertKeyPemFromPfx() {
	if [ "$#" -eq 1 ]
	then
		openssl pkcs12 -in "$1.pfx" -out "$1-cert.pem" -clcerts -nokeys
    	openssl pkcs12 -in "$1.pfx" -out "$1-key.pem" -nocerts -nodes
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: getCertKeyPemFromPfx name_of_the_pfx"
	fi
}

function sshfs-mount() {
	if [ "$#" -ge 2 ]; then
		sshfs -o uid="$(id -u "$LOGNAME")" -o gid="$(id -u "$LOGNAME")" -o reconnect -o  ServerAliveInterval=15 "$1" "$2"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sshfs-mount [sshfs options] source destination"
	fi
}

function sshfs-umount() {
	if [ "$#" -eq 1 ]; then
		fusermount3 -u "$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sshfs-umount [fusermount options] destination"
	fi
}

function sync-folder-local2remote() {
	if [[ "$#" -eq 2 ]]; then
		rsync --progress -vr --ignore-existing "$1" "$2$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sync-folder-local2remote local-folder remote:path"
		__printInWhite "Example: \`sync-folder-local2remote folder1 dummyremote:/home/user/\` will sync local folder1 with dummyremote:/home/user/folder1"
	fi
}

function scan-docs() {
	date_time_stamp=$(date "+%Y%m%d-%H%M%S")
	scan_dir="/home/$LOGNAME/Documents/scans/"
	pdf_file_name="scanned-$(date "+%Y%m%d-%H%M").pdf"
	scan_image_prefix="scan"
	count_to_scan=1
	convert_to_pdf=false

	function _print-help() {
		__printInWhite "scan-docs without any argument will scan once and save with timestamp."
		__printInWhite "scan-docs [-n/--name] prefix of the scanned images."
		__printInWhite "scan-docs [-c/--count] number of documents to scan, default 1."
		__printInWhite "scan-docs [-p/--pdf] bool flag, default false. No value required. Converts doc images to pdf in the end."
	}


	while [[ $# -gt 0 ]]; do
		key="$1"

		case "$key" in
			-h|--help)
				_print-help
				return 0
				;;
			-n|--name)
				scan_image_prefix="$2"
				shift # past argument
				shift # past value
				;;
			-c|--count)
				count_to_scan="$2"
				shift # past argument
				shift # past value
				;;
			-p|--pdf)
				convert_to_pdf=true
				shift # past argument
				;;
			*)
				__printInRed "Incorrect argument structure used."
				_print-help
				return 1
		esac
	done

	[ ! -d "$scan_dir" ] && mkdir -v "$scan_dir"

	if [ "$convert_to_pdf" = true ] && [ "$scan_image_prefix" != "scan" ]; then
		pdf_file_name="$scan_image_prefix.pdf"
	fi

	[ "$scan_image_prefix" = "scan" ] && scan_image_prefix+="-$date_time_stamp"

	scanned_files=()
	counter=1
	while [[ "$counter" -le "$count_to_scan" ]]; do
		read -n 1 -s -r -p "Press any key to start scanning"
		
		file_name="$scan_dir$scan_image_prefix-"

		[ "$counter" -lt 10 ] && file_name+="0"
		
		file_name+="$counter.jpg"
		hp-scan --size=letter -m color -f "$file_name"

		result=$?

		if [ "$result" -eq 0 ]; then
			scanned_files+=( "$file_name" )
			((counter++))
		else
			__printInRed "Looks like the scan failed, let's try that again"
		fi		
	done

	if [[ "$convert_to_pdf" = true ]]; then
		convert "${scanned_files[*]}" "$scan_dir$pdf_file_name"
	fi
	__printInGreen "All done! Output directory used was: $scan_dir."
}
