#include "user.h"

User::User(QObject *parent) : QObject(parent)
{
    m_name="";
    m_color="red";
}

User::User(QString name,QString col)
{
    m_name=name;
    m_color=col;
}

QString User::name()
{
    return m_name;
}

void User::setName(QString name)
{
    m_name = name;
}

QString User::col()
{
    return m_color;
}

void User::setCol(QString col)
{
    m_color = col;
}
