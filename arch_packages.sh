#!/bin/bash
set -xeuo pipefail

source config.sh

if ! $is_arch; then
  exit 1
fi

arch_packages=(
  # kernel
  "linux"
  "linux-lts"

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

  # system
  "btop"
  "chezmoi"
  "fwupd"
  "ufw"
  "zsh"

  # tools
  "7zip"
  "cmake"
  "curlie"
  "diff-so-fancy"
  "fd"
  "fzf"
  "gcc"
  "git"
  "jq"
  "k9s"
  "lazygit"
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
  "yazi"
  "zip"

  # programming
  "go"
  "just"
  "marksman"
  "uv"

  # gui applications
  "alacritty"
  "bitwarden"
  "gparted"
  "gthumb"
  "libreoffice-fresh"
  "thunderbird"
  "transmission-qt"
  "virtualbox"
  "virtualbox-guest-iso"
  "virtualbox-host-modules-arch"
  "virtualbox-host-modules-lts"
  "vlc"
  "vlc-plugins-all"

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
  "dops-bin" # fancy docker ps
  "fnm-bin"
  "noto-fonts-sc"
  "noto-fonts-tc"
  "slack-desktop"
  "visual-studio-code-bin"
  "zsh-antidote"

  # android development
  "android-studio"
)

flatpak_packages=(
  "com.spotify.Client"
  "com.obsproject.Studio"
  "io.dbeaver.DBeaverCommunity"
  "com.github.flxzt.rnote"
  "com.mongodb.Compass"
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
sudo pacman -Syu --needed --noconfirm "${arch_packages[@]}"
yay -Syu --needed --noconfirm "${aur_packages[@]}"

if command -v flatpak &>/dev/null; then
  flatpak install --user -y "${flatpak_packages[@]}"
fi
