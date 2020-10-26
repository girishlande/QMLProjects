import QtQuick 2.0

Item {
    anchors.fill: parent

    property int dropWidth: 200
    property int dropHeight: 200

    Row {
        DropArea {
            width: dropWidth; height: dropHeight
            Rectangle {
                anchors.fill: parent
                color: "green"
                opacity: parent.containsDrag ? 1 : 0.5
            }
        }

        DropArea {
            width: dropWidth; height: dropHeight

            Rectangle {
                anchors.fill: parent
                color: "yellow"
                opacity: parent.containsDrag ? 1 : 0.5
            }
        }

        DropArea {
            width: dropWidth; height: dropHeight
            Rectangle {
                anchors.fill: parent
                color: "orange"
                opacity: parent.containsDrag ? 1 : 0.5
            }
        }
    }

    Rectangle {
        x: 10; y: 310
        width: 50; height: 50
        radius: 10
        color: "red"

        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: width/2
        Drag.hotSpot.y: height/2
        Drag.imageSource: "qrc:/images/mario.png"

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
        }
    }
}
