#include "studentmodel.h"

StudentModel::StudentModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_base = rand()%100;
}

int StudentModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_students.size();
}

QVariant StudentModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Student s = m_students[index.row()];
    switch (role) {
    case rollRole: return s.roll;
    case nameRole: return s.name;
    }
    return QVariant();
}

bool StudentModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        Student s = m_students[index.row()];
        switch (role) {
        case rollRole: s.roll = value.toInt(); break;
        case nameRole: s.name = value.toString(); break;
        }
        m_students[index.row()] = s;
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags StudentModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> StudentModel::roleNames() const
{
   QHash<int, QByteArray> roles;
   roles[rollRole] = "sroll";
   roles[nameRole] = "sname";
   return roles;
}

void StudentModel::AddStudent()
{
    beginResetModel();
    m_students.push_back(Student{m_base + m_students.size(),"AB"});
    endResetModel();
}
