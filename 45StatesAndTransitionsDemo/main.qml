import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12

Window {
    id: rootwindow
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")

    property color mred: "#FF0000"
    property color myellow: "#FFFF00"
    property color mgreen: "#66FF00"
    property color mdisabled: "grey"

    function changeSignalState() {
        if (background.state === "stop") {
            background.state = "ready";
        } else if (background.state === "ready") {
            background.state = "go";
        } else if (background.state === "go") {
            background.state = "stop";
        }
    }

    Rectangle {
        id:background
        anchors.fill: parent
        color: "blue"
        state: "stop"

        Rectangle {
            id:road
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 300
            color: "black"

            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 100
                Repeater {
                    model: 15
                    Rectangle {
                        width: 40
                        height: 5
                        color: "white"
                    }
                }
            }
        }

        Rectangle {
            id:signalback
            anchors.bottom: signalRod.top
            anchors.right: parent.right
            anchors.rightMargin: 100
            width: 70
            height: 190
            color: "black"

            Column {
                spacing: 10
                anchors.centerIn: parent

                SignalBlob { id: r1; color: "red" }
                SignalBlob { id: r2; color: "yellow" }
                SignalBlob { id: r3; color: "lightgreen" }
            }
        }

        Rectangle {
            id:signalRod
            height: 100
            width: 5
            color: "black"
            anchors.bottom: road.top
            anchors.horizontalCenter: signalback.horizontalCenter
        }

        states: [
            State {
                name: "stop"
                PropertyChanges {
                    target: r1
                    color:mred
                }
                PropertyChanges {
                    target: r2
                    color:mdisabled
                }
                PropertyChanges {
                    target: r3
                    color:mdisabled
                }
            },
            State {
                name: "ready"
                PropertyChanges {
                    target: r1
                    color:mdisabled
                }
                PropertyChanges {
                    target: r2
                    color:myellow
                }
                PropertyChanges {
                    target: r3
                    color:mdisabled
                }
            },
            State {
                name: "go"
                PropertyChanges {
                    target: r1
                    color:mdisabled
                }
                PropertyChanges {
                    target: r2
                    color:mdisabled
                }
                PropertyChanges {
                    target: r3
                    color:mgreen
                }
            }
        ]

        transitions: Transition {
            ParallelAnimation {
                ColorAnimation { duration: 1000 }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: changeSignalState()
        }
    }

    Timer {
        id: t1
        interval: 2000
        running: true
        repeat: true
        onTriggered: changeSignalState()
    }
}
