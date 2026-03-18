#!/bin/bash
set -ex

# Fix for GCC 11+ compatibility in gold
sed -i 's/#include "gold-threads.h"/#include <string>\n#include "gold-threads.h"/' gold/errors.h

export CXXFLAGS="${CXXFLAGS} -Wno-narrowing"

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
