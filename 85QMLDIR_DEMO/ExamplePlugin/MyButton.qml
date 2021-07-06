import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    id: root
    width: 200
    height: 100
    color: "steelblue"
    radius: 20

    signal clicked()

    Text {
        anchors.centerIn: parent
        text: "Hello Girish"
        font.pointSize: 16
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.color="orange"
        onExited: root.color="steelblue"
        onClicked: {
            console.log("Button is clicked");
            root.clicked();
        }
    }
}
