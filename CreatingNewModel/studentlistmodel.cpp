#include "studentlistmodel.h"

StudentListModel::StudentListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

QVariant StudentListModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

bool StudentListModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        // FIXME: Implement me!
        emit headerDataChanged(orientation, section, section);
        return true;
    }
    return false;
}

int StudentListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return count();
}

QVariant StudentListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() < 0 || index.row() >= m_students.size()) {
        return QVariant();
    }

    Student* s = m_students.at(index.row());

    switch (role) {
    case NameRole: return QVariant::fromValue(s->name());
    case RollRole: return QVariant::fromValue(s->roll());
    default: return QVariant();
    }
}

bool StudentListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags StudentListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

void StudentListModel::AddStudent(Student *student)
{
    beginInsertRows(QModelIndex(), m_students.size(), m_students.size());
    m_students.push_back(student);
    endInsertRows();

    emit countChanged();
}

void StudentListModel::RemoveStudent(Student *student)
{
    return;
}

bool StudentListModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
}

bool StudentListModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
}

int StudentListModel::count() const
{
    return m_students.count();
}
