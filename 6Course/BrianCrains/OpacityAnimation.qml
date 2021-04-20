import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: g1.width
    height: g1.height

    title: qsTr("Hello World")

    id: root

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Image {
        id: g1
        source: "qrc:/images/g1.jpg"
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        OpacityAnimator {
            target: g1
            from: 0
            to:1
            duration: 1000
        }
        OpacityAnimator {
            target: g1
            from: 1
            to:0
            duration: 3000
        }
    }

}
