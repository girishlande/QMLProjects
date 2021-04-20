import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 800
    height: 600

    title: qsTr("Hello World")

    id: root

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Row {
        spacing: 150
        anchors.centerIn: parent
        Rectangle {
            width: 100
            height: 100
            radius: 100
            scale: 2
            color: "transparent"
            border.color: "red"
            border.width: 20
        }

        Rectangle {
            width: 100
            height: 100
            radius: 100
            scale: 2
            color: "transparent"
            border.color: "red"
            border.width: 20
            antialiasing: false
        }
    }
}
