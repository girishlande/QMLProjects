#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <layoutconfigurationmodel.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setOrganizationName("Moose Soft");
    QCoreApplication::setApplicationName("Facturo-Pro");

    QGuiApplication app(argc, argv);

    qmlRegisterType<LayoutConfigurationModel>("MyConfig",1,0,"LayoutConfig");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
