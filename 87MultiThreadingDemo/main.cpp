#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include<taskmanager.h>
#include <qqmlcontext.h>
#include<QDebug>
#include <QThread>
#include <QScopedPointer>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QThread::currentThread()->setObjectName("main thread");
    qInfo() << "Main started:" << QThread::currentThread();

    QGuiApplication app(argc, argv);

    TaskManager t1;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.rootContext()->setContextProperty("taskmanager",&t1);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
