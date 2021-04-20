#include "layoutconfigurationmodel.h"
#include "qsettings.h"
#include <qdebug.h>

LayoutConfigurationModel::LayoutConfigurationModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_layouts.append(LayoutEntry{"1x1",1,1,true,"CTRL+D"});
    m_layouts.append({"2x1",2,1,true,"CTRL+R"});
    m_layouts.append({"3x1",3,1,true,"CTRL+E"});
}

int LayoutConfigurationModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_layouts.count();
}

QVariant LayoutConfigurationModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    LayoutEntry entry = m_layouts[index.row()];
    switch(role) {
    case titleRole: return QVariant(entry.title);
    case rowRole: return QVariant(entry.rows);
    case ColRole: return QVariant(entry.columns);
    case readonlyRole: return QVariant(entry.readonly);
    case shortcutRole: return QVariant(entry.shortcut);
    }
    return QVariant();
}

bool LayoutConfigurationModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    LayoutEntry entry = m_layouts[index.row()];
    switch (role) {
    case titleRole: entry.title = value.toString();break;
    case rowRole: entry.rows = value.toInt(); break;
    case ColRole: entry.columns = value.toInt(); break;
    case readonlyRole: entry.readonly = value.toBool(); break;
    case shortcutRole: entry.shortcut = value.toString(); break;
    default:
        break;
    }

    if (data(index, role) != value) {
        m_layouts[index.row()] = entry;

        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags LayoutConfigurationModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> LayoutConfigurationModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[titleRole] = "stitle";
    roles[rowRole] = "srow";
    roles[ColRole] = "scolumn";
    roles[readonlyRole] = "sreadonly";
    roles[shortcutRole] = "sshortcut";
    return roles;
}

#include <qfile.h>
void LayoutConfigurationModel::readConfigFile(QUrl file)
{
    qDebug() << "GIrish:readConfigFile()";

    QFile qfile(file.toLocalFile());
    if (qfile.exists()) {
        qDebug() << "File exists";
    } else {
        qDebug() << "File doesn't exist";
    }

    QSettings settings(file.toLocalFile(), QSettings::IniFormat);
    QStringList groups = settings.childGroups();

    beginResetModel();
    m_layouts.clear();
    foreach(QString group, groups)
    {
        settings.beginGroup(group);

        QString title = settings.value("title").toString();
        int columnB = settings.value("columnB").toInt();
        int columnC = settings.value("columnC").toInt();
        bool readOnly = settings.value("readOnly").toBool();
        QString shortCut = settings.value("shortCut").toString();

        m_layouts.append(LayoutEntry{title,columnB,columnC,readOnly,shortCut});
        settings.endGroup();
    }
    endResetModel();
}

void LayoutConfigurationModel::writeConfigFile(QUrl file)
{
    qDebug() << "GIrish:writeConfigFile()";
    QFile qfile(file.toLocalFile());
    if (qfile.exists()) {
        qDebug() << "File exists";
        QFile::remove(file.toLocalFile());
    } else {
        qDebug() << "File doesn't exist";
    }

    QSettings settings(file.toLocalFile(), QSettings::IniFormat);
    for(int i=0; i<m_layouts.size();i++)
    {
        LayoutEntry layout = m_layouts[i];
        settings.beginGroup(tr("%0").arg(i));
        settings.setValue("title", layout.title);
        settings.setValue("columnB", layout.rows);
        settings.setValue("columnC", layout.columns);
        settings.setValue("readOnly", layout.readonly);
        settings.setValue("shortCut", layout.shortcut);
        settings.endGroup();
    }
}
