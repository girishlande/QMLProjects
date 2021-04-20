#include "student.h"

Student::Student(QObject *parent)
    : QAbstractListModel(parent)
{
    m_students.append(Stud{1,"Girish"});
    m_students.append(Stud{2,"Ajit"});
    m_students.append(Stud{3,"Suhas"});

}

int Student::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_students.count();
}

QVariant Student::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Stud s = m_students[index.row()];
    switch(role) {
    case RollRole: return QVariant(s.roll);
    case NameRole: return QVariant(s.name);
    }

    return QVariant();
}

bool Student::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Stud s = m_students[index.row()];
    switch(role) {
    case RollRole: s.roll = value.toBool();break;
    case NameRole: s.name = value.toString(); break;
    }

    if (data(index, role) != value) {
        m_students[index.row()] = s;
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
    int r = m_students.count();
    m_students.insert(row,count,Stud{r,"IStudent"+QString::number(r)});
    endInsertRows();
    return true;
}

bool Student::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    m_students.remove(row,count);
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> Student::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[RollRole] = "sroll";
    roles[NameRole] = "sname";
    return roles;
}

void Student::addStudent(int index)
{
    insertRows(index,1);
}

void Student::removeStudent(int index)
{
   removeRows(index,1);
}
