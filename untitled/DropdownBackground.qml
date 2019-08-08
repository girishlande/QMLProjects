import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: root

    property int radius
    property bool squareCornersOnTop: false
    property bool squareCornersOnBottom: false
    property color backgroundColor
    property color borderColor
    property int borderWidth

    visible: true

    implicitWidth: scaledInt(232)
    implicitHeight: scaledInt(44)

    Item {
        id: bg
        anchors.fill: parent
        Item {
            id: bgTopHalf
            anchors.top: parent ? parent.top: undefined
            width: parent.width
            anchors.bottom: parent ? parent.verticalCenter: undefined
            clip: true

            Rectangle {
                id: backgroundRect
                width: parent.width
                height: bg ? bg.height : undefined
                radius: root.squareCornersOnTop ? 0 : root.radius
                antialiasing: true
                color: root.backgroundColor
                border.color: root.borderColor
                border.width: Math.max(1.0, root.borderWidth)
            }
        }
        Item {
            id: bgBottomHalf
            anchors.top: bgTopHalf ? bgTopHalf.bottom : undefined
            anchors.topMargin: root.shadow ? -verticalShadowOffset : 0   // to overlap it with topHalf so that shadow doesnt show up between top and bottom half
            width: parent.width
            anchors.bottom: parent ? parent.bottom : undefined
            clip: true

            Rectangle {
                width: parent.width
                anchors.bottom: bgBottomHalf ? bgBottomHalf.bottom : undefined
                height: bg ? bg.height : undefined
                radius: root.squareCornersOnBottom ? 0 : root.radius
                antialiasing: true
                color: root.backgroundColor
                border.color: root.borderColor
                border.width: Math.max(1.0, root.borderWidth)
            }
        }
    }

}
