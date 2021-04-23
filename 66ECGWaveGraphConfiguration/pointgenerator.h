#ifndef POINTGENERATOR_H
#define POINTGENERATOR_H

#include <QObject>
#include <QLineSeries>
#include <QAbstractSeries>
#include <QtCharts/QLineSeries>
#include <QtCharts/QChartView>

using namespace QtCharts;
class QTimer;

class PointGenerator : public QObject
{
    Q_OBJECT
public:
    explicit PointGenerator(QObject *parent = nullptr);

    Q_INVOKABLE void setSeries(QAbstractSeries* series1,QAbstractSeries* series2);
    Q_INVOKABLE void setMaxXPoints(int xpoints);

    void AddPointsToWave();

signals:

private:
    QLineSeries* m_lineSeries1;
    QLineSeries* m_lineSeries2;
    QTimer *m_timer;
    int m_counter;
    int m_maxPoints = 100;
    bool first = true;

};

#endif // POINTGENERATOR_H
