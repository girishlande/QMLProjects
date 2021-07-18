#include "pointgenerator.h"
#include "worker.h"
#include <qthread.h>
#include <qdebug.h>

PointGenerator::PointGenerator(QObject *parent) : QObject(parent)
{

}

int PointGenerator::ivalue()
{
    return m_value;
}

void PointGenerator::setIvalue(int i)
{
    if(m_value!=i) {
        m_value = i;
        emit ivalueChanged();
    }
}

int PointGenerator::pid()
{
    return m_id;
}

void PointGenerator::setPid(int id)
{
    if (m_id!=id) {
        m_id = id;
        emit pidChanged();
    }
}

void PointGenerator::init()
{
    qInfo() << "ini() :" << QThread::currentThread() << " id:" <<m_id;
    QThread* thread = new QThread;
    Worker* worker = new Worker(m_id);
    worker->setObjectName("Worker thread");
    worker->moveToThread(thread);
    connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
    connect(worker, SIGNAL (processed(int)), this, SLOT (processed(int)));
    connect(thread, SIGNAL (started()), worker, SLOT (process()));
    connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
    connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
    connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
    thread->start();
}

void PointGenerator::errorString(QString error)
{
    qDebug() << "Error occured:" << error;
}

void PointGenerator::processed(int i)
{
    qInfo() <<"processed Thread:" << QThread::currentThread();
    setIvalue(i);
}
