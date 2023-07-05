# 0.配置国内源
sed -i '$a\[multilib]\nInclude = /etc/pacman.d/mirrorlist\n\n[archlinuxcn]\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' /etc/pacman.conf
sudo pacman -Syy
sudo pacman -S archlinuxcn-keyring

# 1.安装基础工具
sudo pacman -S curl git make gcc zip unzip

# 2.安装驱动
sudo pacman -S alsa-utils xf86-video-intel xf86-input-libinput

# 3.安装常用工具
sudo pacman -S paru pacmanfm udisks2 fcitx net-tools openssh networkmanager 

# 4.安装个人常用字体(包含dwm所需)
sudo pacman -S wqy-zenhei 
sudo pacman -S adobe-source-han-serif-cn-fonts 
sudo pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
paru -S ttf-joypixels
paru -S ttf-nerd-fonts-symbols

# 5.安装zsh 加载zsh个人配置
sudo pacman -S zsh
sudo chsh -s /bin/zsh
cd "$HOME"
curl -O https://raw.githubusercontent.com/xclay-net/script/master/zsh.sh
chmod +x ./zsh.sh
./zsh.sh

# 6. dwm依赖安装配置
sudo pacman -S xorg-server xorg-xinit xorg-xsetroot libxinerama
sudo pacman -S alacritty rofi imlib2 feh picom acpi sddm
cd "$HOME"
git clone https://github.com/xclay-net/dwmHome.git "$HOME/.dwm"
cd "$HOME/.dwm/dwm"
sudo make clean install
mkdir "$HOME/.config"
mv "$HOME/.dwm/alacritty" "$HOME/.config/"
mv "$HOME/.dwm/rofi" "$HOME/.config/"
sudo mkdir /usr/share/xsessions
sudo sh -c "cat <<EOF >> /usr/share/xsessions/dwm.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
"
sudo systemctl enable sddm
sudo systemctl start sddm

# 7.个人使用包
sudo pacman -S v2ray nmap neovim 
