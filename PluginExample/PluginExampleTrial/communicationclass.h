#ifndef COMMUNICATIONCLASS_H
#define COMMUNICATIONCLASS_H

#include <QObject>
#include "timerinterface.h"

class CommunicationClass: public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    CommunicationClass();

    QString date();
    void setDate(QString date);
signals:
    void dateChanged();
private slots:
    void sendTimer();
private:
     bool loadPlugin();
     TimerInterface *timerInterface;
     QString m_date;

};

#endif // COMMUNICATIONCLASS_H
