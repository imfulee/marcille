#!/bin/bash
set -x
set -e

bash arch_packages.sh || exit
[[ -f security.sh ]] && bash security.sh
bash directory.sh
bash tool.sh
bash steam.sh
