#include "student.h"
#include <qelapsedtimer.h>
#include <qdebug.h>

Student::Student(QObject *parent)
    : QAbstractListModel(parent)
{
    //    m_students.append(Stud{11,"Girish"});
    //    m_students.append(Stud{12,"Ajit"});
    //    m_students.append(Stud{13,"Suhas"});
    //    m_students.append(Stud{14,"Ramesh"});
}

int Student::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return m_students.size();
}

QVariant Student::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Stud s = m_students.at(index.row());

    switch (role) {
    case nameRole: return QVariant(s.name);
    case rollRole: return QVariant(s.roll);
    default:
        break;
    }
    return QVariant();
}

bool Student::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    Stud s = m_students.at(index.row());
    switch (role) {
    case nameRole: s.name = value.toString(); break;
    case rollRole: s.roll = value.toInt(); break;
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

QHash<int, QByteArray> Student::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[nameRole] = "sname";
    roles[rollRole] = "sroll";
    return roles;
}

void Student::addStudent()
{
    QElapsedTimer timer;
    timer.start();

    beginResetModel();
    int r = m_students.count()+1;
    m_students.append(Stud{r,QString("Student"+QString::number(r))});
    endResetModel();
    //emit dataChanged(QModelIndex(), QModelIndex(), QVector<int>());
    //emit dataChanged(index(0, 0), index(rowCount() - 1, 0));

    qDebug() << "addStudent():" << timer.elapsed();
}

void Student::addStudentsInOneGo()
{
    QElapsedTimer timer;
    timer.start();

    beginResetModel();
    for(int i=0;i<10;i++) {
        int r = m_students.count()+1;
        m_students.append(Stud{r,QString("Student"+QString::number(r))});
    }
    endResetModel();
    qDebug() << "\naddStudentsInOneGo():" << timer.elapsed()<<"\n";
}

void Student::addStudentsOneByOne()
{
    QElapsedTimer timer;
    timer.start();

    for(int i=0;i<10;i++) {
        addStudent();
    }

    qDebug() << "\naddStudentsOneByOne():" << timer.elapsed()<<"\n";
}

void Student::clearStudents()
{
    beginResetModel();
    m_students.clear();
    endResetModel();
}

void Student::updateStudent()
{
    QElapsedTimer timer;
    timer.start();

    int n = m_students.size();
    int index1 = qrand() % n;
    Stud s = m_students.at(index1);
    s.name = s.name + "updated";
    m_students[index1] = s;
    emit dataChanged(index(0, 0), index(rowCount() - 1, 0));

    qDebug() << "updateStudent():" << timer.elapsed();
}
