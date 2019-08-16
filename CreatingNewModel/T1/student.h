#ifndef STUDENT_H
#define STUDENT_H

#include <QObject>

class Student : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
public:
    explicit Student(QObject *parent = nullptr);
    Student(QString name,int roll);

    int roll();
    void setRoll(const int r);

    QString name();
    void setName(const QString string);

    Q_INVOKABLE void print();

signals:
    void nameChanged();
    void rollChanged();

public slots:

private:
    QString m_name;
    int m_roll;
};

#endif // STUDENT_H
