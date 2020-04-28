import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Button {
        text: "Change rectangle"
        onClicked: {
            rect.rotation = rect.rotation + 20
            rect.color = "green"
            rect.scale+=0.1
        }
    }

    Rectangle {
        id: rect
        width: 200
        height: 200
        color: "red"
        anchors.centerIn: parent
    }
}
