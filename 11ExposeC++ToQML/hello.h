#ifndef HELLO_H
#define HELLO_H

#include <QObject>
#include <QString>

class Hello : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString greetings READ getGreetings WRITE setGreetings NOTIFY greetingsChanged)

public:
    explicit Hello(QObject *parent=nullptr);

    // getter
    QString getGreetings();
    // setter
    void setGreetings(const QString &greetings);

    // invokable method
    Q_INVOKABLE void resetToDefaultGreeting();

signals:
    // event
    void greetingsChanged();

private:
    const QString DEFAULT_GREETING="Hello";
    QString m_greetings;
};

#endif // HELLO_H
