#!/bin/bash
xdg_config_dir=$HOME/.config
virtual_machine_dir=$HOME/virtual_machines

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# create chezmoi config
chezmoi_dir="$xdg_config_dir/chezmoi"
mkdir -p "$chezmoi_dir"
touch "$chezmoi_dir/chezmoi.toml"
tee -a "$chezmoi_dir/chezmoi.toml" >/dev/null <<EOT
[data.environment]
is_work_machine = true
desktop_environment = "KDE_Plasma"
EOT

# docker
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker "$USER"

# virtual box
sudo usermod -aG vboxusers "$USER"             # enable usb passthrough
virtualbox_dir=$virtual_machine_dir/virtualbox # make virtual box directory
mkdir -p "$virtualbox_dir"
vboxmanage setproperty machinefolder "$virtualbox_dir"
