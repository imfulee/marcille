#!/bin/bash
# default values

export is_personal_machine=true

# directories
export documents_dir=$HOME/Documents
export downloads_dir=$HOME/Downloads
export work_dir=$HOME/work
export personal_dir=$HOME/personal
export container_dir=$HOME/container
export xdg_config_dir=$HOME/.config
export virtual_machine_dir=$HOME/virtual_machines

# use env to override config values
[[ -f .env ]] && source .env
