import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Rectangle {
        anchors.fill: parent

        Image {
            id: board
            source: "image://imageprovider/img"
            width: receiver.width
            height: receiver.height
        }

        Connections {
            target: receiver
            onImageReady: {
                board.source = "image://imageprovider/img?" + Math.random()
            }
        }
    }
}
