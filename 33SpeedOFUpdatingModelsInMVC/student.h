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
        rollRole = Qt::UserRole + 1,
        nameRole
    };

    explicit Student(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames() const;

    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    Q_INVOKABLE void addStudent();

    Q_INVOKABLE void addStudentsInOneGo();
    Q_INVOKABLE void addStudentsOneByOne();
    Q_INVOKABLE void clearStudents();
    Q_INVOKABLE void updateStudent();

    Q_INVOKABLE void insertStudent();
    Q_INVOKABLE void insertMultipleStudents();
    Q_INVOKABLE void insertMultipleStudentsOneByOne();

private:

    QVector<Stud> m_students;
};

#endif // STUDENT_H
