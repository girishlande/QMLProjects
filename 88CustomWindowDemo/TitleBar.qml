import QtQuick 2.0

Rectangle {
    id:root

    property int titleHeight: 30

    anchors.top: parent.top // title bar positioning
    anchors.left: parent.left
    anchors.right: parent.right

    signal minimize();
    signal close();

    width: parent.width
    height: root.titleHeight
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
        height: titleHeight
        y:0
        width: titleHeight
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
            onEntered: appclose.color="red"
            onExited: appclose.color="cyan"
            onClicked: root.close()
        }
    }
    Rectangle {
        id:appminimize
        height: titleHeight
        y:0
        width: titleHeight
        anchors.right: appclose.left
        anchors.rightMargin: 5
        color: "cyan"
        Text {
            text: '🗕'
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 15
        }
        MouseArea {
            width: parent.width
            height: parent.height
            hoverEnabled: true
            onEntered: appminimize.color="#ddd"
            onExited: appminimize.color="cyan"
            onClicked: root.minimize()
        }
    }

}
