#include "studentfiller.h"
#include <windows.h>
#include <qdebug.h>

StudentFiller::StudentFiller(ClassRoom *model)
    :m_classroom(model){

}

void StudentFiller::run()
{
    for(int i=1;i<=20;i++) {
        qDebug() << m_classroom->cname() << " Adding Student:" << i;
        emit addStudent();
        Sleep(1000);
    }
}
