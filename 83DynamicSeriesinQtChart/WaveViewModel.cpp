#include "WaveViewModel.h"
#include <QtCharts/QChartView>

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

WaveViewModel::WaveViewModel(QObject *parent)
    : QObject(parent)
{
    qRegisterMetaType<QAbstractSeries*>();
    qRegisterMetaType<QAbstractAxis*>();

    m_timer = new QTimer(this);
    m_timer->setInterval(10);
    connect(m_timer, &QTimer::timeout, this, &WaveViewModel::addPointsToWave);
    m_timer->start();
}

void WaveViewModel::addSlotSeries(QLineSeries* s1,QLineSeries* s2)
{
    QMutexLocker locker(&m_mutex);
    if(m_slotMode) return;

    m_slotMode = true;
    QPen pen;
    if (m_index%2==0)
        pen.setColor(QColor(0, 255, 255));
    else
        pen.setColor(QColor(255, 255, 0));
    pen.setWidth(1);
    s1->setPen(pen);
    s2->setPen(pen);
    m_slotSeries.push_back(s1);
    m_slotSeries.push_back(s2);

    if(m_pointseries) {
        m_pointseries->append(m_x,m_y);
        emit createTriggerWaveXY(m_x,m_y);
    }
}

void WaveViewModel::addSeries(QAbstractSeries *s1,QAbstractSeries* s2)
{
    qDebug()<<"Series added";
    m_lineSeries.push_back(s1);
    m_lineSeries.push_back(s2);
}

void WaveViewModel::finishSlotSeries()
{
    QMutexLocker locker(&m_mutex);
    m_finishMode = true;
}

void WaveViewModel::addPointSeries(QAbstractSeries *s1)
{
    m_pointseries = (QScatterSeries*) s1;
}

void WaveViewModel::addPointsToWave() {

    if (m_slotCreationMode) {
        m_slotCreationMode = false;
        emit createSlotWave();
    }
    QMutexLocker locker(&m_mutex);
    if(m_lineSeries.size()==0) return;

    QLineSeries* c1 = (QLineSeries*)m_lineSeries[m_index];
    QLineSeries* c2 = (QLineSeries*)m_lineSeries[(m_index+1)%2];

    m_x = c1->count();

    eraseOldSlots();

    m_y = 200 + 50*sin(m_angle*3.141/180);
    c1->append(m_x, m_y);

    if(c2->count()) {
        c2->remove(0);
    }
    m_angle+=2;

    addPointsToSlotWave();

    if (c1->count()>=1000) {
        m_index = (m_index+1)%2;
        m_angle = rand()%360;
    }

}

void WaveViewModel::addPointsToSlotWave()
{
    if(m_slotMode && m_slotSeries.size()) {
        QLineSeries* c1 = (QLineSeries*)m_lineSeries[m_index];

        int index = m_slotSeries.size() - 2;
        QLineSeries* s1 = (QLineSeries*)m_slotSeries[index];
        QLineSeries* s2 = (QLineSeries*)m_slotSeries[index+1];
        if (c1->count()>=1000) {
            // Close current slot and mark creation of new slot
            s1->append(m_x, 95);
            s2->append(m_x, 95);
            m_slotCreationMode = true;
            m_slotMode = false;
        }else if (m_finishMode) {
            // Close the slot
            s1->append(m_x, 95);
            s2->append(m_x, 95);
            m_finishMode = false;
            m_slotMode = false;
        } else{
            if (s1->count()==0) {
                s1->append(m_x, 100);
                s2->append(m_x, 100);
            } else{
                s1->append(m_x, 100);
                s2->append(m_x, 95);
            }
        }
    }

}

void WaveViewModel::closeSlotWave()
{
    QLineSeries* c1 = (QLineSeries*)m_lineSeries[m_index];
    int x = c1->count();

    int index = m_slotSeries.size() - 2;
    QLineSeries* s1 = (QLineSeries*)m_slotSeries[index];
    QLineSeries* s2 = (QLineSeries*)m_slotSeries[index+1];
    s1->append(x, 90);
    s2->append(x, 90);
    m_finishMode = false;
}

void WaveViewModel::eraseOldSlots()
{
    if (m_slotMode && m_slotSeries.size()==1) return;
    if(m_oldIndex>=m_slotSeries.size()) return;
    QLineSeries* s1 = (QLineSeries*)m_slotSeries[m_oldIndex];
    QLineSeries* s2 = (QLineSeries*)m_slotSeries[m_oldIndex+1];
    qreal x = s1->at(0).x();
    if((int)x==m_x) {
        s1->remove(0);
        s2->remove(0);
        if(s1->count()==0) {
            // Remove s1 and s2
            m_oldIndex+=2;
            emit removeSlotWave();
        }
    }

    x = m_pointseries->at(0).x();
    if(x==m_x) {
        m_pointseries->remove(0);
        emit removeTriggerWave();
    }
}
