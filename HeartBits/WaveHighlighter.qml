import QtQuick 2.0

Rectangle {
    id: root

    property var startx: 0
    property var endx: 0

    height: parent.height
    width: endx - startx
    visible: endx > startx
    opacity: 0.7
    color: "red"

    Rectangle {
        id:leftBar
        width: 3
        height: parent.height
        color: "darkred"
    }
    Rectangle {
        id:rightBar
        x: parent.width-width
        width: 3
        height: parent.height
        color: "darkred"
    }
}
