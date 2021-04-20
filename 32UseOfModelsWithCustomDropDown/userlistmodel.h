#ifndef USERLISTMODEL_H
#define USERLISTMODEL_H

#include <QAbstractListModel>

class UserListModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum UserRoles {
        NameRole = Qt::UserRole + 1,
        ColorRole
    };

    explicit UserListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void addItem();

signals:
    void rowCountChanged();

private:

    QStringList m_names;
    QStringList m_cols;
};

#endif // USERLISTMODEL_H
