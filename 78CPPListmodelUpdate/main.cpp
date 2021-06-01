#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include <ECGCurve.h>
#include <ECGCurveListModel.h>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    ECGCurveListModel ECGCurvemodel;
    ECGCurvemodel.AddECGCurve(new ECGCurve("LEAD-I",1,"Green",true));
    ECGCurvemodel.AddECGCurve(new ECGCurve("LEAD-II",2,"Gold",true));
    ECGCurvemodel.AddECGCurve(new ECGCurve("LEAD-III",3,"Teal",true));
    ECGCurvemodel.AddECGCurve(new ECGCurve("LEAD-IV",4,"Red",true));
    ECGCurvemodel.AddECGCurve(new ECGCurve("DELAY TRIGGER",5,"Brown",true));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("ECGCurvemodel",&ECGCurvemodel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
