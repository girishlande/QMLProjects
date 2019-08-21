#include "student.h"
#include "qdebug.h"

Student::Student(QObject *parent) : QObject(parent)
{

}

Student::Student(int roll,QString name)
    :m_roll(roll),m_name(name)
{

}

void Student::Display()
{
    qDebug() << "Roll:" << m_roll << " Name:" <<m_name;
}

int Student::roll()
{
    return m_roll;
}

void Student::setRoll(int roll)
{
    m_roll = roll;
}

QString Student::name()
{
    return m_name;
}

void Student::setName(QString name)
{
    m_name = name;
}
