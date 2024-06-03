function join {
	local IFS="$1"
	shift
	echo "$*"
}

arch_packages=(
	# package managers
	"flatpak"
	"yay"
	# input methods
	"fcitx5"
	"fcitx5-chinese-addons"
	# containers
	"docker"
	"podman"
	# wayland
	"wl-clipboard"
	# tools
	"alacritty"
	"btop"
	"cmake"
	"chezmoi"
	"fwupd"
	"fzf"
	"git"
	"libreoffice-fresh"
	"make"
	"neovim"
	"net-tools"
	"pandoc"
	"pyenv"
	"stow"
	"tmux"
	"wget"
	"zip"
	"zsh"
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
	# system
	"linux-zen"
)

aur_packages=(
	"visual-studio-code-bin"
	"fnm"
	"slack-desktop"
	"brave-bin"
	"noto-fonts-sc"
	"noto-fonts-tc"
	"zsh-antidote"
)

flatpak_packages=(
	"com.spotify.Client"
	"com.obsproject.Studio"
	"com.mongodb.Compass"
	"io.dbeaver.DBeaverCommunity"
	"com.logseq.Logseq"
)

# install packages
sudo pacman -Syu $(join " " ${arch_packages[@]})
sudo yay -Syu $(join " " ${aur_packages[@]})
flatpak install -y flathub $(join " " ${flatpak_packages[@]})

# create work and personal project directories
mkdir -p $HOME/{work,personal}

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
