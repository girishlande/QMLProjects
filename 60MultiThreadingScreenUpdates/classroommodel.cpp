#include "classroommodel.h"
#include <classroom.h>

ClassRoomModel::ClassRoomModel(QObject *parent)
    : QAbstractListModel(parent)
{

    m_classrooms.push_back(ClassRoom(1,"ClassRoom-11"));
    m_classrooms.push_back(ClassRoom(2,"ClassRoom-22"));
    m_classrooms.push_back(ClassRoom(3,"ClassRoom-33"));
}

int ClassRoomModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_classrooms.size();
}

QVariant ClassRoomModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const ClassRoom& c = m_classrooms[index.row()];
    switch (role) {
    case cidRole: return QVariant(c.cid());
    case cnameRole: return QVariant(c.cname());
    }
    return QVariant();
}

bool ClassRoomModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        ClassRoom& c = m_classrooms[index.row()];
        switch (role) {
        case cidRole: c.setCid(value.toInt()); break;
        case cnameRole: c.setCname(value.toString()); break;
        }
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ClassRoomModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> ClassRoomModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[cidRole] = "cid";
    roles[cnameRole] = "cname";
    return roles;
}

void ClassRoomModel::startAddingStudents(int index)
{
    ClassRoom& c = m_classrooms[index];
    c.startFill();
}

StudentModel *ClassRoomModel::getModel(int index)
{
    ClassRoom& c = m_classrooms[index];
    return c.studentmodel();
}
