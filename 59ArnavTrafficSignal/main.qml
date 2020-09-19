import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 640
    title: qsTr("Hello Arnav !! Here is your Traffic signal!!!")


    property real activealpha: 1.0
    property real inactivealpha: 0.2
    property var signalstates: ["go","ready","stop"]
    property int stateCounter: 0
    property int waitTimer: 10

    Timer {
        id: timer
        running: true
        interval: 500
        repeat: true
        onTriggered: {
            waitTimer--;
            if (waitTimer==-1) {
                waitTimer = 10;
                 stateCounter = (stateCounter+1)%3
            }
        }
    }

    Rectangle {
        width: trafficsignal.width
        height: 50
        color: "black"
        anchors.bottom: trafficsignal.top
        anchors.bottomMargin: 10
        anchors.left: trafficsignal.left

        FontLoader {
            id: fontloader
            source: "qrc:/fonts/digitalnormal.ttf"
        }

        Text {
            id: name
            text:waitTimer
            font.pointSize: 50
            anchors.centerIn: parent
            color: "red"
            font.family: fontloader.name
        }
    }

    Rectangle {
        id: trafficsignal
        width: 150
        height: 400
        color: "black"

        radius: 10
        anchors.centerIn: parent
        state: signalstates[stateCounter]

        Column {
            anchors.centerIn: parent
            spacing: 20
            Rectangle {
                id:redLight
                width: 100
                height: 100
                radius: 100
                color: "red"
            }
            Rectangle {
                id:yellowLight
                width: 100
                height: 100
                radius: 100
                color: "yellow"
            }
            Rectangle {
                id:greenLight
                width: 100
                height: 100
                radius: 100
                color: "green"
            }
        }

        states: [
            State {
                name: "go"
                PropertyChanges { target: redLight; color:Qt.rgba(1,0,0,inactivealpha) }
                PropertyChanges { target: yellowLight; color:Qt.rgba(1,1,0,inactivealpha) }
                PropertyChanges { target: greenLight; color:Qt.rgba(0,1,0,activealpha) }
            },
            State {
                name: "ready"
                PropertyChanges { target: redLight; color:Qt.rgba(1,0,0,inactivealpha) }
                PropertyChanges { target: yellowLight; color:Qt.rgba(1,1,0,activealpha) }
                PropertyChanges { target: greenLight; color:Qt.rgba(0,1,0,inactivealpha) }
            },
            State {
                name: "stop"
                PropertyChanges { target: redLight; color:Qt.rgba(1,0,0,activealpha) }
                PropertyChanges { target: yellowLight; color:Qt.rgba(1,1,0,inactivealpha) }
                PropertyChanges { target: greenLight; color:Qt.rgba(0,1,0,inactivealpha) }
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                ColorAnimation {duration:1000}
            }
        ]
    }

    Rectangle {
        width: 30
        height: 100
        color: "black"

        anchors.horizontalCenter: trafficsignal.horizontalCenter
        anchors.top: trafficsignal.bottom
    }

    Button {
        text: "Change state"
        onClicked: {
            stateCounter = (stateCounter+1)%3
        }
    }

}
