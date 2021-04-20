#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include "user.h"
#include "userlistmodel.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QStringList data;
    data.append("Girish Lande");
    data.append("Ajit Lande");
    data.append("Suhas Lande");

    QList<QObject*> userList;
    userList.append(new User(QString("Rajesh Lande"),QString("red")));
    userList.append(new User(QString("Mahesh Lande"),QString("green")));
    userList.append(new User(QString("Ganesh Lande"),QString("blue")));

    UserListModel *model = new UserListModel();

    engine.rootContext()->setContextProperty("myModel",QVariant::fromValue(data));
    engine.rootContext()->setContextProperty("userModel",QVariant::fromValue(userList));
    engine.rootContext()->setContextProperty("userListModel",model);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
