#ifndef STUDENTFILLER_H
#define STUDENTFILLER_H

#include <QObject>
#include <qthread.h>
#include <classroom.h>

class StudentFiller : public QThread
{
    Q_OBJECT
public:
    StudentFiller(ClassRoom* model);

    void run();

signals:
    void addStudent();

private:
    ClassRoom* m_classroom = nullptr;
};

#endif // STUDENTFILLER_H
