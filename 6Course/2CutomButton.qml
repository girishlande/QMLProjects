import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: button
        width: 150
        height: 90
        color: "steelblue"
        anchors.centerIn: parent
        radius: 5

        Text {
            id: name
            text: qsTr("Button")
            anchors.centerIn: parent
        }


        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                button.scale=1.2
            }

            onExited: {
                button.scale=1
            }
            onPressed: {
                button.color="lightblue"
            }
            onReleased: {
                button.color= "steelblue"
            }

            onClicked:  {
            }

        }
    }

}
