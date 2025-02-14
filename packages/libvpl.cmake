ExternalProject_Add(libvpl
    GIT_REPOSITORY https://github.com/intel/libvpl.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_DISPATCHER=ON
        -DBUILD_DEV=ON
        -DBUILD_PREVIEW=OFF
        -DBUILD_TOOLS=OFF
        -DBUILD_TOOLS_ONEVPL_EXPERIMENTAL=OFF
        -DINSTALL_EXAMPLE_CODE=OFF
        -DBUILD_TESTS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libvpl)
cleanup(libvpl install)
