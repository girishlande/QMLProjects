#ifndef POINTGENERATOR_H
#define POINTGENERATOR_H

#include <iostream>
#include <QObject>
#include <QLineSeries>
#include <QAbstractSeries>
#include <QtCharts/QLineSeries>
#include <QtCharts/QChartView>
#include "waveformutils.h"

using namespace QtCharts;
class QTimer;


class PointGenerator : public QObject
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
    Q_ENUMS(WaveType)

    Q_PROPERTY(int xMin READ xMin WRITE setXMin NOTIFY xMinChanged)
    Q_PROPERTY(int xMax READ xMax WRITE setXMax NOTIFY xMaxChanged)
    Q_PROPERTY(int yMin READ yMin WRITE setYMin NOTIFY yMinChanged)
    Q_PROPERTY(int yMax READ yMax WRITE setYMax NOTIFY yMaxChanged)
    Q_PROPERTY(int timerDelay READ timerDelay WRITE setTimerDelay NOTIFY timerDelayChanged)
    Q_PROPERTY(WaveType wavetype READ wavetype WRITE setWaveType NOTIFY wavetypeChanged)
    explicit PointGenerator(QObject *parent = nullptr);

    Q_INVOKABLE void setSeries(QAbstractSeries* series1,QAbstractSeries* series2);
    Q_INVOKABLE void setMaxXPoints(int xpoints);
    Q_INVOKABLE void reset();

    int xMin();
    void setXMin(int xmin);

    int xMax();
    void setXMax(int xmax);

    int yMin();
    void setYMin(int ymin);

    int yMax();
    void setYMax(int ymax);

    int timerDelay();
    void setTimerDelay(int timer);

    WaveType wavetype();
    void setWaveType(WaveType type);

signals:
    void xMinChanged();
    void xMaxChanged();
    void yMinChanged();
    void yMaxChanged();
    void timerDelayChanged();
    void wavetypeChanged();

protected:
    void ReadWaveformPoints();
    void AddPointToRandomWave(QLineSeries* prev,QLineSeries* current);
    void AddWaveformPoint(QLineSeries* prev,QLineSeries* current);
    void AddPointsToWave();

private:
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

    int m_timerdelay=10;
};

#endif // POINTGENERATOR_H
