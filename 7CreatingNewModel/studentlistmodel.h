#ifndef STUDENTLISTMODEL_H
#define STUDENTLISTMODEL_H

#include <QAbstractListModel>
#include <student.h>

class StudentListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        RollRole
    };

    explicit StudentListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;


    int count() const;
    void AddStudent(Student* student);
    void RemoveStudent(Student* student);

    QHash<int,QByteArray> roleNames() const override {
        return { { NameRole, "name" },
            { RollRole, "roll" }
        };
    }
signals:
    void countChanged();

private:
    QList<Student*> m_students;

};

#endif // STUDENTLISTMODEL_H
