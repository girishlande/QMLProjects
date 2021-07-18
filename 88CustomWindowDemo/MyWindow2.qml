import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    title: qsTr("Hello World")
    property int titlebar_wrapper_size:30
    flags: Qt.Window | Qt.CustomizeWindowHint // to the title bar

    MouseArea {
        width: parent.width
        height: 25
        property real lastMouseX: 0
        property real lastMouseY: 0
        onPressed: {
            lastMouseX = mouseX
            lastMouseY = mouseY
        }
        onMouseXChanged: root.x += (mouseX - lastMouseX)
        onMouseYChanged: root.y += (mouseY - lastMouseY)
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Rectangle {
        id: mainTitle // Create a title bar
        anchors.top: parent.top // title bar positioning
        anchors.left: parent.left
        anchors.right: parent.right
        height: 25 // Set the height of the title bar
        color: "#00A600" // set the title bar background color
    }
}
