#include "student.h"

Student::Student(QQuickItem *parent):
    QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

Student::~Student()
{
}

int Student::roll()
{
    return m_roll;
}

void Student::setRoll(int roll)
{
    if (m_roll!=roll) {
        m_roll = roll;
        qDebug() << "student roll changed:" << m_roll;
        emit rollChanged();
    }
}

QString Student::name()
{
    return m_name;
}

void Student::setName(QString name)
{
    if (m_name!=name) {
        m_name = name;
        qDebug() << "student name changed:" << m_name;
        emit nameChanged();
    }
}

