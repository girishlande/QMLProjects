#include "student.h"
#include <qdebug.h>

Student::Student(QObject *parent) : QObject(parent)
{

}

Student::Student(QString name, int roll)
{
    m_name = name;
    m_roll = roll;
}

int Student::roll()
{
    return m_roll;
}

void Student::setRoll(const int r)
{
    m_roll = r;
}

QString Student::name()
{
    return m_name;
}

void Student::setName(const QString name)
{
    m_name = name;
}

void Student::print()
{
    qDebug() << "Student information";
    qDebug() << "name:" <<m_name;
    qDebug() << "roll:" <<m_roll;
}
