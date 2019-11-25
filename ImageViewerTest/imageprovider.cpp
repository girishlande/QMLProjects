#include "imageprovider.h"

ImageProvider::ImageProvider()
    :QQuickImageProvider(Pixmap),
      m_receiver(nullptr)
{

}

ImageProvider::ImageProvider(ImgReceiver *imgreceiver)
    :QQuickImageProvider(Pixmap),
      m_receiver(imgreceiver)
{

}

QPixmap ImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    if (m_receiver) {
        return m_receiver->getCurrentImage();
    }
    return QPixmap();
}
