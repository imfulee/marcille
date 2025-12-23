#!/bin/bash
set -xeuo pipefail

[[ -f arch_packages.sh ]] && bash arch_packages.sh || exit
[[ -f base_setup.sh ]] && bash base_setup.sh
[[ -f security.sh ]] && bash security.sh
bash tool.sh
bash steam.sh
