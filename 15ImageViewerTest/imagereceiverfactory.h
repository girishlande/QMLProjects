#ifndef IMAGERECEIVERFACTORY_H
#define IMAGERECEIVERFACTORY_H

#include "imgreceiver.h"
enum ImageReceiverTypes {
    DISKIMAGE,
    NETWORKIMAGE
};

class ImageReceiverFactory
{
public:

    ImageReceiverFactory();
    static ImgReceiver* getImageReceiver(ImageReceiverTypes type);

private:

};

#endif // IMAGERECEIVERFACTORY_H
