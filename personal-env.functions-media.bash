#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-helpers.bash"

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
