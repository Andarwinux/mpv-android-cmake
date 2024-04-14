set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")
set(vapoursynth_manual_install_copy_lib COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VSScript.lib ${PACKAGES_INSTALL_PREFIX}/lib/VSScript.lib
                                        COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VapourSynth.lib ${PACKAGES_INSTALL_PREFIX}/lib/VapourSynth.lib)
set(ffmpeg_extra_libs "-lc++_shared -lc++abi -lunwind")
set(ffmpeg_hardcoded_tables "--enable-hardcoded-tables")
set(mpv_lto_mode "-Db_lto_mode=thin")
set(mpv_copy_debug COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/mpv.pdb
                   COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/libmpv-2.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/libmpv-2.pdb)
#set(rust_target "gnullvm")
if(CLANG_PACKAGES_LTO)
    if(TARGET_CPU STREQUAL "x86_64")
        set(rust_cfi "-Zcf-protection=full")
    endif()
    set(cargo_lto_rustflags "CARGO_PROFILE_RELEASE_LTO=thin
                             RUSTFLAGS='-Ctarget-cpu=${GCC_ARCH} -Ccontrol-flow-guard=yes -Zehcont-guard=yes -Clinker-plugin-lto=yes -Ztls-model=local-exec -Cembed-bitcode=yes -Clto=thin -Cllvm-args=-fp-contract=fast -Zcombine-cgu=yes -Zinline-mir=yes -Zmir-opt-level=4 -Zthreads=${CPU_COUNT} ${rust_cfi}'")
    set(ffmpeg_lto "--enable-lto=thin")
    if(NOT (GCC_ARCH_HAS_AVX OR (TARGET_CPU STREQUAL "aarch64")))
        set(zlib_nlto "LTO=0")
    endif()
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
    set(vulkan_asm "-DUSE_GAS=ON")
    set(openssl_target "mingw64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "x86_64-win64-gcc")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1 -DXXH_ENABLE_AUTOVECTORIZE=1")
    set(nvcodec-headers "nvcodec-headers")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc --disable-ptx-compression")
elseif(TARGET_CPU STREQUAL "i686")
    set(dlltool_image "i386")
    set(vulkan_asm "-DUSE_MASM=OFF")
    set(openssl_target "mingw")
    set(libvpx_target "x86-win32-gcc")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1")
    set(nvcodec-headers "nvcodec-headers")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc --disable-ptx-compression")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
    set(vulkan_asm "-DUSE_GAS=ON")
    set(openssl_target "mingw-arm64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "arm64-win64-gcc")
    set(mpv_gl "-Dgl=disabled -Degl-angle=disabled")
    set(xz_crc "-DHAVE_ARM64_CRC32=ON -DALLOW_ARM64_CRC32=ON")
    set(aom_sve "-DENABLE_SVE=OFF -DENABLE_SVE2=OFF")
endif()

set(cmake_conf_args
    -GNinja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_INSTALL_PREFIX=${PACKAGES_INSTALL_PREFIX}
    -DBUILD_SHARED_LIBS=OFF
)
set(meson_conf_args
    --prefix=${PACKAGES_INSTALL_PREFIX}
    --libdir=${PACKAGES_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
)
set(autotools_conf_args
    --host=${TARGET_ARCH}
    --prefix=${PACKAGES_INSTALL_PREFIX}
    --disable-shared
    --enable-static
)
