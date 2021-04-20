#ifndef CLASSROOMMODEL_H
#define CLASSROOMMODEL_H

#include <QAbstractListModel>
#include <qvector.h>
#include <classroom.h>
#include <QSharedPointer>
#include<vector>

typedef QSharedPointer<ClassRoom> ClassRoomPtr;

class ClassRoomModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum roles {
        cidRole=Qt::UserRole+1,
        cnameRole,
        cstudentModelRole
    };

    explicit ClassRoomModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames() const;

    Q_INVOKABLE void startAddingStudents(int index);
    Q_INVOKABLE StudentModel* getModel(int index);

private:
    std::vector<ClassRoom> m_classrooms;
};

#endif // CLASSROOMMODEL_H
