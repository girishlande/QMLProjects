import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: Screen.width
    height: 480
    title: qsTr("Hello World")

    id: root

    Rectangle {
        id: r1
        width: 200
        height: 200
        color: "red"
        radius: 20

        Text {
            id: rotationText
            text: Math.round(r1.rotation)
            font.pointSize: 20
            font.bold: true
            anchors.centerIn: parent
        }

        RotationAnimation {
            target: r1
            from: r1.rotation
            to: 360
            loops: Animation.Infinite
            running: true
            duration: 2000
        }

        anchors.centerIn: parent
    }


}
