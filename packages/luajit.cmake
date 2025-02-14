configure_file(${CMAKE_CURRENT_SOURCE_DIR}/luajit.pc.in ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc @ONLY)
ExternalProject_Add(luajit
    DEPENDS
        libiconv
    GIT_REPOSITORY https://github.com/Wohlsoft/LuaJIT.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_REMOTE_NAME origin
    GIT_TAG v2.1
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DCMAKE_CROSSCOMPILING=ON
        -DCMAKE_UNITY_BUILD=ON
        -DUNITY_BUILD_BATCH_SIZE=0
        -DCMAKE_UNITY_BUILD_BATCH_SIZE=0
        -DLUAJIT_BUILD_TOOL=OFF
        -DLJ_ENABLE_LARGEFILE=ON
        -DCMAKE_SYSTEM_VERSION=10
        -DLUAJIT_FORCE_UTF8_FOPEN=ON
        -DCMAKE_C_FLAGS='-DLUAJIT_ENABLE_LUA52COMPAT'
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND bash -c "cp ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc ${PACKAGES_INSTALL_PREFIX}/lib/pkgconfig/luajit.pc"
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(luajit)
cleanup(luajit install)
