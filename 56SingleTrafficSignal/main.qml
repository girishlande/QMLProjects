import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("SigleSignal")

    property int counter: 0
    property var signalstates: ["go","ready","stop"]

    Rectangle {
        id: signalPanel
        width: 400
        height: width
        color: "black"
        radius: 20
        anchors.centerIn: parent
        state: "go"

        Rectangle {
            id: trafficsignal
            width: parent.width*0.80
            height: width
            radius: width
            anchors.centerIn: parent
        }

        states: [
            State {
                name: "go"
                PropertyChanges {
                    target: trafficsignal
                    color: "green"
                }
            },
            State {
                name: "ready"
                PropertyChanges {
                    target: trafficsignal
                    color: "yellow"
                }
            },
            State {
                name: "stop"
                PropertyChanges {
                    target: trafficsignal
                    color: "red"
                }
            }
        ]

        transitions: [
            Transition {
                from: "go"
                to: "ready"
                SignalAnimation {}
            },
            Transition {
                from: "ready"
                to: "stop"
                SignalAnimation {}
            },
            Transition {
                from: "stop"
                to: "go"
                SignalAnimation {}
            }
        ]
    }

    Button {
        anchors.bottom: parent.bottom
        text: "StateChange"
        onClicked: {
            if (root.counter==3)
                root.counter = 0;
            else
                root.counter++;
            signalPanel.state = root.signalstates[root.counter];
            console.log("Counter:" + root.counter);
        }
    }

}
