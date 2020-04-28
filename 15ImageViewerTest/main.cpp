#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "imageprovider.h"
#include "imgreceiver.h"
#include "qqmlcontext.h"
#include "diskimgreceiver.h"
#include "imagereceiverfactory.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    ImageReceiverTypes type = NETWORKIMAGE;
    ImgReceiver* receiver = ImageReceiverFactory::getImageReceiver(type);
    ImageProvider *provider = new ImageProvider(receiver);

    QQmlApplicationEngine engine;
    engine.addImageProvider("imageprovider", provider);
    engine.rootContext()->setContextProperty("receiver", receiver);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
