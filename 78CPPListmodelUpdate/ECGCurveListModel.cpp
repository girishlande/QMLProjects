#include "ECGCurvelistmodel.h"
#include <qdebug.h>

void ECGCurveListModel::printECGCurves()
{
    qDebug() << "All ECGCurve information";

    for(auto a:m_ECGCurves) {
        a->print();
    }
}

ECGCurveListModel::ECGCurveListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}


int ECGCurveListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return count();
}

QVariant ECGCurveListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() < 0 || index.row() >= m_ECGCurves.size()) {
        return QVariant();
    }

    ECGCurve* s = m_ECGCurves.at(index.row());

    switch (role) {
    case NameRole: return QVariant::fromValue(s->name());
    case IdRole: return QVariant::fromValue(s->id());
    case CurvecolorRole: return QVariant::fromValue(s->curvecolor());
    case CurvevisibleRole: return QVariant::fromValue(s->curvevisible());
    default: return QVariant();
    }
}

bool ECGCurveListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    ECGCurve* s = m_ECGCurves.at(index.row());
    if (data(index, role) != value) {
        switch (role) {
        case NameRole: s->setName(value.toString()); break;
        case IdRole: s->setId(value.toInt()); break;
        case CurvecolorRole: s->setCurvecolor(value.toString());break;
        case CurvevisibleRole: s->setCurvevisible(value.toBool()); break;
        }
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ECGCurveListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

void ECGCurveListModel::AddECGCurve(ECGCurve *ECGCurve)
{
    beginInsertRows(QModelIndex(), m_ECGCurves.size(), m_ECGCurves.size());
    m_ECGCurves.push_back(ECGCurve);
    endInsertRows();

    emit countChanged();
}

void ECGCurveListModel::RemoveECGCurve(ECGCurve *ECGCurve)
{
    return;
}

int ECGCurveListModel::count() const
{
    return m_ECGCurves.count();
}
