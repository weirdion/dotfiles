#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-helpers.bash"

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
