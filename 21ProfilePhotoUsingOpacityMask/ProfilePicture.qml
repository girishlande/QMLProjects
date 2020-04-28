import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: root
    width: 200
    height: 200
    color: "transparent"
    property alias source: userImage.source

    Image {
        id: userImage
        anchors.centerIn: parent
        width: root.width
        height: root.height
        fillMode: Image.Stretch
        visible: false
    }

    Rectangle {
        id: maskRect
        anchors.centerIn: parent
        width: root.width
        height: root.height
        radius: root.width
        visible: false
    }

    OpacityMask {
        anchors.fill: userImage
        source: userImage
        maskSource: maskRect
    }
}
