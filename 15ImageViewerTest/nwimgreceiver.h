#ifndef NWIMGRECEIVER_H
#define NWIMGRECEIVER_H

#include "imgreceiver.h"

class NWImgReceiver : public ImgReceiver
{
public:
    NWImgReceiver();
    QPixmap getCurrentImage();
};

#endif // NWIMGRECEIVER_H
