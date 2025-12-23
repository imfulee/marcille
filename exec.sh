#!/bin/bash
set -xeuo pipefail

files=(
    "arch_packages.sh"
    "base_setup.sh"
    "security.sh"
    "tool.sh"
    "steam.sh"
)

for file in "${files[@]}"; do
    [[ -f "$file" ]] && bash "$file" || exit
done
