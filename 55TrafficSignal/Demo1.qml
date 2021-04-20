import QtQuick 2.0
import QtQuick.Controls 2.12

Item {

    Rectangle {
        id:r1
        width: 200
        height: 200
        color: "red"
        anchors.centerIn: parent

        states: [
            State {
                name: "small"
                PropertyChanges {
                    target: r1
                    width: 20
                    height: 20
                    color:"green"
                    radius: 10
                }
            },
            State {
                name: "large"
                PropertyChanges {
                    target: r1
                    width: 800
                    height: 800
                    color:"blue"
                    radius:400
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "small"
                reversible: true
                ParallelAnimation {
                    NumberAnimation {
                        properties:"width,height,radius"
                        duration: 1000
                        easing: Easing.InBounce
                    }
                    ColorAnimation {
                        duration: 1000
                    }
                }
            },
            Transition {
                from: ""
                to: "large"
                reversible: true
                ParallelAnimation {
                    NumberAnimation {
                        properties:"width,height,radius"
                        duration: 1000
                        easing: Easing.InBounce
                    }
                    ColorAnimation {
                        duration: 1000
                    }
                }
            }
        ]
    }

    Row {
        spacing: 10
        anchors.bottom: parent.bottom
        Button {
            text:"TO Small State"
            onClicked: {
                r1.state = "small"
            }
        }
        Button {
            text:"To Normal State"
            onClicked: {
                r1.state = ""
            }
        }
        Button {
            text:"To Large State"
            onClicked: {
                r1.state = "large"
            }
        }
    }
}
