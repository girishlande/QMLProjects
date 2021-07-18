#ifndef STUDENTVIEWMODEL_H
#define STUDENTVIEWMODEL_H

#include "studentdata.h"
#include <qobject.h>

class StudentViewModel : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    StudentViewModel();
    ~StudentViewModel();

    int roll();
    void setRoll(int roll);

    QString name();
    void setName(QString name);

signals:
    void rollChanged();
    void nameChanged();

private:
    StudentData m_student;
};

#endif // STUDENTVIEWMODEL_H
