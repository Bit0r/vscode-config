### 一.配置软件源
1. 在图形化pacman中点击`官方软件仓库`,选择`软件镜像源`为`china`，然后点击`刷新镜像列表`
2. 在`/etc/pacman.conf`文件末尾添加以下两行
```
[archlinuxcn]
Server = https://repo.archlinuxcn.org/$arch
```
3. 在仓库中安装`archlinuxcn-keyring`和`archlinuxcn-mirrorlist-git`

### 二.安装字体
1. 在`pacman`里面安装`source-han-sans-cn`,`source-han-serif-cn`,`otf-fira-code`这3种字体
2. 在设置里面找到`qt5设置`,然后`更换字体`为`思源黑体`和`Fira code`
3. 点击`Apply`

### 三.安装语言包
在`manjaro设定`->`语言包`->`可用语言包`里点击`安装软件包`

### 四.安装中文输入法
1. 在`pacman`中安装`fcitx-googlepinyin`,`fcitx-configtool`,`fcitx-qt5`这三个软件包
2. 添加以下参数到`etc/environment`文件
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```
3. 启动`Fcitx`就可以使用了
4. 可能在某些程序中无法使用`Ctrl+Space`调出输入法,解决方法是修改`GSettings`配置
```
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule':<'fcitx'>}"
```

### 五.更换系统DNS
在`WIFI`->`设置`->`IPv4设置`中找到`DNS设置`,在其中填入
```
1.1.1.1,1.0.0.1
```

### 六.安装`shadowsocks`
1. 在商店里安装`shadowsocks-qt5`
2. 导入`ss`链接,无法使用`ssr`链接

### 七.安装`shadowsocksr`
1. 在商店中搜索并安装`electron-ssr`

### 八.配置`socks5`
1. 配置`git`使用`socks5`代理
```
git config --global http.proxy 'socks5h://127.0.0.1:1080'      #设置代理
git config --global --unset http.proxy  #取消代理
```
2. 在商店安装genpac
3. 在`/home`下生成`autoproxy.pac`
```
genpac -o autoproxy.pac --format=pac --pac-proxy="SOCKS5 127.0.0.1:10808"
```
4. 在Firefox的`首选项`->`网络设置`->`自动代理配置的URL（PAC）`中填写PAC文件url
```
file:///home/bit0r/autoproxy.pac
```
5. 在Firefox的`首选项`->`网络设置`中勾选`使用 SOCKS v5 时代理 DNS 查询`

### 九.修改系统`hosts`文件
1. 在`Github`中找到`googlehosts`项目,然后将源代码中的`hosts`文件内容添加到`/etc/hosts`文件末尾

### 十.安装`AUR助手`
在商店中安装`yay`,`pacui`这两个软件包,多余的可选依赖不要,同时开启商店的`AUR`功能
> yay的常用命令
> ```
> ay <Search Term> 搜索并选择安装
> yay -Yc 清理不需要的依赖
> yay -R <package_name> 删除软件包
> yay -Scc 清理缓存
> ```

### 十一.安装`redshift`
这是一个manjaro的护眼软件,他会自动开启护眼模式(gnome自带护眼模式，所以不需要这个软件)

## Shell自动化完成
嗯,一位酷友做了一份自动化的shell脚本,这是[仓库链接](https://github.com/Alexander-Huang/Manjaro-configure-cn)。\
这个脚本免去了手动安装的过程，据说非常好用
