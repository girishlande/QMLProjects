import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property alias flag1: d1.flag
    property alias flag2: d2.flag
    property alias flag3: d3.flag
    property alias flag4: d4.flag
    property alias flag5: d5.flag


    Rectangle {
        id: flagIndicator
        width: 220
        height: 30
        color: "orange"
        Row {
            spacing: 20
            Dot{
                id:d1
            }
            Dot{
                id:d2
            }
            Dot{
                id:d3
            }
            Dot{
                id:d4
            }
            Dot{
                id:d5
            }
        }
    }


    Rectangle {
        width: 220
        height: 30
        color: "Gray"
        anchors.top: flagIndicator.bottom
        Text {
            id: rLabel
            text: qsTr("Show Popup")
            anchors.centerIn: parent

        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("clicked");
                zoomMenu.open()
            }
        }

        Menu {
            id: zoomMenu

            GMenuItem {
                text: qsTr("Zoom In")
                enabled: flag1
            }

            GMenuItem {
                text: qsTr("Zoom Out")
                enabled: flag2
            }

            GMenuItem {
                text: qsTr("Assign")
                enabled: flag3
            }

            GMenuItem {
                text: qsTr("Lock")
                enabled: flag4
            }

            GMenuItem {
                text: qsTr("Delete")
                enabled: flag5
            }
        }
    }


}
