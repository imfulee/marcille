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
	"fcitx5-im"
	"fcitx5-chinese-addons"
	# containers
	"docker"
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
	"fwupd"
	"fzf"
	"git"
	"k9s"
	"lazygit"
	"libreoffice-fresh"
	"make"
	"neovim"
	"net-tools"
	"pandoc"
	"pyenv"
	"speedtest-cli"
	"stow"
	"tmux"
	"wget"
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
	# system
	"linux-zen"
)

aur_packages=(
	"visual-studio-code-bin"
	"fnm-bin"
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
yay -Syu $(join " " ${aur_packages[@]})
flatpak install -y flathub $(join " " ${flatpak_packages[@]})

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# create work and personal project directories
work_dir=$HOME/work
personal_dir=$HOME/personal
mkdir -p $work_dir $personal_dir

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
