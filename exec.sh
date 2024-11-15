set -x
set -e

bash arch_packages.sh || exit
bash directory.sh
bash tool.sh
bash steam.sh
