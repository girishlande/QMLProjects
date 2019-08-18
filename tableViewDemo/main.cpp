#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "inireader.h"
#include "inimodel.h"
#include "initgroup.h"
#include "qdebug.h"
#include "qqmlcontext.h"
#include "initgroupmodel.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    InitGroupModel groupModel;
    groupModel.ReadFile(":/reformat_presets.ini");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("groupmodel",&groupModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
