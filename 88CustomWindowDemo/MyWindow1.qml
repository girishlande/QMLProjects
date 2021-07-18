import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id:root
    title: qsTr("Hello World")
    property int titlebar_wrapper_size:30
    flags: Qt.Window | Qt.CustomizeWindowHint

    MouseArea {
        width: parent.width
        height: titlebar_wrapper_size
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

    Rectangle{
        id:titlebar

        anchors.top: parent.top // title bar positioning
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width
        height: titlebar_wrapper_size
        color: "cyan"

        Text {
            id: titleText
            x:10
            text: qsTr("ECG Display")
            font.pointSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle {
            id:appclose
            height: titlebar_wrapper_size
            y:0
            width: titlebar_wrapper_size
            anchors.right: parent.right
            color: "cyan"
            Text{
                text: "×"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 20
            }
            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: appclose.color="#ddd"
                onExited: appclose.color="cyan"
                onClicked: root.close()
            }
        }
        Rectangle {
            id:appminimize
            height: titlebar_wrapper_size
            y:0
            width: titlebar_wrapper_size
            anchors.right: appclose.left
            anchors.rightMargin: 5
            color: "cyan"
            Text{
                text: '🗕'
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
            }
            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: appminimize.color="#ddd"
                onExited: appminimize.color="cyan"
                onClicked: root.visibility = Window.Minimized
            }
        }

    }

}
