#include "student.h"

Student::Student(QObject *parent)
    : QAbstractListModel(parent)
{
    m_students.append("GIRISH");
    m_students.append("AJIT");
    m_students.append("SUHAS");
}

int Student::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    m_students.size();
}

QVariant Student::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    return QVariant(m_students[index.row()]);
}

bool Student::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        m_students[index.row()] = value.toString();
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags Student::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

bool Student::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    m_students.insert(row,"IStudent"+QString::number(row));
    endInsertRows();
    return true;
}

bool Student::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    m_students.removeAt(row);
    endRemoveRows();
    return true;
}

void Student::insertStudent(int index)
{
    insertRows(index,1,QModelIndex());
}

void Student::removeStudent(int index)
{
    removeRows(index,1,QModelIndex());
}
