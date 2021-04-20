import QtQuick 2.0

Item {
    id: root
    property int animduration: 15000
    property int wheelSpeed: 2000

    Image {
        id: bus
        width: 200
        height: 100
        source: "qrc:/images/bus.jpg"
        x: parent.width - bus.width

        Image {
            id: frontwheel
            source: "qrc:/images/wheel.png"
            width: 40
            height: 40
            x: 30
            y: bus.height - frontwheel.height
        }

        Image {
            id: backwheel
            source: "qrc:/images/wheel.png"
            width: 40
            height: 40
            x: bus.width - 70
            y: bus.height - frontwheel.height
        }
    }

    Rectangle {
        id: road
        width: parent.width
        height: 100
        color: "black"
        y:bus.height + bus.y
        MouseArea {
            anchors.fill: parent
            onClicked: {
                sceneanimation.start();
            }
        }
    }

    ParallelAnimation {
        id: sceneanimation

        NumberAnimation {
            id: busAnimation
            target: bus
            property: "x"
            to: 0
            duration: root.animduration
            easing.type: Easing.Linear
        }


        NumberAnimation {
            id: frontwheelrotation
            target: frontwheel
            property: "rotation"
            duration: root.wheelSpeed
            loops: Animation.Infinite
            from: 360
            to: 0
            easing.type: Easing.Linear
        }

        NumberAnimation {
            id: backwheelrotation
            target: backwheel
            property: "rotation"
            duration: root.wheelSpeed
            loops: Animation.Infinite
            from: 360
            to: 0
            easing.type: Easing.Linear
        }
    }

}
