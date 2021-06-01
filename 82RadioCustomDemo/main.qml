import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Column {

        RadioButton2 {
            text: "Radio1"
        }
        RadioButton2 {
            text: "Radio2"
        }
        RadioButton2 {
            text: "Radio3"
        }
    }
}
