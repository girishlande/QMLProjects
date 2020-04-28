#ifndef PATIENTMODEL_H
#define PATIENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <Patient.h>

class PatientModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PatientRoles {
        NameRole = Qt::UserRole + 1,
        AgeRole
    };

    PatientModel(QObject* parent = 0);
    ~PatientModel();

    void addPatient(Patient *patient);
    Patient* getPatient(int index);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);
    Qt::ItemFlags flags(const QModelIndex &index) const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Patient*> m_patients;
};

#endif // PATIENTMODEL_H
