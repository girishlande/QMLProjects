#include "pointgenerator.h"
#include <qlineseries.h>
#include <QTimer>
#include <qdebug.h>
#include <waveformreader.h>
#include "worker.h"
#include <qthread.h>

PointGenerator::PointGenerator(QObject *parent) : QObject(parent)
{
    m_counter = 0;
}

void PointGenerator::setSeries(QAbstractSeries* s1,QAbstractSeries* s2) {
    QThread* thread = new QThread();
    Worker* worker = new Worker((int)m_type,s1,s2,m_xMin,m_xMax,m_yMin,m_yMax);
    worker->moveToThread(thread);
    connect(thread, SIGNAL (started()), worker, SLOT (process()));
    connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
    connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
    connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
    thread->start();
}

void PointGenerator::reset()
{

}

int PointGenerator::xMin()
{
    return m_xMin;
}

void PointGenerator::setXMin(int xmin)
{
    if (m_xMin != xmin) {
        m_xMin = xmin;
        emit xMinChanged();
    }
}

int PointGenerator::xMax()
{
    return m_xMax;
}

void PointGenerator::setXMax(int xmax) {
    if (m_xMax!=xmax) {
        m_xMax = xmax;
        emit xMaxChanged();
    }
}

int PointGenerator::yMin()
{
    return m_yMin;
}

void PointGenerator::setYMin(int ymin)
{
    if (m_yMin != ymin) {
        m_yMin = ymin;
        emit yMinChanged();
    }
}

int PointGenerator::yMax()
{
    return m_yMax;
}

void PointGenerator::setYMax(int ymax)
{
    if (m_yMax != ymax) {
        m_yMax = ymax;
        emit yMaxChanged();
    }
}

int PointGenerator::timerDelay()
{
    return m_timerdelay;
}

void PointGenerator::setTimerDelay(int timer)
{
    if (m_timerdelay!=timer) {
        m_timerdelay = timer;
        emit timerDelayChanged();
    }
}

PointGenerator::WaveType PointGenerator::wavetype()
{
    return m_type;
}

void PointGenerator::setWaveType(PointGenerator::WaveType type)
{
    if (m_type!=type) {
        m_type = type;
        emit wavetypeChanged();
    }
}




