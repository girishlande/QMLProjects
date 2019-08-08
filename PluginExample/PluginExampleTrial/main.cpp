#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "communicationclass.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    CommunicationClass comm;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("comm", &comm);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    QObject* home = engine.rootObjects().first();
    QObject::connect(home, SIGNAL(clicked()), &comm, SLOT(sendTimer()));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
