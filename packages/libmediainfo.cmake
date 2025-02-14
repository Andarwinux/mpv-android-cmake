ExternalProject_Add(libmediainfo
    DEPENDS
        zlib
        zenlib
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfoLib.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=FALSE
        "-DCMAKE_CXX_FLAGS='-DMEDIAINFO_LIBCURL_NO'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libmediainfo)
cleanup(libmediainfo install)
