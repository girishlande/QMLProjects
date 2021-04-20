# Integrating VTK into Qt Quick 2
https://gist.github.com/nocnokneo/c3fb01bb7ecaf437f7d6

This is a minimal proof-of-concept attempt at integrating VTK into a Qt Quick
scene by rendering VTK to an OpenGL Framebuffer Object (FBO) and displaying
that FBO in the QSG as a texture. This is a more robust integration approach
than using the QSG beforeRendering or afterRendering signals (for example, as
used by [OpenView Core](https://github.com/Kitware/openview/tree/master/core))

## Build Instructions

Requires Qt 5.2 or greater. Tested configurations:

 * RHEL6, VTK 5.10, Qt 5.2.1
 * Ubuntu 12.04, VTK 6.1, Qt 5.3.0
 * Mac OS 10.9,VTK 6.1, Qt 5.2.1

```Shell
git clone https://gist.github.com/c3fb01bb7ecaf437f7d6.git VtkFboInQtQuick
mkdir VtkFboInQtQuick-build
cd VtkFboInQtQuick-build

# may need to add: -DVTK_DIR:PATH=<VTK_DIR> where <VTK_DIR> is the
# path to the directory that contains VTKConfig.cmake
cmake ../VtkFboInQtQuick

make
./VtkFboInQtQuick
```
