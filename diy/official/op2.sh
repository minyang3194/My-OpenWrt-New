#!/bin/bash
#=================================================
# DIY script
# jsjson@163.com 
#=================================================             

#设置默认时区
uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai



# Docker v20.10.15
rm -rf feeds/packages/utils/docker
rm -rf feeds/packages/utils/dockerd
rm -rf feeds/packages/utils/containerd
rm -rf feeds/packages/utils/runc
rm -rf feeds/packages/utils/libnetwork
svn export https://github.com/coolsnowwolf/packages/trunk/utils/docker feeds/packages/utils/docker
svn export https://github.com/coolsnowwolf/packages/trunk/utils/dockerd feeds/packages/utils/dockerd
svn export https://github.com/coolsnowwolf/packages/trunk/utils/containerd feeds/packages/utils/containerd
svn export https://github.com/coolsnowwolf/packages/trunk/utils/runc feeds/packages/utils/runc
svn export https://github.com/coolsnowwolf/packages/trunk/utils/libnetwork feeds/packages/utils/libnetwork

##配置IP
sed -i 's/192.168.1.1/192.168.2.99/g' package/base-files/files/bin/config_generate

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##替换theme icons
wget -O ./feeds/xiangfeidexiaohuo/jerrykuku/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/HiJwm/MySettings/raw/main/BackGround/2.jpg
svn co https://github.com/xylz0928/luci-mod/trunk/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons ./package/lucimod
mv package/lucimod/* feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/


##更改主机名
#sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate


##加入作者信息
#sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION='$(date +%Y%m%d) by HiJwm'/g" package/base-files/files/etc/openwrt_release #默认为openwrt版本号，无个人信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-$(date +%Y%m%d) by HiJwm'/g"  package/base-files/files/etc/openwrt_release #编译文件中添加，这个就无效了

##
svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-fs feeds/luci/libs/luci-lib-fs
ln -s ../../../feeds/luci/libs/luci-lib-fs package/feeds/xiangfeidexiaohuo/luci-lib-fs
#svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-filetransfer feeds/luci/applications/luci-app-filetransfer
#ln -s ../../../feeds/luci/applications/luci-app-filetransfer package/feeds/xiangfeidexiaohuo/luci-app-filetransfer


##
sed -i "53iLUCI_LANG.zh-cn=\$(LUCI_LANG.zh_Hans)" feeds/luci/luci.mk
sed -i "54iLUCI_LANG.zh-tw=\$(LUCI_LANG.zh_Hant)" feeds/luci/luci.mk

##
rm -rf package/feeds/luci/luci-app-dockerman
ln -s ../../../feeds/xiangfeidexiaohuo/lisaac/luci-app-dockerman package/feeds/luci/luci-app-dockerman

rm -rf feeds/xiangfeidexiaohuo/patch/autocore
#svn export https://github.com/Lienol/openwrt-package/branches/other/lean/autocore feeds/xiangfeidexiaohuo/patch/autocore 

rm -rf feeds/packages/utils/coremark 
#svn export https://github.com/coolsnowwolf/packages/trunk/utils/coremark feeds/packages/utils/coremark 

##添加adbybyplus插件
#svn export https://github.com/Lienol/openwrt-package/branches/other/lean/luci-app-adbyby-plus ./package/luci-app-adbyby-plus #无adbyby包
svn co https://github.com/Lienol/openwrt-package/branches/other/lean ./package/lean 
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-adbyby-plus ./package/luci-app-adbyby-plus 

##添加filetransert
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-filetransfer ./package/luci-app-filetransert

##FQ全部调到VPN菜单
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-passwall/luasrc/view/passwall/server/*.htm

sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-vssr/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-vssr/luasrc/view/vssr/*.htm

sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-openclash/luasrc/view/openclash/*.htm

sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-bypass/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
sed -i 's/services/vpn/g' package/feeds/xiangfeidexiaohuo/luci-app-bypass/luasrc/view/bypass/*.htm




