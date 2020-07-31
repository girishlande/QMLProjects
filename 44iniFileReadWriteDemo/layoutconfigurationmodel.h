#ifndef LAYOUTCONFIGURATIONMODEL_H
#define LAYOUTCONFIGURATIONMODEL_H

#include <QAbstractListModel>
#include <qvector.h>
#include <qurl.h>
struct LayoutEntry {
    QString title;
    int rows;
    int columns;
    bool readonly;
    QString shortcut;
};

class LayoutConfigurationModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit LayoutConfigurationModel(QObject *parent = nullptr);

    enum roles {
        titleRole = Qt::UserRole+1,
        rowRole,
        ColRole,
        readonlyRole,
        shortcutRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames() const;

    Q_INVOKABLE void readConfigFile(QUrl file);
    Q_INVOKABLE void writeConfigFile(QUrl file);

private:

    QVector<LayoutEntry> m_layouts;
};

#endif // LAYOUTCONFIGURATIONMODEL_H
