import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window {
    id: root
    visible: true
    width: 640
    height: 480
    signal clicked()


    Label {
        id: myLabel
        width: parent.width
        height: 50
        text: "Timer Plugin Example"
        font.pixelSize: 22
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "red"
        background: Rectangle {
            anchors.fill: parent
            color: "black"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }

    Label {
        id: dateLabel
        anchors.centerIn: parent
        text: comm.date
        font.pixelSize: 22
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "Blue"
        background: Rectangle {
            anchors.fill: parent
            color: "black"
        }
    }
}
