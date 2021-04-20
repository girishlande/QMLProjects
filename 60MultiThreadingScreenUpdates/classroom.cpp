#include "classroom.h"
#include <studentfiller.h>
#include <studentmodel.h>

ClassRoom::ClassRoom(QObject *parent) : QObject(parent)
{

}

ClassRoom::ClassRoom(int id, QString name)
    :m_id(id), m_name(name) {

}

ClassRoom::ClassRoom(const ClassRoom &obj)
{
    m_id = obj.m_id;
    m_name = obj.m_name;
    m_model = obj.m_model;
}

int ClassRoom::cid() const
{
    return m_id;
}

void ClassRoom::setCid(int id)
{
    if(m_id!=id) {
        m_id = id;
        emit cidChanged();
    }
}

QString ClassRoom::cname() const
{
    return m_name;
}

void ClassRoom::setCname(QString name)
{
    if(m_name!=name) {
        m_name = name;
        emit cnameChanged();
    }
}

StudentModel *ClassRoom::studentmodel() const
{
    return m_model;
}

void ClassRoom::setStudentmodel(StudentModel *model)
{
    if (m_model!=model) {
        m_model = model;
        emit studentmodelChanged();
    }
}

void ClassRoom::startFill()
{
    if (m_model==nullptr) {
        m_model = new StudentModel();
        m_filler = new StudentFiller(this);
        connect(m_filler,&StudentFiller::addStudent,this,&ClassRoom::AddStudent);
        m_filler->start();
    }
}

void ClassRoom::AddStudent()
{
    m_model->AddStudent();
}
