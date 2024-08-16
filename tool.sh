source config.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# create chezmoi config
chezmoi_dir=$HOME/.config/chezmoi
mkdir -p "$chezmoi_dir"
touch "$chezmoi_dir/chezmoi.toml"
tee -a "$chezmoi_dir/chezmoi.toml" >/dev/null <<EOT
[data.environment]
is_work_machine = true
desktop_environment = "KDE_Plasma"
EOT

# change shell to zsh
chsh -s "$(which zsh)"

# docker
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker "$USER"

# virtual box
sudo usermod -aG vboxusers "$USER"       # enable usb passthrough
virtualbox_dir=$documents_dir/VirtualBox # make virtual box directory
mkdir -p "$virtualbox_dir"
vboxmanage setproperty machinefolder "$virtualbox_dir"
