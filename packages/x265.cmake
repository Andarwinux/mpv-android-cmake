ExternalProject_Add(x265
    GIT_REPOSITORY https://github.com/shinchiro/x265.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/source -B<BINARY_DIR>
        ${cmake_conf_args}
        -DMAIN12=ON
        -DHIGH_BIT_DEPTH=ON
        -DENABLE_HDR10_PLUS=ON
        -DENABLE_LIBVMAF=OFF
        -DHIGH_BIT_DEPTH=ON
        -DENABLE_SHARED=OFF
        -DENABLE_CLI=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(x265)
cleanup(x265 install)
