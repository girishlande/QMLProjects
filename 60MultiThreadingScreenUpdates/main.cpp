#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "classroommodel.h"
#include "studentmodel.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    ClassRoomModel cmodel;
    StudentModel smodel;

    qmlRegisterType<ClassRoomModel>("classroom",1,0,"ClassRoomModel");
    qmlRegisterType<StudentModel>("classroom",1,0,"StudentModel");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mystudents",&smodel);
    engine.rootContext()->setContextProperty("myclassrooms",&cmodel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
