@echo off
setlocal 

set mode=release

set arg=%1
if [%arg%]==[] (
  echo pass argument for which build to create [debug / release]
  exit /b 0
) 

if [%arg%]==[debug] (
  set mode=debug
  goto :main
)

if [%arg%]==[release] (
  set mode=release
) else (
  echo only [debug/release] is valid mode 
  exit /b 0
)


:main
set destdir=build\%mode%
set sourceFolder=%mode%

echo Copying dlls for %destdir%

robocopy /NFL /NDL /NJH /NJS /nc /ns /np C:\Qt\Qt5.14.2\5.14.2\msvc2017_64\bin\ %destdir% *.dll
robocopy /NFL /NDL /NJH /NJS /nc /ns /np /mir "C:\Qt\Qt5.14.2\5.14.2\msvc2017_64\plugins\platforms" %destdir%\platforms
robocopy /NFL /NDL /NJH /NJS /nc /ns /np D:\repos\vtk_release\build_release\bin\%sourceFolder%\ %destdir% *.dll
