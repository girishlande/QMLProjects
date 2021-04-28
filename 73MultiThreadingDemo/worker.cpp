#include "worker.h"
#include <qdebug.h>

Worker::Worker(QObject *parent) : QObject(parent)
{

}

Worker::Worker(int id)
    :m_id(id) {

}

void Worker::process()
{
    for(int i=0;i<100;i++) {
        processed(m_id * (i+1));
        _sleep(100);
    }
}
