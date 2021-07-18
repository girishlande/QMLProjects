
#include "studentviewmodel.h"
#include <qdebug.h>
#include <qthread.h>

StudentViewModel::StudentViewModel()
{
    qInfo() <<"StudentViewModel constructed!"  << QThread::currentThread();
    connect(&m_student,&StudentData::rollchanged,this,&StudentViewModel::rollChanged);
    connect(&m_student,&StudentData::nameChanged,this,&StudentViewModel::nameChanged);
}

StudentViewModel::~StudentViewModel()
{
    qInfo() <<"StudentViewModel destructed!"  << QThread::currentThread();
}

int StudentViewModel::roll()
{
    return m_student.roll();
}

void StudentViewModel::setRoll(int roll)
{
    m_student.setRoll(roll);
}

QString StudentViewModel::name()
{
    return m_student.name();
}

void StudentViewModel::setName(QString name)
{
    m_student.setName(name);
}
