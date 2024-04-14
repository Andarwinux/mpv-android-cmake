ExternalProject_Add(sqlite
    URL https://www.sqlite.org/2024/sqlite-autoconf-3450200.tar.gz
    URL_HASH SHA3_256=1b02c58a711d15b50da8a1089e0f8807ebbdf3e674c714100eda9a03a69ac758
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && CONF=1 <SOURCE_DIR>/configure
        ${autotools_conf_args}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
