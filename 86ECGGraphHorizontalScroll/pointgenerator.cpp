#include "pointgenerator.h"
#include <qlineseries.h>
#include <QTimer>
#include <qdebug.h>

PointGenerator::PointGenerator(QObject *parent) : QObject(parent)
{
    m_counter = 0;
    m_timer = new QTimer(this);
    m_timer->setInterval(4000);
    connect(m_timer, &QTimer::timeout, this, &PointGenerator::AddPointsToWave);
}

void PointGenerator::setSeries(QAbstractSeries* series1,QAbstractSeries* series2) {
    m_lineSeries1 = (QLineSeries*)series1;
    m_lineSeries2 = (QLineSeries*)series2;
    m_timer->start();
}

void PointGenerator::AddPointsToWave() {

    QList<QPointF> points;
    QLineSeries* current = m_lineSeries1;
    for(int i=0;i<m_gwidth;i++) {
        points.append(QPointF(i,rand()%m_gheight));
    }
    current->replace(points);
}

int PointGenerator::gwidth()
{
    return m_gwidth;
}

void PointGenerator::setGwidth(int width)
{
    if (m_gwidth!=width) {
        m_gwidth = width;
        emit gwidthChanged();
    }
}

int PointGenerator::gheight()
{
    return m_gheight;
}

void PointGenerator::setGheight(int height)
{
    if (m_gheight!=height) {
        m_gheight = height;
        emit gheightChanged();
    }
}
