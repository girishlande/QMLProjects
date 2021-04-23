
#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>
#include <qqmlcontext.h>
#include <pointgenerator.h>

int main(int argc, char *argv[])
{
    PointGenerator pg;

    // Qt Charts uses Qt Graphics View Framework for drawing, therefore QApplication must be used.
    QApplication app(argc, argv);

    QQuickView viewer;
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.engine()->rootContext()->setContextProperty("pointgenerator",&pg);
    qmlRegisterType<PointGenerator>("PointGenerator",1,0,"PointGenerator");

    viewer.setTitle(QStringLiteral("QML Chart"));
    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    //viewer.show();
    viewer.showFullScreen();

    return app.exec();
}
