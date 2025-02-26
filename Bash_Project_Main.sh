#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: Run the script and separate each file name with a space. No commas needed. Ex. FileA FileB FileC etc."
    exit 0
fi

read -r -p "Enter the output file name: " output_file

if [[ ! "$output_file" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Error: Output file name must contain only letters, numbers and underscores."
    exit 1
fi

echo "Enter the file names to concatenate (separated by space):"
read -r input_files
files=($input_files)

if [ "${#files[@]}" -eq 0 ]; then
    echo "Error: No input files specified."
    exit 1
fi

regex="^[a-zA-Z0-9_]+$"
for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found."
        exit 1
    fi
    if [[ ! "$file" =~ $regex ]]; then
        echo "Error: Invalid file name '$file'. Only letters, numbers, and underscores allowed."
        exit 1
    fi
done

cat "${files[@]}" | tr '\n' ' ' > "$output_file"

sed -i '' 's/ $//' "$output_file"

echo "Files concatenated into '$output_file'."