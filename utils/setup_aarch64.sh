#!/bin/sh
cmake -DTARGET_ARCH=aarch64-w64-mingw32 \
-DGCC_ARCH=cortex-a76 \
-DM_TUNE=cortex-a76 \
-DSINGLE_SOURCE_LOCATION="/build/src_packages" \
-DRUSTUP_LOCATION="/build/install_rustup" \
-DCMAKE_INSTALL_PREFIX="/build/install" \
-DPACKAGES_INSTALL_PREFIX="/build_aarch64/install/aarch64-w64-mingw32" \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DCLANG_PACKAGES_LTO=ON \
-G Ninja \
-B /build_aarch64
