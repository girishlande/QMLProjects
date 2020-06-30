#ifndef STUDENT_H
#define STUDENT_H

#include <QAbstractListModel>
#include <qvector.h>

struct Stud {
    int roll;
    QString name;
};

class Student : public QAbstractListModel
{
    Q_OBJECT

public:
    enum roles {
        RollRole = Qt::UserRole+1,
        NameRole
    };
    explicit Student(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    // Remove data:
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    virtual QHash<int,QByteArray> roleNames() const;

    Q_INVOKABLE void addStudent(int index);
    Q_INVOKABLE void removeStudent(int index);

private:
    QVector<Stud> m_students;
};

#endif // STUDENT_H
