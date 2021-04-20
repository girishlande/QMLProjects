#include "initgroup.h"

InitGroup::InitGroup(QObject *parent) : QObject(parent)
{

}

void InitGroup::AddKeyValuePair(QString key, QString value)
{
    m_map.insert(key,value);
}

QString InitGroup::title()
{
    return m_map["title"];
}

QString InitGroup::thickness()
{
    return m_map["thickness"];
}

QString InitGroup::increment()
{
    return m_map["increment"];
}

QString InitGroup::plane()
{
    return m_map["plane"];
}

QString InitGroup::type()
{
    return m_map["type"];
}

QString InitGroup::imgCount()
{
    return m_map["imgCount"];
}

QString InitGroup::planningVP()
{
    return m_map["planningVP"];
}

QString InitGroup::arcDes()
{
    return m_map["arcDes"];
}

//QString InitGroup::getValue(QString key)
//{
//    QStringList keys;
//    QMap<QString, QString>::const_iterator i = map.constBegin();
//    while (i != map.constEnd()) {
//        ++i;
//        if (i.key()==key)
//            return i.value();
//    }
//    return "";
//}



