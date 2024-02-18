#!/bin/bash
## simple bash script to replace blind xss payloads with a collaborator/interact.sh url

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <replacement_url> <output_file>"
    exit 1
fi

input_file="$1"
replacement_url="$2"
output_file="$3"

if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found"
    exit 1
fi

sed "s#{PAYLOAD}#$replacement_url#g" "$input_file" > "$output_file"

echo "Replacement complete. Output written to '$output_file'"
