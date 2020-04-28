#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H
#include "qquickimageprovider.h"
#include "imgreceiver.h"

class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider();
    ImageProvider(ImgReceiver *imgreceiver);
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

private:
    ImgReceiver* m_receiver;
};

#endif // IMAGEPROVIDER_H
