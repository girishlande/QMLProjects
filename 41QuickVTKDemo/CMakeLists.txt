cmake_minimum_required(VERSION 2.8.11)

project(VtkFboInQtQuick)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(VTK REQUIRED)
if (VTK_FOUND) 
  message("Found VTK")
else()
  message("VTK not found")
endif()

include(${VTK_USE_FILE})

SET (${PROJECT_NAME}_QT_MODULES Core Gui OpenGL Qml Quick)
FIND_PACKAGE(Qt5 REQUIRED QUIET COMPONENTS ${${PROJECT_NAME}_QT_MODULES})
if (Qt5_FOUND) 
  message("QT5 found!")
else()
  message("QT5 NOT found!")
endif()

#find_package(Qt5Quick REQUIRED)
#if (Qt5Quick_FOUND) 
#  message("Found Qt quick")
#else()
#  message("Qt5Quick not found")
#endif()

configure_file(VtkFboInQtQuickConfig.h.in ${PROJECT_BINARY_DIR}/VtkFboInQtQuickConfig.h)

add_executable(${PROJECT_NAME} 
  main.cpp
  QVTKFramebufferObjectItem.cpp
  main.qml
)
target_link_libraries(${PROJECT_NAME} ${VTK_LIBRARIES} Qt5::Quick)
