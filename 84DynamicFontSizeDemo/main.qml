import QtQuick 2.12
import QtQuick.Window 2.12
import "."

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Component.onCompleted: {
        GameSettings.wWidth = Qt.binding(function() {return width})
        GameSettings.wHeight = Qt.binding(function() {return height})
    }

    Rectangle {
        width: parent.width
        height: parent.height*.1
        color: "steelblue"
        Text {
            width: parent.width
            height: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "GIRISH LANDE"
            font.pixelSize: GameSettings.hugeFontSize

        }
    }
}
