#!/bin/bash
#=================================================
# DIY script
# jsjson@163.com 
#=================================================


##补充汉化       
cp -f ./feeds/mypackages/patch/udpxy.lua ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi
##
echo -e "\nmsgid \"General\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"常规\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po

echo -e "\nmsgid \"LOG\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"日志\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
              
##配置ip等
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
sed -i 's/192.168.1.1/192.168.2.99/g' package/base-files/files/bin/config_generate

##替换K3无线驱动为69027
#rm -rf ./package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#svn export https://github.com/mypackages/Phicomm-K3_Wireless-Firmware/trunk/brcmfmac4366c-pcie.bin_69027 ./package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin


##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci-nginx/Makefile

##替换theme icons
wget -O ./feeds/mypackages/theme/luci-theme-argon-18.06/htdocs/luci-static/argon/img/bg1.jpg https://github.com/HiJwm/MySettings/raw/main/BackGround/2.jpg
svn co https://github.com/xylz0928/luci-mod/trunk/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons ./package/lucimod
mv package/lucimod/* feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/


##切换为samba4
sed -i 's/luci-app-samba/luci-app-samba4/g' package/lean/autosamba/Makefile



##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt '/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION='$(date +%Y%m%d) '/g" package/lean/default-settings/files/zzz-default-settings  #默认openwrt版本号目前R22.5.5 
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-$(date +%Y%m%d) by HiJwm @'/g" package/lean/default-settings/files/zzz-default-settings #编译文件中添加，这个就无效了

##更改主机名
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

##修改autocore
rm -rf ./package/lean/autocore
#rm -rf ./feeds/mypackages/patch/autocore
#svn export https://github.com/HiJwm/MySettings/trunk/lean/myautocore feeds/mypackages/patch/autocore
##修改概述内容 上述已经修改，本条无意义
#wget -O ./feeds/mypackages/patch/autocore/files/x86/index.htm https://raw.githubusercontent.com/HiJwm/MySettings/main/lean/index.htm

##更换adguardhome为sirboy源 
#rm -rf ./feeds/mypackages/luci-app-adguardhome
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-adguardhome ./package/luci-app-adguardhome
#chmod -R 755 ./package/luci-app-adguardhome/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/adguardhome ./package/adguardhome
#chmod -R 755 ./package/adguardhome/*

##FQ全部调到VPN菜单
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-passwall/luasrc/view/passwall/server/*.htm

sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-vssr/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-vssr/luasrc/view/vssr/*.htm

sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-openclash/luasrc/view/openclash/*.htm

sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-bypass/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
sed -i 's/services/vpn/g' package/feeds/mypackages/luci-app-bypass/luasrc/view/bypass/*.htm


sed -i '/option Interface/d'  package/network/services/dropbear/files/dropbear.config
