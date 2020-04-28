// Demo of How translation works in QT/QML
======================================
// Please follow these steps to create simple application which can run your application in any language by translating the required 
// text / phrases on the UI 

Create simple application with simple button
give text to that button as "thank you!"
compile and run this to see button in action. 

Now wrap text label of button in qsTr() function in qml file. There is already window title in qsTr() function. you can copy that. 
So your block will look something like

Button {
        text: qsTr("thank you!")
        onClicked: {
            console.log("thank you clicked")
        }
    }

Open main.cpp and include translator class
#include <qtranslator.h>

Load translator file.
QTranslator translator;
translator.load("hellotr_la");
app.installTranslator(&translator);

Now run application. It will have no effect as we don't have translation file in place. 

Now add following line in project file. To indicate our translation file for latin language.
TRANSLATIONS = hellotr_la.ts
you can add more files if you want 

Now open command prompt in project folder. 
run lupdate to generate translation files
>>lupdate -verbose hellotr.pro

this will produce file something as follows
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE TS>
<TS version="2.1" language="la">
<context>
    <name>main</name>
    <message>
        <location filename="main.qml" line="10"/>
        <source>Hello World</source>
        <translation></translation>
    </message>
    <message>
        <location filename="main.qml" line="13"/>
        <source>thank you!</source>
        <translation></translation>
    </message>
</context>
</TS>

Now open linguistic tool using following command. This tool is used by translators to give translated texts.
>>>linguist hellotr_la.ts
Google search translations for give phrases and paste them in tool and save. 

If you now open ts file it will look something as follows. Note the translated text added in <translation> tags. 

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE TS>
<TS version="2.1" language="la">
<context>
    <name>main</name>
    <message>
        <location filename="main.qml" line="10"/>
        <source>Hello World</source>
        <translation>salve mundi</translation>
    </message>
    <message>
        <location filename="main.qml" line="13"/>
        <source>thank you!</source>
        <translation>gratias tibi!</translation>
    </message>
</context>
</TS>


Now run release command in linquistic tool(this is supposed to be run by release manager)
command is File->release
You can optionally give different name to produce different binary file. 
This command will generate .qm file (binary version) for given .ts file. 

Now copy this file in debug/release folder based on which version you are running. 
For eg. for me its 
D:\test\build-translationdemo-Desktop_Qt_5_13_0_MinGW_64_bit-Debug



