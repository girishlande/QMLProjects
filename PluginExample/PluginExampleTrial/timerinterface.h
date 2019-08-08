#ifndef TIMERINTERFACE_H
#define TIMERINTERFACE_H

#include <QString>

//! [0]
class TimerInterface
{
public:
    virtual ~TimerInterface() {}
    virtual QString timerString() = 0;
};


QT_BEGIN_NAMESPACE

#define TimerInterface_iid "QtProjects.TimerInterface"

Q_DECLARE_INTERFACE(TimerInterface, TimerInterface_iid)
QT_END_NAMESPACE


#endif // TIMERINTERFACE_H
