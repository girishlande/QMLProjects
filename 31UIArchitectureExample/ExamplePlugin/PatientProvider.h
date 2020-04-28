#ifndef PATIENTPROVIDER_H
#define PATIENTPROVIDER_H

#include <QQuickItem>
#include "PatientModel.h"
#include "Patient.h"

class PatientProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PatientModel* patientModel READ getPatients)

public:
    PatientProvider(QQuickItem *parent = 0);
    ~PatientProvider();

    PatientModel* getPatients();
    Q_INVOKABLE void fetchMockPatients();
    Q_INVOKABLE void appendPatient();
    Q_INVOKABLE void modifyPatient();

    static QObject *instance(QQmlEngine *engine, QJSEngine *scriptEngine);

private:
    QString m_text;
    PatientModel* m_model;
};

#endif // PATIENTPROVIDER_H
