import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Traffic signal")

    Rectangle {
        id: signalPanel

        property int signalSize: 100
        property int spacing: 10
        property real activeOpacity: 1
        property real inactiveOpacity: 0.3

        x:100
        y:100
        width: signalSize
        height: signalSize * 3
        color: "black"
        radius: 20
        state: "go"

        Column {
            z:1
            anchors.centerIn: parent
            spacing: signalPanel.spacing
            Rectangle {
                id:r1
                width: signalPanel.signalSize - signalPanel.spacing * 2
                height: width
                radius: signalPanel.signalSize
                color: "red"
            }
            Rectangle {
                id:r2
                width: signalPanel.signalSize - signalPanel.spacing * 2
                height: width
                radius: signalPanel.signalSize
                color: "orange"
            }
            Rectangle {
                id:r3
                width: signalPanel.signalSize - signalPanel.spacing * 2
                height: width
                radius: signalPanel.signalSize
                color: "green"
            }
        }

        states: [
            State {
                name: "stop"
                PropertyChanges { target: r1; opacity: signalPanel.activeOpacity }
                PropertyChanges { target: r2; opacity: signalPanel.inactiveOpacity }
                PropertyChanges { target: r3; opacity: signalPanel.inactiveOpacity }
            },
            State {
                name: "ready"
                PropertyChanges { target: r1; opacity: signalPanel.inactiveOpacity }
                PropertyChanges { target: r2; opacity: signalPanel.activeOpacity }
                PropertyChanges { target: r3; opacity: signalPanel.inactiveOpacity }
            },
            State {
                name: "go"
                PropertyChanges { target: r1; opacity: signalPanel.inactiveOpacity }
                PropertyChanges { target: r2; opacity: signalPanel.inactiveOpacity }
                PropertyChanges { target: r3; opacity: signalPanel.activeOpacity }
            }
        ]

        transitions: [
            Transition {
                from: "stop"
                to: "ready"
                reversible: true
                ParallelAnimation{
                    NumberAnimation { properties: "opacity"; easing: Easing.Linear; duration: 1000 }
                }
            },
            Transition {
                from: "ready"
                to: "go"
                reversible: true
                ParallelAnimation{
                    NumberAnimation { properties: "opacity"; easing: Easing.Linear; duration: 1000 }
                }
            },
            Transition {
                from: "go"
                to: "stop"
                reversible: true
                ParallelAnimation{
                    NumberAnimation { properties: "opacity"; easing: Easing.Linear; duration: 1000 }
                }
            }
        ]
    }

    Row {
        anchors.bottom: parent.bottom
        spacing: 10
        Button {
            text:"Stop"
            onClicked: {
                signalPanel.state = "stop"
            }
        }
        Button {
            text:"ready"
            onClicked: {
                signalPanel.state = "ready"
            }
        }
        Button {
            text:"go"
            onClicked: {
                signalPanel.state = "go"
            }
        }
        Button {
            text: "Timer"
            onClicked: {
                t1.start()
            }
        }
    }


    Timer {
        id:t1
        running: false
        interval: 4000
        onTriggered: {
            signalPanel.state = "ready"
            t2.start();
        }
    }

    Timer {
        id:t2
        running: false
        interval: 2000
        onTriggered: {
            signalPanel.state = "stop"
            t3.start()
        }
    }

    Timer {
        id: t3
        running: false
        interval: 4000
        onTriggered: {
            signalPanel.state = "go"
            t1.start()
        }
    }

}
