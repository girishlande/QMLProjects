#include "student.h"

Student::Student(QObject *parent) : QObject(parent)
{
    s_list << "Girish" << "SAmeer" << "Sachin";
}

QStringList Student::slist()
{
    return s_list;
}

void Student::addStringInList()
{
    s_list << QString("Student" + QString::number(s_list.size() + 1));
}

int Student::slistSize()
{
    return s_list.size();
}
