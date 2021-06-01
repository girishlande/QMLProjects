#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>
#include <qqmlcontext.h>

#include "WaveViewModel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //qmlRegisterType<ECGViewModel>("ECGViewModel",1,0,"ECGViewModel");

    qmlRegisterType<WaveViewModel>("WaveViewModel", 1, 0, "WaveViewModel");

    QQuickView viewer;
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("QML Chart"));
    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.show();

    return app.exec();
}
