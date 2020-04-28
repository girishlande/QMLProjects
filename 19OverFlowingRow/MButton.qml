import QtQuick 2.0
import QtQuick.Controls 2.4

Rectangle {
    id:root
    property alias text: name.text
    property alias font: name.font
    signal clicked();

    height: 40
    width: 10
    color: "orange"
    Text {
        id: name
        anchors.centerIn: parent
        text: qsTr("text")
        font.pointSize: 20
        font.letterSpacing: 5
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked();
        }
    }
}
