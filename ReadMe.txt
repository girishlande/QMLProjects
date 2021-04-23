
To Expose C++ object to QML you can derive your class from QObject
Then you can expose it using RootContext property OR 
You can expose class type to QML where you can create instance of the type in QML itself. 

Include following header for root context. 

#include <qqmlcontext.h>

 ClassRoomModel cmodel;
 StudentModel smodel;
 qmlRegisterType<ClassRoomModel>("classroom",1,0,"ClassRoomModel");
 qmlRegisterType<StudentModel>("classroom",1,0,"StudentModel");

 QQmlApplicationEngine engine;
 engine.rootContext()->setContextProperty("mystudents",&smodel);
 engine.rootContext()->setContextProperty("myclassrooms",&cmodel);

// ------------------------------------------------------------------
//  For CharView applications you can copy following in main 
// ------------------------------------------------------------------
#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>

int main(int argc, char *argv[])
{
    // Qt Charts uses Qt Graphics View Framework for drawing, therefore QApplication must be used.
    QApplication app(argc, argv);

    QQuickView viewer;
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("QML Chart"));
    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.show();

    return app.exec();
}
