import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 800
    title: qsTr("Hello World")

    property var signalstates: ["go","ready","stop"]
    property int counter: 0
    property int timerValue: 15

    function changeState() {
        counter = (counter+1)%3;
        trafficsignal.state = signalstates[counter];
    }

    Rectangle {
        id: counterRect
        width: trafficsignal.width
        height: 100
        radius: 20
        color: "black"
        anchors.left: trafficsignal.left
        anchors.bottom: trafficsignal.top
        anchors.bottomMargin: 10

        FontLoader { id: digitalFont; source: "qrc:/fonts/digitalnormal.ttf" }

        Text {
            id: counterLabel
            text: timerValue
            font.pointSize: 50
            font.bold: true
            font.family: digitalFont.name
            color: "red"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id:trafficsignal
        width: 150
        height: 400
        radius: 20
        color: "black"
        anchors.centerIn: parent
        state: "go"

        Column {
            anchors.centerIn: parent
            spacing: 20
            Rectangle {
                id:redLight
                width: 100
                height: 100
                color: "red"
                radius: width
            }
            Rectangle {
                id:yellowLight
                width: 100
                height: 100
                color: "yellow"
                radius: width
            }
            Rectangle {
                id:greenLight
                width: 100
                height: 100
                color: "green"
                radius: width
            }
        }

        states: [
            State {
                name: "go"

                PropertyChanges {    target: redLight;  color:"gray" }
                PropertyChanges {    target: yellowLight;  color:"gray" }
                PropertyChanges {    target: greenLight;  color:"green" }
            },
            State {
                name: "ready"
                PropertyChanges {    target: redLight;  color:"gray" }
                PropertyChanges {    target: yellowLight;  color:"yellow" }
                PropertyChanges {    target: greenLight;  color:"gray" }
            },
            State {
                name: "stop"
                PropertyChanges {    target: redLight;  color:"red" }
                PropertyChanges {    target: yellowLight;  color:"gray" }
                PropertyChanges {    target: greenLight;  color:"gray" }
            }
        ]

        transitions: [
            Transition {
                from: "go"
                to: "ready"
                ColorAnimation {
                    duration: 1000
                }
            },
            Transition {
                from: "ready"
                to: "stop"
                ColorAnimation {
                    duration: 1000
                }
            },
            Transition {
                from: "stop"
                to: "go"
                ColorAnimation {
                    duration: 1000
                }
            }
        ]
    }

    Button {
        text: "Change state"
        onClicked: {
            changeState()
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            timerValue--;
            if (timerValue==0) {
                timerValue = 10;
                changeState();
            }
        }
    }
}
