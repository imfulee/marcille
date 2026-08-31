#!/bin/bash

arch_packages=(
  # kernel
  "linux"
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
  "7zip"
  "btop"
  "chezmoi"
  "fwupd"
  "ufw"
  "zsh"

  # tools
  "7zip"
  "base-devel"
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
  "tree"
  "unzip"
  "wget"
  "yazi"
  "zip"

  # programming
  "go"
  "uv"

  # gui applications
  "alacritty"
  "bitwarden"
  "ghostty"
  "gparted"
  "gthumb"
  "libreoffice-fresh"
  "steam"
  "thunderbird"
  "transmission-qt"
  "virtualbox"
  "virtualbox-guest-iso"
  "virtualbox-host-modules-arch"
  # fonts
  "nerd-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
  # flutter development 
  # "llvm" 
  # "clang"
)

optional_arch_packages=(
  # "linux-lts"
  # "virtualbox-host-modules-lts"
  "marksman"
  # "just"
  # "tmux"
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
  "mullvad-vpn-bin"
)

optional_aur_packages=(
  # "tmux-plugin-manager"
)

flatpak_packages=(
  "com.spotify.Client"
  "com.obsproject.Studio"
  "io.dbeaver.DBeaverCommunity"
  "com.github.flxzt.rnote"
  "com.mongodb.Compass"
  "io.ente.auth"
  "org.localsend.localsend_app"
)

install_yay() {
  local yay_directory="/tmp/yay"
  git clone https://aur.archlinux.org/yay.git "$yay_directory"
  makepkg -si --dir "$yay_directory"
  rm -rf "$yay_directory"
}

# install packages
sudo pacman -Syu --needed --noconfirm "${arch_packages[@]}"
install_yay
yay -Syu --needed --noconfirm "${aur_packages[@]}"
flatpak install --user -y "${flatpak_packages[@]}"
