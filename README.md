
# [Prerequisites](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu)

# [Build Usage ](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem)

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