#!/usr/bin/fish

cp *.json ~/.config/Code/User/
for ext in (cat extensions.txt)
	code --install-extension $ext
end
