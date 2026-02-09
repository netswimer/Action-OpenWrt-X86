#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git kenzok8 https://github.com/kenzok8/small-package.git;main' >>feeds.conf.default
echo 'src-git kenzok8d https://github.com/kenzok8/small.git;master' >>feeds.conf.default
echo 'src-git cups https://github.com/Gr4ffy/lede-cups.git' >>feeds.conf.default
sed -i '1i src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main'  feeds.conf.default
sed -i '2i src-git passwall2d https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '3i src-git kiddin9 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
src-git  https://github.com/kiddin9/kwrt-packages

  
