source config.sh

if ! $is_arch; then
  exit 1
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
  "docker-buildx"
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
  "minio-client"
  "neovim"
  "net-tools"
  "pandoc"
  "ripgrep"
  "speedtest-cli"
  "stow"
  "tmux"
  "tree"
  "unzip"
  "wget"
  "zip"
  "zsh"
  # programming
  "go"
  "just"
  "marksman"
  "pyenv"
  "python-pdm"
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

aur_packages=(
  "apachedirectorystudio"
  "brave-bin"
  "fnm-bin"
  "mongodb-compass"
  "noto-fonts-sc"
  "noto-fonts-tc"
  "rate-mirrors-bin"
  "slack-desktop"
  "tmux-plugin-manager"
  "visual-studio-code-bin"
  "virtualbox-ext-oracle"
  "zsh-antidote"
)

flatpak_packages=(
  "com.spotify.Client"
  "com.obsproject.Studio"
  "io.dbeaver.DBeaverCommunity"
  "com.github.flxzt.rnote"
  "com.getpostman.Postman"
)

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

# install packages
sudo pacman -Syu --needed "${arch_packages[@]}"
yay -Syu --needed "${aur_packages[@]}"

if command -v flatpak &>/dev/null; then
  flatpak install --user -y "${flatpak_packages[@]}"
fi
