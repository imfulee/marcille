# default values
export is_personal_machine=true
export is_arch=false
export is_endeavouros=false
export os_name=$(grep -E "^(NAME)=" /etc/os-release | awk -F = '{ print $2 }' | sed 's/"//g')

# directories
export documents_dir=$HOME/Documents
export downloads_dir=$HOME/Downloads
export work_dir=$HOME/work
export personal_dir=$HOME/personal
export container_dir=$HOME/container
export xdg_config_dir=$HOME/.config

if command -v pacman &>/dev/null; then
  is_arch=true
fi

if [ "$os_name" == "EndeavourOS" ]; then
  is_endeavouros=true
fi

# use env to override config values
[[ -f .env ]] && source .env
