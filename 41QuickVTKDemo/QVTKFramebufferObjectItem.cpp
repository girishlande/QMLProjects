#include "QVTKFramebufferObjectItem.h"

// Use the OpenGL API abstraction from Qt instead of from VTK because vtkgl.h
// and other Qt OpenGL-related headers do not play nice when included in the
// same compilation unit
#include <QOpenGLFunctions>

#include <QQuickFramebufferObject>
#include <QOpenGLFramebufferObject>

#include <vtkGenericOpenGLRenderWindow.h>
#include <vtkObjectFactory.h>

#include <vtkRendererCollection.h>
#include <vtkCamera.h>

class QVTKFramebufferObjectRenderer;

class vtkInternalOpenGLRenderWindow : public vtkGenericOpenGLRenderWindow, protected QOpenGLFunctions
{
public:
  static vtkInternalOpenGLRenderWindow* New();
  vtkTypeMacro(vtkInternalOpenGLRenderWindow, vtkGenericOpenGLRenderWindow)

  virtual void OpenGLInitState()
  {
     Superclass::OpenGLInitState();

     // Before any of the gl* functions in QOpenGLFunctions are called for a
     // given OpenGL context, an initialization must be run within that context
     this->MakeCurrent();
     initializeOpenGLFunctions();

     glUseProgram(0); // Shouldn't Superclass::OpenGLInitState() handle this?
     glDisable(GL_DEPTH_TEST); // depth buffer fighting between the cone and the backround without this
     glDisable(GL_BLEND);      // doesn't seem crucial (?) but it is one of the differnces that showed up in apitrace analysis
  }

  // Override to use deferred rendering - Tell the QSG that we need to
  // be rendered which will then, at the appropriate time, call
  // InternalRender to do the actual OpenGL rendering.
  virtual void Render();

  // Do the actual OpenGL rendering
  void InternalRender()
  {
     Superclass::Render();
  }

  // Provides a convenient way to set the protected FBO ivars from an existing
  // FBO that was created and owned by Qt's FBO abstraction class
  // QOpenGLFramebufferObject
  void SetFramebufferObject(QOpenGLFramebufferObject *fbo);

  QVTKFramebufferObjectRenderer *QtParentRenderer;

protected:
  vtkInternalOpenGLRenderWindow() :
     QtParentRenderer(0)
  {
  }

  ~vtkInternalOpenGLRenderWindow()
  {
     // Prevent superclass destructors from destroying the framebuffer object.
     // QOpenGLFramebufferObject owns the FBO and manages it's lifecyle.
     this->OffScreenRendering = 0;
  }
};
vtkStandardNewMacro(vtkInternalOpenGLRenderWindow);


class QVTKFramebufferObjectRenderer : public QQuickFramebufferObject::Renderer
{
   friend class vtkInternalOpenGLRenderWindow;

public:
   QVTKFramebufferObjectRenderer(vtkInternalOpenGLRenderWindow *rw) :
      m_vtkRenderWindow(rw),
      m_framebufferObject(0)
   {
      m_vtkRenderWindow->Register(NULL);
      m_vtkRenderWindow->QtParentRenderer = this;
   }

   ~QVTKFramebufferObjectRenderer()
   {
      m_vtkRenderWindow->QtParentRenderer = 0;
      m_vtkRenderWindow->Delete();
   }

   virtual void synchronize(QQuickFramebufferObject * item)
   {
      // the first synchronize call - right before the the framebufferObject
      // is created for the first time
      if (!m_framebufferObject)
      {
         QVTKFrameBufferObjectItem *vtkItem = static_cast<QVTKFrameBufferObjectItem*>(item);
         vtkItem->init();
      }
   }

   // Called from the render thread when the GUI thread is NOT blocked
   virtual void render()
   {
      m_vtkRenderWindow->PushState();
      m_vtkRenderWindow->OpenGLInitState();
      m_vtkRenderWindow->InternalRender(); // vtkXOpenGLRenderWindow renders the scene to the FBO
      m_vtkRenderWindow->PopState();

      // Dolly camera back and forth - FOR DEMONSTRATION PURPOSES ONLY
      static int callCount = 0;
      ++callCount;
      double dolly = 1.0 + ((callCount % 200) > 100 ? -0.001 : 0.001);
      m_vtkRenderWindow->GetRenderers()->GetFirstRenderer()->GetActiveCamera()->Dolly(dolly);
      this->update();
   }

   QOpenGLFramebufferObject *createFramebufferObject(const QSize &size)
   {
      qDebug("QVTKFramebufferObjectRenderer::createFramebufferObject");
      QOpenGLFramebufferObjectFormat format;
      format.setAttachment(QOpenGLFramebufferObject::Depth);
      m_framebufferObject = new QOpenGLFramebufferObject(size, format);

      m_vtkRenderWindow->SetFramebufferObject(m_framebufferObject);

      return m_framebufferObject;
   }

   vtkInternalOpenGLRenderWindow *m_vtkRenderWindow;
   QOpenGLFramebufferObject *m_framebufferObject;
};

//
// vtkInternalOpenGLRenderWindow Definitions
//

void vtkInternalOpenGLRenderWindow::Render()
{
   if (this->QtParentRenderer)
   {
      this->QtParentRenderer->update();
   }
}

void vtkInternalOpenGLRenderWindow::SetFramebufferObject(QOpenGLFramebufferObject *fbo)
{
   // QOpenGLFramebufferObject documentation states that "The color render
   // buffer or texture will have the specified internal format, and will
   // be bound to the GL_COLOR_ATTACHMENT0 attachment in the framebuffer
   // object"
   this->BackLeftBuffer = this->FrontLeftBuffer = this->BackBuffer = this->FrontBuffer =
         static_cast<unsigned int>(GL_COLOR_ATTACHMENT0);

   // Save GL objects by static casting to standard C types. GL* types
   // are not allowed in VTK header files.
   QSize fboSize = fbo->size();
   this->Size[0] = fboSize.width();
   this->Size[1] = fboSize.height();
   this->NumberOfFrameBuffers = 1;
   this->FrameBufferObject       = static_cast<unsigned int>(fbo->handle());
   this->DepthRenderBufferObject = 0; // static_cast<unsigned int>(depthRenderBufferObject);
   this->TextureObjects[0]       = static_cast<unsigned int>(fbo->texture());
   this->OffScreenRendering = 1;
   this->OffScreenUseFrameBuffer = 1;
   this->Modified();
}

//
// QVTKFrameBufferObjectItem Definitions
//

QVTKFrameBufferObjectItem::QVTKFrameBufferObjectItem()
{
   m_win = vtkInternalOpenGLRenderWindow::New();
}

QVTKFrameBufferObjectItem::~QVTKFrameBufferObjectItem()
{
   m_win->Delete();
}

QQuickFramebufferObject::Renderer *QVTKFrameBufferObjectItem::createRenderer() const
{
   return new QVTKFramebufferObjectRenderer(static_cast<vtkInternalOpenGLRenderWindow*>(m_win));
}

vtkGenericOpenGLRenderWindow *QVTKFrameBufferObjectItem::GetRenderWindow() const
{
   return m_win;
}

void QVTKFrameBufferObjectItem::init()
{
   qDebug("QVTKFrameBufferObjectItem::init");
}
