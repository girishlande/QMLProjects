#-------------------------------------------------
#
# Project created by QtCreator 2016-12-14T16:57:14
#
#-------------------------------------------------

QT       += qml quick core gui widgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = s8
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    dicominteractionstyle.h \
    modelinteractionstyle.h

FORMS    += mainwindow.ui

FORMS    += mainwindow.ui

INCLUDEPATH += "D:/VTK/include/vtk-7.0/"

Debug:DESTDIR = "D:/VTK/bin"

LIBS+=-L"D:/VTK/lib" -lvtkRenderingCore-7.0

LIBS+=-L"D:/VTK/lib" -lvtkalglib-7.0
LIBS+=-L"D:/VTK/lib" -lvtkChartsCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonColor-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonComputationalGeometry-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonDataModel-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonExecutionModel-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonMath-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonMisc-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonSystem-7.0
LIBS+=-L"D:/VTK/lib" -lvtkCommonTransforms-7.0
LIBS+=-L"D:/VTK/lib" -lvtkDICOMParser-7.0
LIBS+=-L"D:/VTK/lib" -lvtkDomainsChemistry-7.0
LIBS+=-L"D:/VTK/lib" -lvtkDomainsChemistryOpenGL2-7.0
LIBS+=-L"D:/VTK/lib" -lvtkexoIIc-7.0
LIBS+=-L"D:/VTK/lib" -lvtkexpat-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersAMR-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersExtraction-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersFlowPaths-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersGeneral-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersGeneric-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersGeometry-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersHybrid-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersHyperTree-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersImaging-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersModeling-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersParallel-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersParallelImaging-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersProgrammable-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersSelection-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersSMP-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersSources-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersStatistics-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersTexture-7.0
LIBS+=-L"D:/VTK/lib" -lvtkFiltersVerdict-7.0
LIBS+=-L"D:/VTK/lib" -lvtkfreetype-7.0
LIBS+=-L"D:/VTK/lib" -lvtkGeovisCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkglew-7.0
LIBS+=-L"D:/VTK/lib" -lvtkGUISupportQt-7.0
LIBS+=-L"D:/VTK/lib" -lvtkGUISupportQtOpenGL-7.0
LIBS+=-L"D:/VTK/lib" -lvtkhdf5-7.0
LIBS+=-L"D:/VTK/lib" -lvtkhdf5_hl-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingColor-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingFourier-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingGeneral-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingHybrid-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingMath-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingMorphological-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingSources-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingStatistics-7.0
LIBS+=-L"D:/VTK/lib" -lvtkImagingStencil-7.0
LIBS+=-L"D:/VTK/lib" -lvtkInfovisCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkInfovisLayout-7.0
LIBS+=-L"D:/VTK/lib" -lvtkInteractionImage-7.0
LIBS+=-L"D:/VTK/lib" -lvtkInteractionStyle-7.0
LIBS+=-L"D:/VTK/lib" -lvtkInteractionWidgets-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOAMR-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOEnSight-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOExodus-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOExport-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOGeometry-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOImage-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOImport-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOInfovis-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOLegacy-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOLSDyna-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOMINC-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOMovie-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIONetCDF-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOParallel-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOParallelXML-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOPLY-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOSQL-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOVideo-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOXML-7.0
LIBS+=-L"D:/VTK/lib" -lvtkIOXMLParser-7.0
LIBS+=-L"D:/VTK/lib" -lvtkjpeg-7.0
LIBS+=-L"D:/VTK/lib" -lvtkjsoncpp-7.0
LIBS+=-L"D:/VTK/lib" -lvtklibxml2-7.0
LIBS+=-L"D:/VTK/lib" -lvtkLocalExample-7.0
LIBS+=-L"D:/VTK/lib" -lvtkmetaio-7.0
LIBS+=-L"D:/VTK/lib" -lvtkNetCDF-7.0
LIBS+=-L"D:/VTK/lib" -lvtkNetCDF_cxx-7.0
LIBS+=-L"D:/VTK/lib" -lvtkoggtheora-7.0
LIBS+=-L"D:/VTK/lib" -lvtkParallelCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkpng-7.0
LIBS+=-L"D:/VTK/lib" -lvtkproj4-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingAnnotation-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingContext2D-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingContextOpenGL2-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingFreeType-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingImage-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingLabel-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingLOD-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingOpenGL2-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingQt-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingVolume-7.0
LIBS+=-L"D:/VTK/lib" -lvtkRenderingVolumeOpenGL2-7.0
LIBS+=-L"D:/VTK/lib" -lvtksqlite-7.0
LIBS+=-L"D:/VTK/lib" -lvtksys-7.0
LIBS+=-L"D:/VTK/lib" -lvtktiff-7.0
LIBS+=-L"D:/VTK/lib" -lvtkverdict-7.0
LIBS+=-L"D:/VTK/lib" -lvtkViewsContext2D-7.0
LIBS+=-L"D:/VTK/lib" -lvtkViewsCore-7.0
LIBS+=-L"D:/VTK/lib" -lvtkViewsInfovis-7.0
LIBS+=-L"D:/VTK/lib" -lvtkViewsQt-7.0
LIBS+=-L"D:/VTK/lib" -lvtkzlib-7.0

RESOURCES += \
    resource.qrc

