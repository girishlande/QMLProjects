This project demonstrates use of Lazy loading in QML. 

We have 3 buttons on the screen. "Fruits" "Drinks" and "Vegetables"

Clicking on these buttons will load corresponding 3 different QML files. 
Each QML file has instace of CPP class object derived from "QObject" and 
exposed to QML using qmlregistertype()

Now you notice the output in console log. 

As you click on the buttons, their corresponding QML gets loaded and at that time underlined
object gets constucted. When you load some different QML, previous QML object gets destroyed.

If you add QML component MyScreen{} then you will see that all objects get created when you 
launch the application. 

SO Point to Note here is that , we should try to use loader and 
dynamic component creation as much as possible. 

