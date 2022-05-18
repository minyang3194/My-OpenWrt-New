#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)


# Change Argon Theme
rm -rf ./feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git ./package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/luci-app-argon-config

# Change default BackGround img
wget -O ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/HiJwm/MySettings/raw/main/BackGround/2.jpg
svn co https://github.com/xylz0928/luci-mod/trunk/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons ./package/lucimod
mv package/lucimod/* feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/


# Change default theme lienol专用
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile

#主题官方对istore支持不好，将istore移至“服务”菜单里 移动成功 但是无法安装应用
#sed -i 's/"admin", "store"/"admin", "services", "store"/g' feeds/smpackage/luci-app-store/luasrc/controller/store.lua
#sed -i 's/admin\/store/admin\/services\/store/g' feeds/smpackage/luci-app-store/API.md


# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.100.103/g' package/base-files/files/bin/config_generate

#尝试修改lienol大概览
wget -O ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/19_cpu.js https://raw.githubusercontent.com/HiJwm/MySettings/main/19_cpu.js
wget -O ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js https://raw.githubusercontent.com/HiJwm/MySettings/main/20_memory.js
wget -O ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/25_storage.js https://raw.githubusercontent.com/HiJwm/MySettings/main/25_storage.js

#更改个人设置test
wget -O ./package/default-settings/files/zzz-default-settings https://raw.githubusercontent.com/HiJwm/MySettings/main/Lienol-zzz-default-settings









