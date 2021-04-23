#include "pointgenerator.h"
#include <qlineseries.h>
#include <QTimer>
#include <qdebug.h>

PointGenerator::PointGenerator(QObject *parent) : QObject(parent)
{
    m_counter = 0;
    m_timer = new QTimer(this);
    m_timer->setInterval(100);
    connect(m_timer, &QTimer::timeout, this, &PointGenerator::AddPointsToWave);
}

void PointGenerator::setSeries(QAbstractSeries* series1,QAbstractSeries* series2) {
    m_lineSeries1 = (QLineSeries*)series1;
    m_lineSeries2 = (QLineSeries*)series2;
    m_timer->start();
}

void PointGenerator::setMaxXPoints(int xpoints)
{
    m_maxPoints = xpoints;
}

void PointGenerator::AddPointsToWave() {
    m_counter++;
    if (m_counter>=m_maxPoints) {
        m_counter = 0;
        first = !first;
    }
    QLineSeries* current = m_lineSeries1;
    QLineSeries* prev = m_lineSeries2;
    if (!first) {
        current = m_lineSeries2;
        prev = m_lineSeries1;
    }
    if (prev->count()>0)
      prev->remove(0);
    current->append(current->count(),rand()%100);
}
