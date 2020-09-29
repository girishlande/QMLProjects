#ifndef STUDENTMODEL_H
#define STUDENTMODEL_H

#include <QAbstractListModel>
#include <QVector>

struct Student {
    int roll;
    QString name;
};

class StudentModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum roles {
        rollRole = Qt::UserRole + 1,
        nameRole
    };

    explicit StudentModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames() const;

    void AddStudent();

private:
    QVector<Student> m_students;
    int m_base = 0;
};

#endif // STUDENTMODEL_H
