#include "worker.h"
#include <qdebug.h>
#include "waveformreader.h"
#include <QMutexLocker>

Worker::Worker(QObject *parent) : QObject(parent)
{

}

Worker::Worker(int type,QAbstractSeries* s1,QAbstractSeries* s2,int xmin,int xmax,int ymin,int ymax)
    :m_xMin(xmin),m_xMax(xmax),m_yMin(ymin),m_yMax(ymax) {
    m_type = (WaveType)type;
    m_lineSeries1 = (QLineSeries*)s1;
    m_lineSeries2 = (QLineSeries*)s2;
}

void Worker::process()
{
    m_counter = 0;
    ReadWaveformPoints();
    for(int i=0;i<10000;i++) {
        AddPointsToWave();
        _sleep(100);
    }
    emit finished();
}

void Worker::AddPointsToWave() {
    QMutexLocker ml(&mMutex);
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
    if (current != nullptr && current->count()>0) {
        float px = current->at(current->count()-1).x();
        if (px>=m_xMax) {
            m_counter = 0;
            m_pointCounter = -1;
            m_firstWave = !m_firstWave;
        }
    }
}


void Worker::AddPointToRandomWave(QLineSeries* prev,QLineSeries* current) {
    if (prev->count())
        prev->remove(0);
    current->append(current->count(),rand()%m_yMax);
}

void Worker::ReadWaveformPoints()
{
    QString fileName = GetWaveformdataFilePath();
    qDebug() << "Filename:" << fileName;
    WaveformReader reader;
    WaveformData data = reader.ReadWaveform(fileName);
    waveformPoints = data.getPoints();
    m_wminX = data.minX();
    m_wmaxX = data.maxX();
    m_wminY = data.minY();
    m_wmaxY = data.maxY();
}

void Worker::AddWaveformPoint(QLineSeries* prev,QLineSeries* current) {

    m_pointCounter = (m_pointCounter + 1) % waveformPoints.size();
    float ex = waveformPoints[m_pointCounter].x;
    float ey = waveformPoints[m_pointCounter].y;

    int ydiff1 = m_wmaxY - m_wminY;
    int ydiff2 = m_yMax - m_yMin;
    float d1 = ey - m_wminY;
    float d2 = (d1*ydiff2)/ydiff1;
    float targetYpos = m_yMin + d2;

    if (m_counter>waveformPoints.size() && current!=nullptr && current->count()>0) {
        float px = current->at((current->count())-1).x();
        float diff = 0;
        if (m_pointCounter!=0) {
            diff = ex - waveformPoints[m_pointCounter-1].x;
        }
        ex = px + diff;
    }
    if (prev->count()>0)
        prev->remove(0);

    current->append(ex,targetYpos);
}

QString Worker::GetWaveformdataFilePath()
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

void Worker::reset()
{
//    m_lineSeries1->clear();
//    m_lineSeries2->clear();
//    m_counter = 0;
//    m_pointCounter = -1;

//    ReadWaveformPoints();
}
