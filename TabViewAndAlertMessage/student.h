#ifndef STUDENT_H
#define STUDENT_H

#include <QObject>

class Student : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    explicit Student(QObject *parent = nullptr);
    Student(int r,QString n);

    Q_INVOKABLE void Display();

    int roll();
    void setRoll(int rolll);
    QString name();
    void setName(QString name);

signals:
    void rollChanged();
    void nameChanged();

public slots:

private:
    int m_roll;
    QString m_name;
};

using StudentPtr = QSharedPointer<Student>;

#endif // STUDENT_H
