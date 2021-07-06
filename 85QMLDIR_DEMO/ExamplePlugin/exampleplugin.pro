TEMPLATE = lib
CONFIG += qt plugin c++11
QT += qml quick

DESTDIR = ../ExamplePlugin
TARGET = $$qtLibraryTarget(ExamplePlugin)

HEADERS += \
    ExamplePlugin.h \
    Patient.h \
    PatientModel.h \
    PatientProvider.h

SOURCES += \
    ExamplePlugin.cpp \
    Patient.cpp \
    PatientModel.cpp \
    PatientProvider.cpp

DESTPATH=../../
target.path=$$DESTPATH
qmldir.files=$$PWD/qmldir
qmldir.path=$$DESTPATH
INSTALLS += target qmldir

OTHER_FILES += qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)

DISTFILES +=

RESOURCES += \
    resources.qrc

