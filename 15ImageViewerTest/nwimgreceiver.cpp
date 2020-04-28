#include "nwimgreceiver.h"
#include "qpixmap.h"
#include "qguiapplication.h"
#include "qscreen.h"
#include "qtimer.h"

const int CAPTURE_WIDTH = 640;
const int CAPTURE_HEIGHT = 480;

NWImgReceiver::NWImgReceiver()
{
    m_width = CAPTURE_WIDTH;
    m_height = CAPTURE_HEIGHT;

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(processImage()));
    timer->start(100);
}

QPixmap NWImgReceiver::getCurrentImage()
{
    QScreen *screen = QGuiApplication::primaryScreen();
    if (screen) {
        return screen->grabWindow(0,0,0, CAPTURE_WIDTH,CAPTURE_HEIGHT);
    }

    // TODO read images from network stream asynchronously
    return QPixmap();
}
