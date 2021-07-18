#include "worker.h"
#include <qdebug.h>
#include <QThread>

Worker::Worker(QObject *parent) : QObject(parent)
{

}

Worker::Worker(int id)
    :m_id(id) {

}

void Worker::process()
{
    qInfo() << "\nWorker process()" << " Thread:" << QThread::currentThread();
    for(int i=0;i<100;i++) {
        processed(m_id * (i+1));
        QThread::currentThread()->sleep(2);
    }
}
