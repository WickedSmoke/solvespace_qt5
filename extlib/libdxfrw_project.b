lib %dxfrw [
  include_from [%. %intern]
  sources [
    %intern/drw_dbg.cpp
    %intern/drw_textcodec.cpp
    %intern/dwgbuffer.cpp
    %intern/dwgreader15.cpp
    %intern/dwgreader18.cpp
    %intern/dwgreader21.cpp
    %intern/dwgreader24.cpp
    %intern/dwgreader27.cpp
    %intern/dwgreader.cpp
    %intern/dwgutil.cpp
    %intern/dxfreader.cpp
    %intern/dxfwriter.cpp
    %intern/rscodec.cpp

    %drw_header.cpp
    %drw_classes.cpp
    %drw_entities.cpp
    %drw_objects.cpp
    %libdxfrw.cpp

    %libdwgr.cpp
  ]
]
