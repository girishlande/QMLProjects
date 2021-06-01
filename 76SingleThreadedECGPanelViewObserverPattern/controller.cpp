#include "controller.h"
#include "pointrecorder.h"
#include <qtimer.h>

Controller::Controller(QObject *parent) : QObject(parent)
{
    PointRecorder::getInstance().StartRecordingPoints();
    QTimer* m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &Controller::timeOut);
    m_timer->setInterval(10);
    m_timer->start();
}

void Controller::timeOut()
{
    PointRecorder::getInstance().addOnePoint();
}
