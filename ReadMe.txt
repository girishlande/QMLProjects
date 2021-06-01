
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


// ------------------------------------------------------------------
//  Using different version of library api for controls for qt quick 
// ------------------------------------------------------------------
The reason for your problem is this:

import QtQuick.Controls 1.4
import QtQuick.Controls 2.0

You have a Button in both, but they have a different API.
So at first you import the Button from QtQuick.Controls 1.4. Then you import the Button from QtQuick.Controls 2.0. As QML doesn't know, which one you want to use, it will take the one, you imported the last. If you want to be more specific, on which Button you want to use, you can use named imports

import QtQuick.Controls 1.4 as OldCtrl
import QtQuick.Controls 2.0 as NewCtrl
Then you can use Buttons from both versions as you like:

OldCtrl.Button { // from the QtQuick.Controls 1.4 }
NewCtrl.Button { // from the QtQuick.Controls 2.0 }
The documentation you quote is for QtQuick.Controls 1.x, and from there is the imported ExclusiveGroup. So you are trying to mix things from two libraries, that wont work together.

See ButtonGroup for a similar solution for QtQuick.Controls 2.x
