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
    Q_PROPERTY(int gwidth READ gwidth WRITE setGwidth NOTIFY gwidthChanged)
    Q_PROPERTY(int gheight READ gheight WRITE setGheight NOTIFY gheightChanged)

    Q_INVOKABLE void setSeries(QAbstractSeries* series1,QAbstractSeries* series2);

    void AddPointsToWave();

    int gwidth();
    void setGwidth(int width);

    int gheight();
    void setGheight(int height);

signals:
    void gwidthChanged();
    void gheightChanged();

private:
    QLineSeries* m_lineSeries1;
    QLineSeries* m_lineSeries2;
    QTimer *m_timer;
    int m_counter;
    int m_maxPoints = 100;
    bool first = true;

    int m_gwidth=15000;
    int m_gheight=256;

};

#endif // POINTGENERATOR_H
