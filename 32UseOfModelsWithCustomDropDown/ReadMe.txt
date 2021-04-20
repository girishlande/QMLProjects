How to use models in QT / QML ? 

Create a class by deriving it from QObject / QAbstractList

You can register this class with QML by using Context property or By Using qmlRegisterType() function.

    QQmlApplicationEngine engine;
    qmlRegisterType<Student>("Stud",1,0,"Student");
	
    Student student;
    engine.rootContext()->setContextProperty("student",&student);