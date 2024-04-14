find_program(PKGCONFIG NAMES pkg-config)
ExternalProject_Add(llvm-wrapper
    DOWNLOAD_COMMAND ""
    SOURCE_DIR ${SOURCE_LOCATION}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${PKGCONFIG} ${CMAKE_INSTALL_PREFIX}/bin/${TARGET_ARCH}-pkg-config
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${PKGCONFIG} ${CMAKE_INSTALL_PREFIX}/bin/${TARGET_ARCH}-pkgconf
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${PKGCONFIG} ${CMAKE_INSTALL_PREFIX}/bin/pkg-config
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${PKGCONFIG} ${CMAKE_INSTALL_PREFIX}/bin/pkgconf
    INSTALL_COMMAND ""
    COMMENT "Setting up target directories and symlinks"
)

foreach(compiler clang++ g++ c++ clang gcc as)
    set(driver_mode "")
    set(clang_compiler "")
    set(linker "")
    
    if (compiler STREQUAL "g++" OR compiler STREQUAL "c++")
        set(driver_mode "--driver-mode=g++ -pthread")
        set(clang_compiler "clang++")
    elseif(compiler STREQUAL "clang++")
        set(driver_mode "--driver-mode=g++")
        set(clang_compiler "clang++")
        set(linker "-lc++abi")
    else()
        set(driver_mode "")
        set(clang_compiler "clang")
    endif()
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/llvm-compiler.in
                   ${CMAKE_INSTALL_PREFIX}/bin/${TARGET_ARCH}-${compiler}
                   FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
                   @ONLY)
endforeach()

if(TARGET_CPU STREQUAL "i686")
    set(ld_m_flag "i386pe")
elseif(TARGET_CPU STREQUAL "x86_64")
    set(ld_m_flag "i386pep")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(ld_m_flag "arm64pe")
endif()
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/llvm-ld.in
               ${CMAKE_INSTALL_PREFIX}/bin/${TARGET_ARCH}-ld
               FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
               @ONLY)

cleanup(llvm-wrapper install)
