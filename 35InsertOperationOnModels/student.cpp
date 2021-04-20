#include "student.h"

Student::Student(QObject *parent)
    : QAbstractListModel(parent)
{
}

int Student::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_students.size();
}

QVariant Student::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Stud s = m_students[index.row()];
    switch (role) {
    case rollRole:
        return QVariant(s.roll);
        break;
    case nameRole:
        return QVariant(s.name);
        break;
    default:
        break;
    }
    return QVariant();
}

bool Student::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Stud s = m_students[index.row()];
    switch (role) {
    case rollRole:
        s.roll = value.toInt();
        break;
    case nameRole:
        s.name = value.toString();
        break;
    default:
        break;
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

    for(int i=0;i<count;i++) {
        int r = m_students.size()+1;
        m_students.insert(row+i,Stud{r,"IStudent"+QString::number(r)});
    }
    endInsertRows();
    return true;
}

QHash<int, QByteArray> Student::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[rollRole] = "sroll";
    roles[nameRole] = "sname";
    return roles;
}

void Student::addStudents()
{
    beginResetModel();
    for(int i=0;i<4;i++) {
        int r = m_students.size()+1;
        m_students.push_back(Stud{r,"Student"+QString::number(r)});
    }
    endResetModel();
}

void Student::insertStudents()
{
    insertRows(qrand() % m_students.size(),2,QModelIndex());
}

void Student::insertStudentsAtEnd()
{
    insertRows(m_students.size(),1,QModelIndex());
}

void Student::insertMultipleStudentsAtEnd()
{
    insertRows(m_students.size(),4,QModelIndex());
}

void Student::clearStudents()
{
    beginResetModel();
    m_students.clear();
    endResetModel();
}
