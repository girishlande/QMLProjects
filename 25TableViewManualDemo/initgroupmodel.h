#ifndef INITGROUPMODEL_H
#define INITGROUPMODEL_H

#include <QAbstractListModel>
#include <initgroup.h>

class InitGroupModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum Roles {
        titleRole = Qt::UserRole + 1,
        thicknessRole,
        incrementRole,
        planeRole,
        typeRole,
        imgCountRole,
        planningVPRole,
        arcDesRole
    };

    explicit InitGroupModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    int count() const;
    void AddGroup(InitGroup* student);
    void ReadFile(QString path);

    QHash<int,QByteArray> roleNames() const override;

signals:
    void countChanged();

private:
    QList<InitGroup*> m_groups;
};

#endif // INITGROUPMODEL_H
