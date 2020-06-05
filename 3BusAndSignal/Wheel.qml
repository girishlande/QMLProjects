import QtQuick 2.0

Rectangle {
    id:root
    property int wheelWidth: 50
    property int numSpokes: 3

    function startSpokesAnimation() {
        spokesAnimation.start();
    }

    function stopWheelAnimation() {
        spokesAnimation.stop();
    }

    width: wheelWidth
    height: wheelWidth
    radius: wheelWidth
    color: "yellow"

    Repeater {
        id: spokes
        property int spokeangle: 0
        model: root.numSpokes
        delegate: Rectangle {
            x:root.width/2
            y:0
            height: parent.height
            width: 2
            color: "gray"
            rotation: index * (180/root.numSpokes) + spokes.spokeangle
        }
    }


    NumberAnimation {
        id: spokesAnimation
        target: spokes
        property: "spokeangle"
        duration: 1000
        easing.type: Easing.Linear
        from: 0
        to: 360
        loops:Animation.Infinite
    }
}
