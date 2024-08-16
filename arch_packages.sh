source config.sh
source utils.sh

arch_packages=(
  # package managers
  "flatpak"
  # input methods
  "fcitx5-im"
  "fcitx5-chinese-addons"
  # containers
  "docker"
  "docker-compose"
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

if ! $is_arch; then
  exit 0
fi

if $is_endeavouros; then
  arch_packages+=(
    # package manager
    "yay"
  )
else
  sudo pacman -S --needed git base-devel

  yay_directory="/tmp/yay"
  git clone https://aur.archlinux.org/yay.git "$yay_directory"

  cd "$yay_directory" || exit
  makepkg -si

  cd "$HOME" || exit
  rm -rf "$yay_directory"
fi

if $is_personal_machine; then
  arch_packages+=(
    # apps
    steam
  )
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
  "rate-mirrors-bin"
)

flatpak_packages=(
  "com.spotify.Client"
  "com.obsproject.Studio"
  "io.dbeaver.DBeaverCommunity"
)

if $is_arch; then
  # install packages
  sudo pacman -Syu $(join " " ${arch_packages[@]})
  yay -Syu $(join " " ${aur_packages[@]})
fi

if command -v flatpak &>/dev/null; then
  flatpak install -y $(join " " ${flatpak_packages[@]})
fi
