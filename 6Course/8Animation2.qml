import QtQuick 2.12
import QtQuick.Window 2.12
import Student 1.0
import QtQuick.Controls 2.4

Window {
    visible: true
    width: Screen.width
    height: 480
    title: qsTr("Hello World")


    ProgressBar {
        id: progressBar
        width: parent.width
        height: 100
        from: 0
        to: 100
        Behavior on value {
            NumberAnimation {
                duration: 250
            }
        }
    }

    Button {
        text: "progress :" + Math.floor(progressBar.value)
    }


    NumberAnimation {
        id: panimation
        target: progressBar
        property: "value"
        duration: 3000
        easing.type: Easing.OutBounce
        from: 0
        to:100
        onEasingChanged: panimation.start();
    }

    Flow {
        width: 400
        height: 400
        spacing: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        MyButton {
            text:"InBounce"
            onClicked: panimation.easing.type = Easing.InBounce
        }
        MyButton {
            text:"OutBounce"
            onClicked: panimation.easing.type = Easing.OutBounce
        }
        MyButton {
            text:"Linear"
            onClicked: panimation.easing.type = Easing.Linear
        }
        MyButton {
            text:"InCubic"
            onClicked: panimation.easing.type = Easing.InCubic
        }
        MyButton {
            text:"InElastic"
            onClicked: panimation.easing.type = Easing.InElastic
        }
        MyButton {
            text:"InSine"
            onClicked: panimation.easing.type = Easing.InSine
        }
    }
}
