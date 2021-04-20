#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <fruitclass.h>
#include <drinkclass.h>
#include <vegetableclass.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<FruitClass>("Market",1,0,"Fruit");
    qmlRegisterType<DrinkClass>("Market",1,0,"Drink");
    qmlRegisterType<VegetableClass>("Market",1,0,"Veg");

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
