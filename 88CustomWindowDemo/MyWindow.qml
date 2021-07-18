import QtQuick 2.0
import QtQuick.Window 2.12

Window {

    id: root
    width: 500
    height: 400

    flags: Qt.FramelessWindowHint // Disable window frame

    // Declare properties that will store the position of the mouse cursor
    property int previousX
    property int previousY
    property int titleHeight:30

    MouseArea {
        id: topArea
        height: 5
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        // We set the shape of the cursor so that it is clear that this resizing
        cursorShape: Qt.SizeVerCursor

        onPressed: {
            // We memorize the position along the Y axis
            previousY = mouseY
        }

        // When changing a position, we recalculate the position of the window, and its height
        onMouseYChanged: {
            var dy = mouseY - previousY
            root.setY(root.y + dy)
            root.setHeight(root.height - dy)
        }
    }

    // Similar calculations for the remaining three areas of resize
    MouseArea {
        id: bottomArea
        height: 5
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        cursorShape: Qt.SizeVerCursor

        onPressed: {
            previousY = mouseY
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            root.setHeight(root.height + dy)
        }
    }

    MouseArea {
        id: leftArea
        width: 5
        anchors {
            top: topArea.bottom
            bottom: bottomArea.top
            left: parent.left
        }
        cursorShape: Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            root.setX(root.x + dx)
            root.setWidth(root.width - dx)
        }
    }

    MouseArea {
        id: rightArea
        width: 5
        anchors {
            top: topArea.bottom
            bottom: bottomArea.top
            right: parent.right
        }
        cursorShape:  Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            root.setWidth(root.width + dx)
        }
    }

    // The central area for moving the application window
    // Here you already need to use the position both along the X axis and the Y axis
    MouseArea {
        anchors {
            top: topArea.bottom
            left: leftArea.right
            right: rightArea.left
        }
        height: root.titleHeight

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            root.setX(root.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            root.setY(root.y + dy)
        }
    }

}
