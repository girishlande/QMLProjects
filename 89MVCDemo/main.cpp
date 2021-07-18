#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "studentviewmodel.h"
#include <qthread.h>
#include <qdebug.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QThread::currentThread()->setObjectName("main thread");
    qInfo() << "Application started :" << QThread::currentThread();
    QGuiApplication app(argc, argv);

    qmlRegisterType<StudentViewModel>("Student",1,0,"Student");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    qInfo() << "main function end:" << QThread::currentThread();
    return app.exec();
}
