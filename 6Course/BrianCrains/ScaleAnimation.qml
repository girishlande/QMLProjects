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
        width: 100
        height: 100
        radius: 20
        color: "red"
        anchors.centerIn: parent
        clip: true

        Text {
            text: "SCALE"
            font.pointSize: 35
            anchors.centerIn: parent
            rotation: -45
        }

        SequentialAnimation {
            running: true
            loops: Animation.Infinite

            ScaleAnimator {
                target: r1
                from: 1
                to: 2
                duration: 2000
            }
            ScaleAnimator {
                target: r1
                from: 2
                to: 1
                duration: 2000
            }
        }
    }

}
