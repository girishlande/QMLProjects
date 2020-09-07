import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("RowLayout Demo")

    property int rectRadius: 20
    Rectangle {
        anchors.fill: parent
        color: "green"
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        radius: rectRadius
        color: "black"

        RowLayout {
            anchors.fill: parent
            Rectangle {
                id:r1
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: rectRadius
                color: "orange"
            }
            Rectangle {
                id: r2
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                radius: rectRadius
                color: "maroon"
            }

            Rectangle {
                id:r3
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                radius: rectRadius
                color: "lightblue"
                MouseArea {
                    anchors.fill: parent
                    onClicked: r2.visible = !r2.visible
                }
            }
        }
    }
}
