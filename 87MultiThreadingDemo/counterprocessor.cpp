#include "counterprocessor.h"
#include <qdebug.h>
#include <QThread>
#include <QDateTime>

CounterProcessor::CounterProcessor(QObject *parent) : QObject(parent)
{

}


void CounterProcessor::setRunning(bool running)
{
    qInfo() << "CounterProcessor running :" <<running << " Thread:" << QThread::currentThread();
    m_running = running;
}


void CounterProcessor::work()
{
    if (m_running) {
        qInfo() << "Working thread:" << QThread::currentThread() << "time: " << QDateTime::currentDateTime().toString();
        m_counter++;
        emit counterChanged(m_counter);
        QThread::msleep(1000);
    }
}
