#include "imgreceiver.h"
const int DEFAULT_IMAGE_WIDTH = 640;
const int DEFAULT_IMAGE_HEIGHT = 480;

ImgReceiver::ImgReceiver(QObject *parent) : QObject(parent)
  ,m_width(DEFAULT_IMAGE_WIDTH)
  ,m_height(DEFAULT_IMAGE_HEIGHT)
{

}


int ImgReceiver::width()
{
    return m_width;
}

int ImgReceiver::height()
{
    return m_height;
}


void ImgReceiver::processImage()
{
    emit imageReady();
}
