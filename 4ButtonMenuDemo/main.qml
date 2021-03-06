import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    ButtonMenu {
        id: buttonmenu
        anchors.centerIn: parent
        width: buttonWidthController.value
        visible: true
        clip: true

        menuWidth: width

        onCannedAnnotationSelected: {
            console.log("text selected:"+text)
        }
    }

    Slider {
        id:buttonWidthController
        width: parent.width
        anchors.margins: 20
        anchors.bottom: parent.bottom
        from:1
        to:root.width
        value: root.width/2
        onValueChanged: {
            console.log(buttonWidthController.value)
        }
    }

}
