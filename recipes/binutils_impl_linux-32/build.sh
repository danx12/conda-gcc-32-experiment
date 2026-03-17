#!/bin/bash
set -ex

./configure \
    --prefix=${PREFIX} \
    --target=i686-conda_ubuntu-linux-gnu \
    --with-sysroot=${PREFIX}/i686-conda_ubuntu-linux-gnu/sysroot \
    --disable-multilib \
    --disable-werror \
    --enable-gold \
    --enable-plugins \
    --enable-threads

make -j${CPU_COUNT}
make install
