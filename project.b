default [
    include_from [
        %src
        %src/platform
        %extlib/eigen
    ]
    win32 [
        ; Fedora rpms:
        ;   mingw64-angleproject-static
        ;   mingw64-freetype-static
        ;   mingw64-libpng-static
        include_from [
            %extlib/angle/include
            %extlib/mimalloc/include
        ]
        cxxflags "-D_USE_MATH_DEFINES -DWIN32"
    ]
    cxxflags "-fpermissive -Wno-unused-parameter -Wno-deprecated-copy"
    if ne? qt-version 6 [
        cxxflags "-std=c++11"
    ]
]

ifn exists? %src/config.h [
    write %src/config.h {{
    #ifndef SOLVESPACE_CONFIG_H
    #define SOLVESPACE_CONFIG_H
    #define PACKAGE_VERSION "3.1~"
    #define GIT_HASH_URL "https://github.com/solvespace/solvespace/commit/"
    /* Non-OS X *nix only */
    #define UNIX_DATADIR "/usr/local/share/solvespace"
    /* What OpenGL version do we use? */
    #define HAVE_OPENGL 3
    #endif
    }}
]

lib %dxfrw [
    include_from [
        %extlib/libdxfrw
        %extlib/libdxfrw/intern
    ]
    sources_from %extlib/libdxfrw %.cpp
    sources_from %extlib/libdxfrw/intern %.cpp
]

lib %slvs [
    include_from [
        %include
    ]
    sources_from %src [
        %util.cpp
        %entity.cpp
        %expr.cpp
        %constraint.cpp
        %constrainteq.cpp
        %system.cpp
        %lib.cpp
    ]
]

lib %solvespace-core [
    include_from %extlib/libdxfrw
    linux [
        include_from %/usr/include/freetype2
    ]
    win32 [
        include_from %/usr/x86_64-w64-mingw32/sys-root/mingw/include/freetype2
    ]
    sources_from %src [
        %bsp.cpp
        %clipboard.cpp
        %confscreen.cpp
        %constraint.cpp
        %constrainteq.cpp
        %describescreen.cpp
        %draw.cpp
        %drawconstraint.cpp
        %drawentity.cpp
        %entity.cpp
        %export.cpp
        %exportstep.cpp
        %exportvector.cpp
        %expr.cpp
        %file.cpp
        %generate.cpp
        %graphicswin.cpp
        %group.cpp
        %groupmesh.cpp
        %importdxf.cpp
        %importidf.cpp
        %importmesh.cpp
        %mesh.cpp
        %modify.cpp
        %mouse.cpp
        %polyline.cpp
        %polygon.cpp
        %resource.cpp
        %request.cpp
        %style.cpp
        %system.cpp
        %textscreens.cpp
        %textwin.cpp
        %toolbar.cpp
        %ttf.cpp
        %undoredo.cpp
        %util.cpp
        %view.cpp
        %platform/platform.cpp
        %platform/gui.cpp
        %render/render.cpp
        %srf/boolean.cpp
        %srf/curve.cpp
        %srf/merge.cpp
        %srf/ratpoly.cpp
        %srf/raycast.cpp
        %srf/shell.cpp
        %srf/surface.cpp
        %srf/surfinter.cpp
        %srf/triangulate.cpp
    ]
]

exe %solvespace-qt [
    either eq? qt-version 6 [
        qt [widgets openglwidgets]
    ][
        qt [widgets opengl]
    ]
    opengl
    libs_from %. [%solvespace-core %slvs %dxfrw]
    linux [
        libs [%mimalloc %freetype %png %z]
    ]
    win32 [
        libs_from %extlib/mimalloc [%mimalloc %bcrypt]
        libs [%EGL %GLESv2 %freetype %png %z]
        sources [%res/resources.rc]
    ]
    sources_from %src [
        %solvespace.cpp
        %platform/guiqt.cpp
        %render/gl3shader.cpp
        %render/rendergl3.cpp
    ]
]
