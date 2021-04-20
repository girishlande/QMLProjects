#ifndef CLASSROOM_H
#define CLASSROOM_H

#include <QObject>
#include<qstring.h>

class StudentModel;
class StudentFiller;
class ClassRoom : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(int cid READ cid WRITE setCid NOTIFY cidChanged)
    Q_PROPERTY(QString cname READ cname WRITE setCname NOTIFY cnameChanged)
    Q_PROPERTY(StudentModel* studentmodel READ studentmodel WRITE setStudentmodel NOTIFY studentmodelChanged)

    explicit ClassRoom(QObject *parent = nullptr);

    ClassRoom(int id,QString name);
    ClassRoom(const ClassRoom& obj);

    int cid() const;
    void setCid(int id);

    QString cname() const;
    void setCname(QString name);

    StudentModel *studentmodel() const;
    void setStudentmodel(StudentModel* model);

    Q_INVOKABLE void startFill();

signals:
    void cidChanged();
    void cnameChanged();
    void studentmodelChanged();

public slots:
    void AddStudent();

private:
    int m_id;
    QString m_name;
    StudentModel* m_model = nullptr;
    StudentFiller* m_filler = nullptr;
};

#endif // CLASSROOM_H
