#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <student.h>
#include <studentlistmodel.h>
#include <PopupManager.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    StudentListModel studentmodel;
    studentmodel.AddStudent(new Student(12,"Ajit lande"));
    studentmodel.AddStudent(new Student(13,"Suhas Walase"));
    studentmodel.AddStudent(new Student(14,"Sameer Pawar"));
    studentmodel.AddStudent(new Student(12,"Ajit lande"));
    studentmodel.AddStudent(new Student(13,"Suhas Walase"));
    studentmodel.AddStudent(new Student(14,"Sameer Pawar"));

    PopupManager popupmanager;

    engine.rootContext()->setContextProperty("studentmodel",&studentmodel);
    engine.rootContext()->setContextProperty("popupmanager",&popupmanager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
