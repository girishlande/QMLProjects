#ifndef STUDENT_H
#define STUDENT_H

#include <QQuickItem>

class Student : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Student)
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    Student(QQuickItem *parent = nullptr);
    ~Student();

    int roll();
    void setRoll(int roll);
    QString name();
    void setName(QString name);

signals:
    void rollChanged();
    void nameChanged();

private:
    int m_roll;
    QString m_name;
};

#endif // STUDENT_H
