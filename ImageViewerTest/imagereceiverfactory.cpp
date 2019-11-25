#include "imagereceiverfactory.h"
#include "diskimgreceiver.h"
#include "nwimgreceiver.h"

ImageReceiverFactory::ImageReceiverFactory()
{

}

ImgReceiver *ImageReceiverFactory::getImageReceiver(ImageReceiverTypes type)
{
    ImgReceiver* receiver = nullptr;
    switch (type) {
    case DISKIMAGE:
        receiver = new DiskImgReceiver();
        break;
    case NETWORKIMAGE:
        receiver = new NWImgReceiver();
        break;
    }
    return receiver;
}
