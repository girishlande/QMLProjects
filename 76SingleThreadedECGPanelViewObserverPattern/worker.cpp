#include "worker.h"
#include <qdebug.h>
#include <QMutexLocker>
#include <qtimer.h>

#include <pointrecorder.h>

Worker::Worker(QObject *parent) : QObject(parent)
{

}

Worker::Worker(int type,QAbstractSeries* s1,QAbstractSeries* s2,int xmin,int xmax,int ymin,int ymax)
    :m_xMin(xmin),m_xMax(xmax),m_yMin(ymin),m_yMax(ymax) {
    m_type = (WaveformType)type;
    m_lineSeries1 = (QLineSeries*)s1;
    m_lineSeries2 = (QLineSeries*)s2;
    PointRecorder::getInstance().RegisterListener(this);

    CacheWaveformLimits();
}

Worker::~Worker() {
    PointRecorder::getInstance().UnRegisterListener(this);
}

WaveformType Worker::type()
{
    return m_type;
}

void Worker::AddPoint(XY position)
{
    m_x = position.x;
    m_y = position.y;
    AddPointsToWave();
}

void Worker::AddPointsToWave() {
    QMutexLocker ml(&mMutex);
    QLineSeries* current = m_lineSeries1;
    QLineSeries* prev = m_lineSeries2;
    if (!m_firstWave) {
        current = m_lineSeries2;
        prev = m_lineSeries1;
    }

    AddWaveformPoint(prev,current);
}

void Worker::CacheWaveformLimits()
{
    WaveformData& data = PointRecorder::getInstance().GetWaveformData(m_type);
    m_wminX = data.minX();
    m_wmaxX = data.maxX();
    m_wminY = data.minY();
    m_wmaxY = data.maxY();
}


void Worker::AddWaveformPoint(QLineSeries* prev,QLineSeries* current) {

    float ex = m_x;
    float ey = m_y;

    float offset = ex - m_baseX;
    if (offset > m_xMax) {
        m_firstWave = !m_firstWave;
        m_baseX = ex;
        offset = 0;
        if (!m_firstWave) {
            current = m_lineSeries2;
            prev = m_lineSeries1;
        } else {
            current = m_lineSeries1;
            prev = m_lineSeries2;
        }
        current->clear();
    }

    int ydiff1 = m_wmaxY - m_wminY;
    int ydiff2 = m_yMax - m_yMin;
    float d1 = ey - m_wminY;
    float d2 = (d1*ydiff2)/ydiff1;
    float targetYpos = m_yMin + d2;

    if (prev->count()>0)
        prev->remove(0);

    current->append(offset,targetYpos);
}
