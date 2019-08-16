#include "userlistmodel.h"

UserListModel::UserListModel(QObject *parent)
    : QAbstractListModel(parent)
{

    m_names.append("Girish Lande");
    m_names.append("Ajit Lande");
    m_names.append("Suhas Walase");
    m_cols.append("red");
    m_cols.append("green");
    m_cols.append("blue");
}

QVariant UserListModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

int UserListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return m_names.size();
}

QVariant UserListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_names.size()) {
        return QVariant();
    }

    switch (role) {
    case NameRole:
        return m_names[index.row()];
    case ColorRole:
        return m_cols[index.row()];
    }
    // FIXME: Implement me!
    return QVariant();
}


QHash<int, QByteArray> UserListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ColorRole] = "col";
    return roles;
}

void UserListModel::addItem()
{
    m_names.append("GIRI");
    m_cols.append("RED");
    emit rowCountChanged();
}
