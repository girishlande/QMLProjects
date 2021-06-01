#ifndef DIABCHART_H
#define DIABCHART_H

#include <QObject>

#include <QtCharts/QChartView>
#include <QtCharts/QLineSeries>
#include <QtCharts/QScatterSeries>
#include <QtCharts/QDateTimeAxis>
#include <QtCharts/QCategoryAxis>
#include <QDateTime>
#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QObject>
#include <QTimer>
#include <QMutex>

QT_CHARTS_USE_NAMESPACE

class WaveViewModel : public QObject
{
    Q_OBJECT

public:
    explicit WaveViewModel(QObject *parent = 0);

    Q_INVOKABLE void addSlotSeries(QLineSeries* s1,QLineSeries* s2);
    Q_INVOKABLE void addSeries(QAbstractSeries* series1,QAbstractSeries* series2);
    Q_INVOKABLE void finishSlotSeries();
    Q_INVOKABLE void addPointSeries(QAbstractSeries* s1);

signals:
    void createSlotWave();
    void removeSlotWave();
    void createTriggerWave(int xpos);
    void createTriggerWaveXY(int xpos,int ypos);
    void removeTriggerWave();

private:
    void addPointsToWave();
    void addPointsToSlotWave();
    void closeSlotWave();
    void eraseOldSlots();

    std::vector<QAbstractSeries*> m_lineSeries;
    std::vector<QAbstractSeries*> m_slotSeries;

    QScatterSeries* m_pointseries = nullptr;
    std::vector<QAbstractSeries*> m_triggerSeries;

    QTimer* m_timer = nullptr;
    float m_angle = 0;
    bool m_index = 0;

    float m_x = 0;
    float m_y = 0;
    bool m_slotMode = false;
    bool m_finishMode = false;
    bool m_slotCreationMode = false;

    int m_oldIndex=0;

    QMutex m_mutex;
};


#endif // DIABCHART_H
