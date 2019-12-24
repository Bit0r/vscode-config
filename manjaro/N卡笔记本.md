## NVDIA显卡笔记本安装manjaro卡死无法启动LiveCD

> 相信很多人也和我一样在使用双显卡笔记本安装manjaro时遇到了各式各样的问题，下面为大家带来一种比较简单的解决方案

1. 其实很简单，首先进入你的manjaro系统安装界面，在安装界面你会看到boot选项下有一个空白的笔记图标，按下回车键进入
![](grub.jpg)

2. 进图编辑界面后输入：
```
drive=intel acpi_osi=! acpi_osi="Windows 2009"
```

3. 输入完成后按ctrl+x回到安装界面，这时你会发现菜单中多了一行你刚刚输入的文字。
![](editgrub.jpg)

4. 操作完成后直接选择boot选项回车即可正常进入LiveCD

## N卡独显安装系统后开机无法进入系统以及无法正常关机的问题

> 如果通过上面的方式你成功安装了manjaro系统，但是在开机输入密码后却卡在欢迎界面无法进入系统，或是关机时卡死无法正常关机 ，不用多想......还是N卡的问题。

1. 如果你的电脑无法正常进入系统，请在开机在grub引导界面的manjaro系统选项上按下E键进行编辑，找到`quiet`。在`quiet`前插入`nouveau.modeset=0`，这样即可临时禁用N卡驱动,下一次进入系统还需要再次输入。如果想要永远禁用N卡那么还需要修改`/etc/default/grub`文件参数

2. 如果你可以正常的进入manjaro系统，或通过前面的方式已经进入了系统,接下打开`/etc/default/grub`文件。

3. 在GRUB_CMDLINE_LINUX后面插入启动命令
```
nouveau.modeset=0
```
![](editgrub.png)

4. 保存退出,然后更新grub
```
sudo update-grub
```
