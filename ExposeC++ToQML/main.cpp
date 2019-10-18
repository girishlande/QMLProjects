#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "qqml.h"
#include "hello.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<Hello>("Greeter", 1, 0, "GreeterComponent");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
