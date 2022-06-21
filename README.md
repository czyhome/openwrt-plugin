
# Ubuntu 20.04 install dependency
```bash
sudo apt update
sudo apt install build-essential gawk gcc-multilib flex git gettext libncurses5-dev libssl-dev python3-distutils zlib1g-dev

Reference: https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu
```

# Openwrt official build guide 
```bash
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git pull
git checkout v21.02.3

Reference: https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem
```

# Build
```bash
echo -e '\nsrc-git plugin https://github.com/czy21/openwrt-plugin' >> feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a

# use single thread when first build
nohup make -j1 V=s &

# multi thread
nohup make -j$(($(nproc) + 1)) V=s &

# view make log
tail -f nohup.out

# build output: bin/targets/<platform>/
```