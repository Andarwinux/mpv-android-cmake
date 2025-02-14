ExternalProject_Add(libsrt
    DEPENDS
        openssl
    GIT_REPOSITORY https://github.com/Haivision/srt.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DENABLE_STDCXX_SYNC=ON
        -DENABLE_APPS=OFF
        -DENABLE_SHARED=OFF
        -DUSE_ENCLIB=openssl
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libsrt)
cleanup(libsrt install)
