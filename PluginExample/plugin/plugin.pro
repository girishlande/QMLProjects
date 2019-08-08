#! [0]
TEMPLATE        = lib
CONFIG         += plugin
QT             += quick
INCLUDEPATH    += ../PluginExampleTrial
HEADERS         = timerplugin.h
SOURCES         = timerplugin.cpp
TARGET          = $$qtLibraryTarget(timerplugin)
DESTDIR         = ../plugins
#! [0]

EXAMPLE_FILES = timerplugin.json

# install
target.path = $$[QT_INSTALL_EXAMPLES]/widgets/tools/echoplugin/plugins
INSTALLS += target

CONFIG += install_ok  # Do not cargo-cult this!
