#!/bin/bash
set -ex

# GCC recommends building in a separate directory
mkdir build && cd build

../configure \
    --prefix=${PREFIX} \
    --target=i686-conda_ubuntu-linux-gnu \
    --with-sysroot=${PREFIX}/i686-conda_ubuntu-linux-gnu/sysroot \
    --enable-languages=c,c++ \
    --disable-multilib \
    --disable-nls \
    --with-arch=i686 \
    --with-tune=generic \
    --enable-libstdcxx-time=yes \
    --enable-threads=posix \
    --enable-checker=release \
    --enable-clocale=gnu

make -j${CPU_COUNT}
make install-strip
