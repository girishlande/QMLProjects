import QtQuick 2.0


Rectangle {
    id: bus
    property int  windowWidth: 25
    property int numWindow: 4

    function startAnimation() {
        busMoveAnimation.start();
    }

    function startWheelAnimation() {
        w1.startSpokesAnimation();
        w2.startSpokesAnimation();
    }

    function stopWheelAnimation() {
        w1.stopWheelAnimation();
        w2.stopWheelAnimation();
    }

    radius: 5
    width: 200
    height: 100
    color: "red"

    Wheel {
        id: w1
        x: 30
        y: bus.height - height/2
    }

    Wheel {
        id: w2
        x: 130
        y: bus.height - height/2
    }

    Row {
        x:10
        y:20
        spacing: windowWidth
        Repeater {
            model: numWindow
            delegate: Rectangle {
                width: windowWidth
                height: windowWidth
                color: "gray"
            }
        }
    }

    NumberAnimation {
        id: busMoveAnimation
        target: bus
        property: "x"
        duration: 5000
        easing.type: Easing.Linear
        from: 100
        to: root.width - 2*bus.width
        onStarted: {
            bus.startWheelAnimation();
        }

        onStopped: {
            bus.stopWheelAnimation()
        }
    }

}
