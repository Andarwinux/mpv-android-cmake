ExternalProject_Add(fontconfig
    DEPENDS
        expat
        freetype2
        zlib
        libiconv
    GIT_REPOSITORY https://gitlab.freedesktop.org/fontconfig/fontconfig.git
    SOURCE_DIR ${SOURCE_LOCATION}
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--filter=tree:0"
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Ddoc=disabled
        -Dtests=disabled
        -Dtools=disabled
        -Dcache-build=disabled
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(fontconfig)
force_meson_configure(fontconfig)
cleanup(fontconfig install)
