import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ProgressBar {
        id: p1
        from: 0
        to:100
        value: 50
        width: parent.width
        height: 50
        Behavior on value {
            id: b1
            NumberAnimation {
                duration: 250
            }
        }
    }

    Row {
        anchors.bottom: parent.bottom
        Button {
            text: "Increase"
            onClicked: {
                p1.value+=10
                g1.value+=10
            }
        }
        Button {
            text: "Decrase"
            onClicked: {
                p1.value -= 10
                g1.value-=10
            }
        }

        Button {
            text: "Stop"
            onClicked: {
                b1.enabled = !b1.enabled
            }
        }
    }

    GSlider {
        id: g1
        value: 50
        anchors.top: p1.bottom
        orientation: Qt.Horizontal
        sliderlength: parent.width
    }
}
