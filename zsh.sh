#!/bin/bash

if ! which git > /dev/null 2>&1; then
    echo -e "\ngit is not found.\nexit with code 1.\n"
    exit 1
elif ! which curl > /dev/null 2>&1; then
    echo -e "\ncurl is not found.\nexit with code 1.\n"
    exit 1
elif ! which zsh > /dev/null 2>&1; then
    echo -e "\nzsh is not found.\nexit with code 1.\n"
    exit 1
fi

curl -k -sSL https://gitee.com/xiaoqqya/ohmyzsh/raw/master/tools/install.sh | sed "s/\$REMOTE/https:\/\/gitee.com\/xiaoqqya\/ohmyzsh.git/g" | sed "/.*exec zsh.*/d" > $HOME/.temp

cat <<EOF >> $HOME/.temp

git clone https://gitee.com/xiaoqqya/spaceship-prompt.git "\$ZSH/custom/themes/spaceship-prompt" --depth=1
ln -s "\$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "\$ZSH/custom/themes/spaceship.zsh-theme"
echo -e "\n"

git clone https://gitee.com/xiaoqqya/zsh-autosuggestions.git \${ZSH:-~/.oh-my-zsh}/custom/plugins/zsh-autosuggestions
echo -e "\n"

git clone https://gitee.com/xiaoqqya/zsh-syntax-highlighting.git \${ZSH:-~/.oh-my-zsh}/custom/plugins/zsh-syntax-highlighting
echo -e "\n"

git clone https://gitee.com/xiaoqqya/conda-zsh-completion.git \${ZSH:-~/.oh-my-zsh}/custom/plugins/conda-zsh-completion
EOF

sh $HOME/.temp
rm -rf $HOME/.temp

sed -i "s/ZSH_THEME=\".*/ZSH_THEME=\"spaceship\"/g" $HOME/.zshrc
sed -i "s/plugins=(git)/plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting conda-zsh-completion pip ufw docker docker-compose extract command-not-found)/g" $HOME/.zshrc

cat <<EOF >> $HOME/.zshrc

# 关闭 git 显示
SPACESHIP_GIT_SHOW=true
# 关闭 node 显示
SPACESHIP_NODE_SHOW=true
# 关闭 maven 显示
SPACESHIP_MAVEN_SHOW=true
# 关闭 package 显示
SPACESHIP_PACKAGE_SHOW=true

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
EOF

exec zsh -l
