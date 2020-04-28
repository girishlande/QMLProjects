#ifndef DISKFILEMODEL_H
#define DISKFILEMODEL_H

#include <QAbstractListModel>

class DiskFileModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        titleRole = Qt::UserRole + 1,
        nameRole
    };

    explicit DiskFileModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    int count() const;
    void readFile(QString &fileName);

    QHash<int,QByteArray> roleNames() const override;
signals:
    void countChanged();

private:
    QStringList m_list;

};

#endif // DISKFILEMODEL_H
