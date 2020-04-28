#include "mainwindow.h"
#include <QApplication>
#include <vtkAutoInit.h>
 VTK_MODULE_INIT(vtkRenderingOpenGL2)
 VTK_MODULE_INIT(vtkRenderingFreeType)


#include <vtkObject.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    vtkObject::GlobalWarningDisplayOff();

    MainWindow w;
    w.show();

    return a.exec();
}
