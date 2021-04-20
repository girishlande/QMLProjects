import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: 640
    height: Screen.height *.8
    title: qsTr("Color Pallete Demo")

    GColorpallete {
        id: colorpallete
        x:100
        y:100
        //names: ["yellow","steelblue","#3AE6F9","#00ff00"]
        onColorSelected: {
            sample.color = newcolor;
        }
    }

    Rectangle {
        id: sample
        anchors.centerIn: parent
        width: 200
        height: 200
        color: "grey"
    }

}
