#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "filehandler.h"
#include "QStringListModel"
#include "qqmlcontext.h"
#include "qdebug.h"
#include "diskfilemodel.h"

void writeFile() {
    FileHandler handler;
    QString filePath("D://input.txt");
    handler.writeFile(filePath);
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //writeFile();

    QStringListModel diskFileModel;
    QStringList list;
    FileHandler handler;
    QString filePath("D://input.txt");
    handler.readFile(filePath,list);
    diskFileModel.setStringList(list);
    qDebug() << "list size:" << list.count();

    DiskFileModel fileModel;
    fileModel.readFile(filePath);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("linesmodel",&fileModel);
    engine.rootContext()->setContextProperty("myModel",QVariant::fromValue(list));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
