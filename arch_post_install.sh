is_arch=false
is_endeavouros=false
os_name=$(grep -E "^(NAME)=" /etc/os-release | awk -F = '{ print $2 }' | sed 's/"//g')
documents_dir=$HOME/Documents

if ! command -v pacman &>/dev/null; then
  is_arch=true
fi

if [ "$os_name" == "EndeavourOS" ]; then
  is_endeavouros=true
fi

join() {
  local IFS="$1"
  shift
  echo "$*"
}

if [[ ! -d $documents_dir ]]; then
  documents_dir=$HOME/documents
  mkdir -p $documents_dir
fi

arch_packages=(
  # package managers
  "flatpak"
  # input methods
  "fcitx5-im"
  "fcitx5-chinese-addons"
  # containers
  "docker"
  "docker-compose"
  "podman"
  "podman-compose"
  # wayland
  "wl-clipboard"
  # tools
  "alacritty"
  "btop"
  "chezmoi"
  "cmake"
  "curlie"
  "diff-so-fancy"
  "fd"
  "fwupd"
  "fzf"
  "gcc"
  "git"
  "jq"
  "k9s"
  "lazygit"
  "libreoffice-fresh"
  "make"
  "neovim"
  "net-tools"
  "pandoc"
  "pyenv"
  "ripgrep"
  "speedtest-cli"
  "stow"
  "tree"
  "unzip"
  "wget"
  "zellij"
  "zip"
  "zsh"
  # programming
  "go"
  # gui applications
  "bitwarden"
  "gparted"
  "gthumb"
  "gnome-boxes"
  "thunderbird"
  "transmission-qt"
  "virtualbox"
  "virtualbox-guest-iso"
  # fonts
  "nerd-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
)

if is_arch; then
  if is_endeavouros; then
    arch_packages+=(
      # package manager
      "yay"
    )
  else
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd $HOME
    rm -rf yay
  fi
else
  # if not arch then exit
  exit 0
fi

fi

aur_packages=(
  "visual-studio-code-bin"
  "fnm-bin"
  "slack-desktop"
  "brave-bin"
  "mongodb-compass"
  "noto-fonts-sc"
  "noto-fonts-tc"
  "virtualbox-ext-oracle"
  "zsh-antidote"
  "tmux-plugin-manager"
)

flatpak_packages=(
  "com.spotify.Client"
  "com.obsproject.Studio"
  "io.dbeaver.DBeaverCommunity"
)

# install packages
sudo pacman -Syu $(join " " ${arch_packages[@]})
yay -Syu $(join " " ${aur_packages[@]})
flatpak install -y flathub $(join " " ${flatpak_packages[@]})

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# create work and personal project directories
work_dir=$HOME/work
personal_dir=$HOME/personal
container_dir=$HOME/container
mkdir -p $work_dir $personal_dir $container_dir

# create chezmoi config
chezmoi_dir=$HOME/.config/chezmoi
mkdir -p $chezmoi_dir
touch $chezmoi_dir/chezmoi.toml
tee -a $chezmoi_dir/chezmoi.toml >/dev/null <<EOT
[data.environment]
is_work_machine = true
EOT

# change shell to zsh
chsh -s $(which zsh)

# docker
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER

# virtual box
sudo usermod -aG vboxusers $USER         # enable usb passthrough
virtualbox_dir=$documents_dir/VirtualBox # make virtual box directory
mkdir -p $virtualbox_dir
vboxmanage setproperty machinefolder $virtualbox_dir
