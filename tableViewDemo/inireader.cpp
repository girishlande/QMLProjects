#include "inireader.h"
#include "qsettings.h"
#include "qdebug.h"

IniReader::IniReader(QObject *parent) : QObject(parent)
{

}

void IniReader::readInit(QString path)
{
    QSettings settings(path, QSettings::IniFormat);
    Q_FOREACH (QString group, settings.childGroups()) {
        settings.beginGroup(group);
        const QStringList childKeys = settings.childKeys();

        QStringList Keys;
        QStringList values;

        //qDebug() << "Group";
        //qDebug() << "===============";
        foreach (const QString &childKey, childKeys)
        {
            Keys << childKey;
            values << settings.value(childKey).toString();
            //qDebug() << childKey << " : " << settings.value(childKey).toString();
        }

        settings.endGroup();
    }

}

