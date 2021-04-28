#include "pointgenerator.h"
#include <qlineseries.h>
#include <QTimer>
#include <qdebug.h>
#include <waveformreader.h>

PointGenerator::PointGenerator(QObject *parent) : QObject(parent)
{
    m_counter = 0;
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &PointGenerator::AddPointsToWave);
}

void PointGenerator::setSeries(QAbstractSeries* series1,QAbstractSeries* series2) {
    ReadWaveformPoints();
    m_lineSeries1 = (QLineSeries*)series1;
    m_lineSeries2 = (QLineSeries*)series2;
    m_timer->setInterval(m_timerdelay);
    m_timer->start();
}

void PointGenerator::setMaxXPoints(int xpoints)
{
    m_maxPoints = xpoints;
}

void PointGenerator::reset()
{
    m_timer->stop();
    m_lineSeries1->clear();
    m_lineSeries2->clear();
    m_counter = 0;
    m_pointCounter = -1;

    ReadWaveformPoints();
    m_timer->setInterval(m_timerdelay);
    m_timer->start();
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

void PointGenerator::AddPointsToWave() {
    m_counter++;
    QLineSeries* current = m_lineSeries1;
    QLineSeries* prev = m_lineSeries2;
    if (!m_firstWave) {
        current = m_lineSeries2;
        prev = m_lineSeries1;
    }

    if (m_type==RandomWave)
        AddPointToRandomWave(prev,current);
    else
        AddWaveformPoint(prev,current);

    // Check last point of the current waveform. If it is crossing XMAX of graph
    // then toggle the active waveform
    if (current->count()) {
        float px = current->at(current->count()-1).x();
        if (px>=m_xMax) {
            m_counter = 0;
            m_pointCounter = -1;
            m_firstWave = !m_firstWave;
        }
    }
}


void PointGenerator::AddPointToRandomWave(QLineSeries* prev,QLineSeries* current) {
    if (prev->count())
        prev->remove(0);
    current->append(current->count(),rand()%m_yMax);
}

void PointGenerator::ReadWaveformPoints()
{
    QString fileName = GetWaveformdataFilePath();
    WaveformReader reader;
    WaveformData data = reader.ReadWaveform(fileName);
    waveformPoints = data.getPoints();
    m_wminX = data.minX();
    m_wmaxX = data.maxX();
    m_wminY = data.minY();
    m_wmaxY = data.maxY();
}

void PointGenerator::AddWaveformPoint(QLineSeries* prev,QLineSeries* current) {

    m_pointCounter = (m_pointCounter + 1) % waveformPoints.size();
    float ex = waveformPoints[m_pointCounter].x;
    float ey = waveformPoints[m_pointCounter].y;

    int ydiff1 = m_wmaxY - m_wminY;
    int ydiff2 = m_yMax - m_yMin;
    float d1 = ey - m_wminY;
    float d2 = (d1*ydiff2)/ydiff1;
    float targetYpos = m_yMin + d2;

    if (m_counter>waveformPoints.size()) {
        float px = current->at(current->count()-1).x();
        float diff = 0;
        if (m_pointCounter!=0) {
            diff = ex - waveformPoints[m_pointCounter-1].x;
        }
        ex = px + diff;
    }
    if (prev->count())
        prev->remove(0);

    current->append(ex,targetYpos);
}

QString PointGenerator::GetWaveformdataFilePath()
{
    qDebug() << "ReadWaveformPoints:" << m_type;
    QString fileName(":/wavedata/ecg.txt");
    if (m_type==ECGWave1)
        fileName = QString(":/wavedata/ecg1.txt");
    if (m_type==ECGWave2)
        fileName = QString(":/wavedata/ecg2.txt");
    if (m_type==ECGWave3)
        fileName = QString(":/wavedata/ecg3.txt");
    if (m_type==SineWave)
        fileName = QString(":/wavedata/sine.txt");
    if (m_type==SquareWave)
        fileName = QString(":/wavedata/square.txt");
    return fileName;
}

