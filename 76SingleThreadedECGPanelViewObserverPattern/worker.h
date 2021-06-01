#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QtCharts/QLineSeries>
#include <QtCharts/QChartView>
#include "waveformutils.h"
#include "pointgenerator.h"
#include <qmutex.h>

using namespace QtCharts;

class QTimer;
class Worker : public QObject
{
    Q_OBJECT
public:

    explicit Worker(QObject *parent = nullptr);
    Worker(int type,QAbstractSeries* s1,QAbstractSeries* s2,int xmin,int xmax,int ymin,int ymax);
    ~Worker();

    WaveformType type();
    void AddPoint(XY position);

signals:
    void finished();
    void error(QString error);
    void processed(int i);

protected:
    void ReadWaveformPoints();
    void AddWaveformPoint(QLineSeries* prev,QLineSeries* current);
    void AddPointsToWave();
    QString GetWaveformdataFilePath();
    void CacheWaveformLimits();

private:
    int m_id = 0;

    QLineSeries* m_lineSeries1;
    QLineSeries* m_lineSeries2;
    bool m_firstWave = true;
    WaveformType m_type = ECGWave;

    std::vector<XY> m_waveformPoints;
    int m_wminX;
    int m_wmaxX;
    int m_wminY;
    int m_wmaxY;

    // Graph area
    int m_xMin;
    int m_xMax;
    int m_yMin;
    int m_yMax;

    float m_x;
    float m_y;
    float m_baseX = 0;

    QMutex mMutex;
};

#endif // WORKER_H
