#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QtCharts/QLineSeries>
#include <QtCharts/QChartView>
#include "waveformutils.h"
#include "pointgenerator.h"
#include <qmutex.h>

using namespace QtCharts;

class Worker : public QObject
{
    Q_OBJECT
public:
    enum WaveType {
        RandomWave=0,
        ECGWave,
        ECGWave1,
        ECGWave2,
        ECGWave3,
        SineWave,
        SquareWave
    };
    explicit Worker(QObject *parent = nullptr);
    Worker(int type,QAbstractSeries* s1,QAbstractSeries* s2,int xmin,int xmax,int ymin,int ymax);

public slots:
    void process();

signals:
    void finished();
    void error(QString error);
    void processed(int i);

protected:
    void ReadWaveformPoints();
    void AddPointToRandomWave(QLineSeries* prev,QLineSeries* current);
    void AddWaveformPoint(QLineSeries* prev,QLineSeries* current);
    void AddPointsToWave();
    QString GetWaveformdataFilePath();

private:
    int m_id = 0;

    QLineSeries* m_lineSeries1;
    QLineSeries* m_lineSeries2;
    QTimer *m_timer;
    int m_counter;
    int m_maxPoints = 500;
    bool m_firstWave = true;
    WaveType m_type = ECGWave;

    // waveform points
    std::vector<XY> waveformPoints;
    int m_wminX;
    int m_wmaxX;
    int m_wminY;
    int m_wmaxY;

    int m_pointCounter = -1;

    // Graph area
    int m_xMin;
    int m_xMax;
    int m_yMin;
    int m_yMax;

    QMutex mMutex;
};

#endif // WORKER_H
