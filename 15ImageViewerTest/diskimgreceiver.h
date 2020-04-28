#ifndef DISKIMGRECEIVER_H
#define DISKIMGRECEIVER_H

#include "imgreceiver.h"
#include "qpixmap.h"

class DiskImgReceiver : public ImgReceiver
{
public:
    DiskImgReceiver();
    QPixmap getCurrentImage();



private:
    int m_counter = 83;
};

#endif // DISKIMGRECEIVER_H
