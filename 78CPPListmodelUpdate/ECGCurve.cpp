#include "ECGCurve.h"
#include <qdebug.h>

ECGCurve::ECGCurve(QObject *parent) : QObject(parent)
{

}

ECGCurve::ECGCurve(QString name, int roll,QString color,bool visible)
{
    m_name = name;
    m_id = roll;
    m_color = color;
    m_visible = visible;
}

int ECGCurve::id()
{
    return m_id;
}

void ECGCurve::setId(const int r)
{
    if(m_id!=r) {
        m_id = r;
        emit idChanged();
    }
}

QString ECGCurve::name()
{
    return m_name;
}

void ECGCurve::setName(const QString name)
{
    if(name!=m_name) {
        m_name = name;
        emit nameChanged();
    }
}

QString ECGCurve::curvecolor()
{
    return m_color;
}

void ECGCurve::setCurvecolor(const QString color)
{
    if (m_color!=color) {
        m_color = color;
        emit curvecolorChanged();
    }
}

bool ECGCurve::curvevisible()
{
    return m_visible;
}

void ECGCurve::setCurvevisible(bool visible)
{
    if (visible!=m_visible) {
        m_visible = visible;
        emit curvevisibleChanged();
    }
}

void ECGCurve::print()
{
    qDebug() << "Id:" <<m_id;
    qDebug() << "name:" <<m_name;
    qDebug() << "color:" <<m_color;
    qDebug() << "visible:" << m_visible;
}
