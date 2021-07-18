#include "taskmanager.h"
#include "qdebug.h"
#include <qthread.h>
#include <QDateTime>

TaskManager::TaskManager(QObject *parent) : QObject(parent)
{
    qDebug() << "Task constructed:" << QThread::currentThread();
    workerThread.setObjectName("Worker thread");

    CounterProcessor* worker = new CounterProcessor();

    connect(&workerThread,&QThread::finished,worker,&QObject::deleteLater);
    connect(worker,&CounterProcessor::counterChanged,this,&TaskManager::setCounter);
    connect(this,&TaskManager::runningUpdate,worker,&CounterProcessor::setRunning);
    connect(&workerThread,&QThread::started,worker,&CounterProcessor::work);
    connect(&m_timer,&QTimer::timeout,worker,&CounterProcessor::work);

    worker->moveToThread(&workerThread);
    workerThread.start();

    m_timer.setInterval(2000);
    m_timer.start();
}

TaskManager::~TaskManager()
{
    workerThread.quit();
    workerThread.wait();
    qDebug() << "Task destructed:" << QThread::currentThread();
}



bool TaskManager::running() const
{
    return m_running;
}

void TaskManager::setRunning(bool running)
{
    if (running!=m_running) {
        qInfo() << "setRunning:" <<  running << " thread:" << QThread::currentThread();
        m_running = running;
        emit runningUpdate(m_running);
    }
}

int TaskManager::counter() const
{
    return m_counter;
}

void TaskManager::setCounter(int counter)
{
    if (m_counter!=counter) {
        m_counter = counter;
        emit counterChanged();
    }
}
