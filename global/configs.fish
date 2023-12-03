#!/usr/bin/fish

# 复制snippets
mkdir -p ~/.config/Code/User/snippets
cp snippets/*.json ~/.config/Code/User/snippets/

# 复制settings和keybindings
cp *.json ~/.config/Code/User/

# 安装插件
for ext in (cat extensions.txt)
    code --install-extension $ext
end
