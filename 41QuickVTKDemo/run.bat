#set QT5_DIR=C:/Qt/Qt5.14.2/5.14.2/msvc2017_64
set QT5_DIR=C:/dev/Packages/hologic.qt.bin.5.12.2
set VTK_DIR=C:/Program Files (x86)/VTK
PATH=%QT5_DIR%/bin/;%VTK_DIR%/bin;%PATH%
set QML_FORCE_THREADED_RENDERER="1"
"build/VtkFboInQtQuick.sln"