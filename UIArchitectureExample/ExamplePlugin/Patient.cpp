#include "Patient.h"

Patient::Patient(QString name, int age):
    m_name(name), m_age(age) {}

Patient::~Patient() {}

QString Patient::getName() {
    return m_name;
}

void Patient::setName(QString name) {
    m_name = name;
}

int Patient::getAge() {
    return m_age;
}

void Patient::setAge(int age) {
    m_age = age;
}
