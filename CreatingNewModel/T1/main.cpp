#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <student.h>
#include <studentlistmodel.h>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    StudentListModel studentmodel;
    studentmodel.AddStudent(new Student("Ajit",12));
    studentmodel.AddStudent(new Student("Suhas",23));
    studentmodel.AddStudent(new Student("Sameer",45));
    studentmodel.AddStudent(new Student("Rajesh",55));

    Student s("Girish",12);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("student",&s);
    engine.rootContext()->setContextProperty("studentmodel",&studentmodel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
