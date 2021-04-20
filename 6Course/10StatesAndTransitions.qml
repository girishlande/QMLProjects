import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: root
        width: 100
        height: 100
        anchors.centerIn: parent
        color: "green"
        radius: 10

        states: [
            State {
                name: "s1"
                PropertyChanges {
                    target: root
                    width: 400
                    height: 400
                    color: "red"
                    radius: 200
                    rotation: 360
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "s1"
                reversible: true
                ParallelAnimation {
                    NumberAnimation { properties: "width,height,radius,rotation"; duration: 2500; easing.type: Easing.InOutQuad }
                    ColorAnimation { duration: 2500 }
                }
            }
        ]

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.state === "s1")
                    root.state = ""
                else
                    root.state = "s1"

            }
        }

    }
}
