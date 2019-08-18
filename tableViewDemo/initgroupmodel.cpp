#include "initgroupmodel.h"
#include "qsettings.h"
#include "qdebug.h"
#include "initgroup.h"

InitGroupModel::InitGroupModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

QVariant InitGroupModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

int InitGroupModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return count();
    // FIXME: Implement me!
}


bool InitGroupModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
}

void InitGroupModel::AddGroup(InitGroup *group)
{
    beginInsertRows(QModelIndex(), m_groups.size(), m_groups.size());
    m_groups.push_back(group);
    endInsertRows();

    emit countChanged();
}


void InitGroupModel::ReadFile(QString path)
{
    //IniReader* reader = new IniReader();
    //reader->readInit("D:/Indraneel/reformat_presets.ini");

    QSettings settings(path, QSettings::IniFormat);
    Q_FOREACH (QString group, settings.childGroups()) {
        settings.beginGroup(group);
        const QStringList childKeys = settings.childKeys();

        QStringList Keys;
        QStringList values;

        //qDebug() << "Group";
        //qDebug() << "===============";
        InitGroup *g = new InitGroup;
        foreach (const QString &childKey, childKeys)
        {
            Keys << childKey;
            values << settings.value(childKey).toString();
            //qDebug() << childKey << " : " << settings.value(childKey).toString();

            g->AddKeyValuePair(childKey,settings.value(childKey).toString());
        }
        AddGroup(g);

        settings.endGroup();
    }
}


int InitGroupModel::count() const
{
    return m_groups.count();
}

QHash<int,QByteArray> InitGroupModel::roleNames() const {
    return {
        { titleRole, "title" },
        { thicknessRole, "thickness" },
        { incrementRole, "increment" },
        { planeRole, "plane" },
        { typeRole, "type" },
        { imgCountRole, "imgcount" },
        { planningVPRole, "planningvp" },
        { arcDesRole, "arcdes" }
    };
}

QVariant InitGroupModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() < 0 || index.row() >= m_groups.size()) {
        return QVariant();
    }

    InitGroup* s = m_groups.at(index.row());

    switch (role) {
    case titleRole: return QVariant::fromValue(s->title());
    case thicknessRole: return QVariant::fromValue(s->thickness());
    case incrementRole: return QVariant::fromValue(s->increment());
    case planeRole: return QVariant::fromValue(s->plane());
    case typeRole: return QVariant::fromValue(s->type());
    case imgCountRole: return QVariant::fromValue(s->imgCount());
    case planningVPRole: return QVariant::fromValue(s->planningVP());
    case arcDesRole: return QVariant::fromValue(s->arcDes());
    default: return QVariant();
    }
}
