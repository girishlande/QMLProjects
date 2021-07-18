#include "studentdata.h"
#include <qdebug.h>
#include <qthread.h>

StudentData::StudentData(QObject *parent) : QObject(parent)
{
    qInfo() << "StudentData constructed on thread:" << QThread::currentThread();
}

StudentData::~StudentData()
{
    qInfo() << "StudentData destructed!" << QThread::currentThread();
}

int StudentData::roll() const
{
    return m_roll;
}

void StudentData::setRoll(int roll)
{
    if(m_roll!=roll) {
        m_roll = roll;
        emit rollchanged();
    }
}

QString StudentData::name() const
{
    return m_name;
}

void StudentData::setName(const QString &name)
{
    if(m_name!=name) {
        m_name = name;
        emit nameChanged();
    }
}
