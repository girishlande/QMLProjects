#include "PatientProvider.h"

PatientProvider::PatientProvider(QQuickItem *parent):
    QObject(parent)
{
    m_model = new PatientModel();
}

PatientProvider::~PatientProvider()
{
    delete m_model;
}

PatientModel *PatientProvider::getPatients() {
    return m_model;
}

void PatientProvider::fetchMockPatients() {
    // Would be call to fetch data from data access services in real code

    m_model->addPatient(new Patient("Patient 1", 20));
    m_model->addPatient(new Patient("Patient 2", 21));
    m_model->addPatient(new Patient("Patient 3", 22));
    m_model->addPatient(new Patient("Patient 4", 23));
}

void PatientProvider::appendPatient() {
    Patient* newPatient = new Patient(QString("Patient ").append(QString::number(m_model->rowCount()+1)), 24);
    m_model->addPatient(newPatient);
}

void PatientProvider::modifyPatient() {
    Patient* pat = m_model->getPatient(0);
    pat->setName("NEW NAME");
    emit m_model->dataChanged(m_model->index(0), m_model->index(0));
}

QObject *PatientProvider::instance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new PatientProvider;
}
