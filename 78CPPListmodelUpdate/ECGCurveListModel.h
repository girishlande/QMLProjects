#ifndef ECGCurveLISTMODEL_H
#define ECGCurveLISTMODEL_H

#include <QAbstractListModel>
#include <ECGCurve.h>

class ECGCurveListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        IdRole,
        CurvecolorRole,
        CurvevisibleRole
    };

    Q_INVOKABLE void printECGCurves();

    explicit ECGCurveListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;


    int count() const;
    void AddECGCurve(ECGCurve* ECGCurve);
    void RemoveECGCurve(ECGCurve* ECGCurve);

    QHash<int,QByteArray> roleNames() const override {
        return { { NameRole, "name" },
            { IdRole, "roll" },
            { CurvecolorRole, "curvecolor" },
            { CurvevisibleRole, "curvevisible" }
        };
    }
signals:
    void countChanged();

private:
    QList<ECGCurve*> m_ECGCurves;

};

#endif // ECGCurveLISTMODEL_H
