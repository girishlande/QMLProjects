#include "PatientModel.h"

PatientModel::PatientModel(QObject* parent)
{
    Q_UNUSED(parent);
}

PatientModel::~PatientModel() {
    qDeleteAll(m_patients.begin(), m_patients.end());
    m_patients.clear();
}

void PatientModel::addPatient(Patient *patient) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_patients.append(patient);
    endInsertRows();
}

Patient* PatientModel::getPatient(int index) {
    return m_patients.at(index);
}

int PatientModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_patients.count();
}

QVariant PatientModel::data(const QModelIndex &index, int role) const {
    if (index.row() < 0 || index.row() >= m_patients.count())
        return QVariant();

    Patient* patient = m_patients[index.row()];
    if (role == NameRole)
        return patient->getName();
    else if (role == AgeRole)
        return patient->getAge();
    return QVariant();
}

bool PatientModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (index.row() < 0 || index.row() >= m_patients.count())
        return false;

    if (role == NameRole)
        m_patients[index.row()]->setName(value.toString());
    else if (role == AgeRole)
        m_patients[index.row()]->setAge(value.toInt());

    emit dataChanged(index, index);
    return true;
}

Qt::ItemFlags PatientModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;
    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

QHash<int, QByteArray> PatientModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[AgeRole] = "age";

    return roles;
}
