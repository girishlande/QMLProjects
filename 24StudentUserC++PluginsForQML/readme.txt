This project explains how to create C++ plugins for QML

1. Open Qt Creator. New project->Library->Qt Quick 2 Extension plugin

2. Name of project: Student
Object class name: Student
uri: student

This will create student project with 2 classes 
student class derived from QQuickItem and StudentPlugin derived from QQmlExtensionPlugin

It also creates qmldir file which contains 
module <modulename>
plugin <pluginname>

3. When you build this project it will generate library (dll file) inside your project 

4. Now create a parent umbrella folder for this plugin project 
e.g StudentUser
Move your Student project inside this folder.
Create a text file StudentUser.pro and create following content in it. 

TEMPLATE = subdirs
SUBDIRS += \
    student\student.pro

5. Now you open this StudentUser.pro in QtCreator and you should see your plugin project as subproject in this. 

6. Right click on StudentUser project and Add new subproject. 
	Choose Application -> Qt Quick application (Empty)
Name this as "StudentTest"

7. Go to plugin project. Open student.pro file and add destination where dll should get added. 
DESTDIR = ../student

Now if you build your plugin project, plugin dll will get generated in outermost folder. 

8. Now lets use this plugin library dll inside your project. 

9. Open student.h and add couple of properties. 
  Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
  Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

10. Build your plugin project. This will update dll. 
Btw , you don't need to build plugin project everytime, QtCreator will build plugin project before running your application. 
Ofcourse if it finds changes 

11. Now open your application project and update main.cpp with following code. 
Basically what we do here is , by default our application dir will hold exe dir.
for example. 
D:/test/build-pluginDemo-Desktop_Qt_5_13_0_MinGW_64_bit-Debug/StudenTest/debug
We go cd.. cd.. means we go to parent folder. where there is plugin folder student.
and since we have asked plugin project to output library in plugin folder, our QML code 
can find this dll and will be able to access these components happily. 

    QGuiApplication app(argc, argv);
    QString path = app.applicationDirPath().append("/../..");
    app.addLibraryPath(path);
    QQmlApplicationEngine engine;
    engine.addImportPath(path);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();

12. Above code will make sure that you application is referring to the dll code 

13. Open main.qml and add following import statement

import student 1.0

14. After adding above statement it should not show any error in editor as well. 
If this happens it means that your IDE has detected the module and dll in it. 
Now you can add student component 
as follows
Student {
        roll: 11
        name: "Girish"
    }


15. add some button and change property values of this student and put some qdebug messages in c++ code to see that it gets called. 
