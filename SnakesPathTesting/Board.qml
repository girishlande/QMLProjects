import QtQuick 2.0

Rectangle {
    id:background
    anchors.fill: parent
    property bool buttonPressed: false
    Row {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            id:leftRect
            width: 1000
            height: 1000
            color: "green"
            border.color: "black"
            border.width: 4
            Image {
                id:boardImg
                source: "qrc:/images/board.jpg"
                opacity: 0.8
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    background.buttonPressed=true;
                }
                onReleased: {
                    background.buttonPressed=false;
                }

                onMouseXChanged: {
                    if (background.buttonPressed) {
                        console.log(mouseX);
                        console.log(mouseY);
                    }
                }
                onMouseYChanged: {
                    if (background.buttonPressed) {
                        console.log(mouseX);
                        console.log(mouseY);
                    }
                }
            }
        }
        Rectangle {
            id:rightRect
            height: parent.height
            width: parent.width - parent.spacing - leftRect.width
            color: "#22b14d"
        }
    }
}
