#include "communicationclass.h"
#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QPluginLoader>

CommunicationClass::CommunicationClass()
{
    if (!loadPlugin()) {
        qDebug()<<"Error loading plugin";
    }
}

QString CommunicationClass::date()
{
    return m_date;
}

void CommunicationClass::setDate(QString date)
{
    m_date = date;
    emit dateChanged();
}

void CommunicationClass::sendTimer()
{
    QString text = timerInterface->timerString();
    setDate(text);
}

bool CommunicationClass::loadPlugin()
{
    QDir pluginsDir(qApp->applicationDirPath());
     if (pluginsDir.dirName().toLower() == "debug" || pluginsDir.dirName().toLower() == "release") {
         pluginsDir.cdUp();
         pluginsDir.cdUp();
     }
     pluginsDir.cd("plugins");


     qDebug()<< pluginsDir;

     foreach (QString fileName, pluginsDir.entryList(QDir::Files)) {
         qDebug()<< fileName;
         QPluginLoader pluginLoader(pluginsDir.absoluteFilePath(fileName));
         QObject *plugin = pluginLoader.instance();
         if (plugin) {
             timerInterface = qobject_cast<TimerInterface *>(plugin);
             if (timerInterface)
                 return true;
         }
     }

     return false;

}
