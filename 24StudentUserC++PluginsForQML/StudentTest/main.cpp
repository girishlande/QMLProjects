#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QString path = app.applicationDirPath().append("/../..");
    app.addLibraryPath(path);

    QQmlApplicationEngine engine;
    engine.addImportPath(path);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
