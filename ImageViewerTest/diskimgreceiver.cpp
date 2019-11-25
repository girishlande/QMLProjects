#include "diskimgreceiver.h"
#include "qtimer.h"
#include "qdebug.h"

DiskImgReceiver::DiskImgReceiver()
{
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(processImage()));
    timer->start(100);
}

QPixmap DiskImgReceiver::getCurrentImage()
{
    m_counter++;
    if (m_counter==196)
        m_counter=83;
    int count = 3000 + m_counter;
    QString path(":/images/IMG_"+QString::number(count)+".jpg");
    QPixmap pixmap(path);

    return pixmap;
}

