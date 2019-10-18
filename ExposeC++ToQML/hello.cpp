#include "hello.h"

Hello::Hello(QObject *parent) : QObject(parent) {
    m_greetings = DEFAULT_GREETING;
}

QString Hello::getGreetings()
{
    return m_greetings;
}

void Hello::setGreetings(const QString &greetings)
{
    if (m_greetings == greetings)
        return;

    m_greetings = greetings;

    // Notify about changed greetings
    emit greetingsChanged();
}

void Hello::resetToDefaultGreeting()
{
    setGreetings(DEFAULT_GREETING);
}
