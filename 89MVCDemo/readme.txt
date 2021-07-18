This project shows how MVC(Model View Controller) works in C++ using QML

There will be UI in plain QML
There will be viewmodel in CPP
There will be datamodel in CPP.

Viewmodel will have properties and functions which will be exposed to QML.
Viewmodel is the interface through which UI will talk to the backend 
Datamodel will have the actual data. 
Signals of data changed are emitted by data model. 
These signals are connected to the viewmodel signals and hence whenever data is changed in datamodel then 
signals will be emitted by datamodel. These signals will be forwarded by viewmodel to qml and hence if 
QML has some fields which show the data it will be updated automatically 