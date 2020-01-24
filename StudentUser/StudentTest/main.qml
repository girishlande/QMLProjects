import QtQuick 2.12
import QtQuick.Window 2.12

import student 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Student {
        id: s1
        roll: 11
        name: "Girish"
    }

    Rectangle {
        width: 200
        height: 200
        anchors.centerIn: parent
        color: "red"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked")
                s1.roll = Math.floor(Math.random() * 100)
                s1.name = "name"+s1.roll
            }
        }
    }
}
