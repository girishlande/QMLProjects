#include "VtkFboInQtQuickConfig.h"
#include "QVTKFramebufferObjectItem.h"

#include <vtkActor.h>
#include <vtkConeSource.h>
#include <vtkPolyDataMapper.h>
#include <vtkGenericOpenGLRenderWindow.h>
#include <vtkRenderer.h>
#include <vtkSmartPointer.h>
#include <vtkRendererCollection.h>
#include <vtkCamera.h>
#include <vtkProperty.h>

#include <QGuiApplication>
#include <QQuickView>
#include <QList>

int main(int argc, char **argv)
{
   QGuiApplication app(argc, argv);

   qmlRegisterType<QVTKFrameBufferObjectItem>("VtkQuick", 1, 0, "VtkRenderWindow");

   QQuickView view;
   view.setSource(QUrl::fromLocalFile(PROJECT_SOURCE_DIR "/main.qml"));
   QList<QVTKFrameBufferObjectItem*> vtkItems = view.rootObject()->findChildren<QVTKFrameBufferObjectItem*>();

   // For demonstration: Add a cone to the scene of each QVTKFrameBufferObjectItem
   Q_FOREACH(QVTKFrameBufferObjectItem *vtkItem, vtkItems)
   {
      vtkGenericOpenGLRenderWindow *rw = vtkItem->GetRenderWindow();
      // Create a renderer and add it to the render window
      vtkSmartPointer<vtkRenderer> renderer = vtkSmartPointer<vtkRenderer>::New();
      rw->AddRenderer(renderer);

      vtkSmartPointer<vtkConeSource> polyDataSource = vtkSmartPointer<vtkConeSource>::New();
      vtkSmartPointer<vtkPolyDataMapper> mapper = vtkSmartPointer<vtkPolyDataMapper>::New();
      vtkSmartPointer<vtkActor> actor = vtkSmartPointer<vtkActor>::New();
      mapper->SetInputConnection(polyDataSource->GetOutputPort());
      actor->SetMapper(mapper);
      actor->GetProperty()->SetOpacity(0.5); // demonstrate support for translucent VTK objects
      renderer->AddActor(actor);
   }

   view.setResizeMode( QQuickView::SizeRootObjectToView );
   view.show();

   return app.exec();
}
