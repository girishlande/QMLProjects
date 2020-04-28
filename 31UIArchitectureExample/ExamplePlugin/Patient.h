#ifndef PATIENT_H
#define PATIENT_H

#include <QString>

class Patient
{
public:
    Patient(QString name = "", int age = 0);
    ~Patient();

    QString getName();
    void setName(QString name);
    int getAge();
    void setAge(int age);

private:
    QString m_name;
    int m_age;
};

#endif // PATIENT_H
