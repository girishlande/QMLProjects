#ifndef STUDENT_H
#define STUDENT_H

#include <QObject>
#include <QStringListModel>

class Student : public QObject
{
    Q_OBJECT
public:
    explicit Student(QObject *parent = nullptr);
    Q_PROPERTY(QStringList slist READ slist NOTIFY slistChanged)

    QStringList slist();
    Q_INVOKABLE void addStringInList();
    Q_INVOKABLE int slistSize();

signals:
    void slistChanged();

private:
    QStringList s_list;
};

#endif // STUDENT_H
