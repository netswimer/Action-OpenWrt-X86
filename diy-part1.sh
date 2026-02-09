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

#单独拉取luci-v2ray-server
mkdir -p feeds/kiddin9-single/luci-app-v2ray-server
# 用 sparse checkout 只拉取需要的子目录（高效，只下这个包）
git clone --filter=blob:none --no-checkout --depth=1 https://github.com/kiddin9/kwrt-packages.git feeds/kiddin9-single/tmp-repo
cd feeds/kiddin9-single/tmp-repo
git sparse-checkout init --cone
git sparse-checkout set luci-app-v2ray-server
git checkout
cd ../../..

# 移动包目录到 feed 根下（OpenWrt 期望的结构）
mv feeds/kiddin9-single/tmp-repo/luci-app-v2ray-server feeds/kiddin9-single/
rm -rf feeds/kiddin9-single/tmp-repo  # 清理临时文件

# 在 feeds.conf.default 追加 src-link（本地链接方式）
sed -i "3i src-link kiddin9-single \$(TOPDIR)/feeds/kiddin9-single"  feeds.conf.default

# 更新 feeds（因为是 link，不需要网络 update，但运行一下确保索引）
./scripts/feeds update kiddin9-single

# 安装这个包（让 menuconfig / defconfig 能识别）
./scripts/feeds install luci-app-v2ray-server

  
