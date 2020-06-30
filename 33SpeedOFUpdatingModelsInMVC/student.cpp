#include "student.h"
#include <qelapsedtimer.h>
#include <qdebug.h>

Student::Student(QObject *parent)
    : QAbstractListModel(parent)
{
}

int Student::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

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

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> Student::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[nameRole] = "sname";
    roles[rollRole] = "sroll";
    return roles;
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

void Student::addStudent()
{
    QElapsedTimer timer;
    timer.start();

    beginResetModel();
    int r = m_students.count()+1;
    m_students.append(Stud{r,QString("Student"+QString::number(r))});
    endResetModel();

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
    s.name = s.name + "U";
    m_students[index1] = s;
    emit dataChanged(index(0, 0), index(rowCount() - 1, 0));

    qDebug() << "updateStudent():" << timer.elapsed();
}

void Student::insertStudent()
{
    QElapsedTimer timer;
    timer.start();
    insertRows(rowCount(),1);
    qDebug() << "insertStudent():" << timer.elapsed();
}

void Student::insertMultipleStudents()
{
    QElapsedTimer timer;
    timer.start();
    insertRows(rowCount(),10);
    qDebug() << "insertMultipleStudents():" << timer.elapsed();
}

void Student::insertMultipleStudentsOneByOne()
{
    QElapsedTimer timer;
    timer.start();
    for(int i=0;i<10;i++)
    insertRows(rowCount(),1);
    qDebug() << "insertMultipleStudentsOneByOne():" << timer.elapsed();
}
