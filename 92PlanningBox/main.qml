import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Rectangle {
        id: view1
        width: parent.width/2
        height: parent.height*.8
        x:100
        y:100
        color: "black"
        border.color: "cyan"

        Rectangle {
            id: view2
            anchors.centerIn: parent
            width: view1.width
            height: view1.height*.6
            color: "cyan"
            opacity: 0.1
        }

        property int count: 20
        property int scanHeight: view2.height/view1.count
        Column {
            anchors.centerIn: view2
            spacing: view1.scanHeight
            Repeater {
                model: view1.count
                Rectangle {
                    width: view2.width
                    height: 2
                    opacity: 0.5
                    color: "cyan"
                }
            }
        }

        Column {
            id: c2
            spacing: -20
            anchors.top: view2.top
            property int blockCount: 1
            Repeater {
                model: c2.blockCount
                Rectangle {
                    width: view1.width - 10
                    x:5
                    height: 100
                    opacity: 0.5
                    color: "blue"
                }
            }
        }
        Row {
            anchors.top: c2.bottom
            anchors.horizontalCenter: c2.horizontalCenter
            Rectangle {
                width: 30
                height: 30
                border.color: "white"
                color: "blue"
                Text {
                    text: qsTr("-")
                    font.bold: true
                    color: "white"
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        c2.blockCount--;
                    }
                }
            }
            Rectangle {
                width: 60
                height: 30
                border.color: "white"
                color: "blue"
                Text {
                    text: qsTr("NM")
                    color: "white"
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
            }

            Rectangle {
                width: 30
                height: 30
                border.color: "white"
                color: "blue"
                Text {
                    text: qsTr("+")
                    font.bold: true
                    color: "white"
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        c2.blockCount++;
                    }
                }
            }

        }
    }


}
