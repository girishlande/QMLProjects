import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root

    property string direction: "right"
    property color iconcolorActive: "black"
    property color iconcolorInActive: "black"

    signal clicked()
    signal pressAndHold()
    signal released()

    width: 50
    height: 50

    function getRotation() {
        if (root.direction === "up")
            return 270;
        if (root.direction === "down")
            return 90;
        if (root.direction === "left")
            return 180;
        return 0;
    }

    Image {
        id: img
        rotation: getRotation()
        source: "qrc:/images/arrow5.svg"
        fillMode: Image.Stretch
        anchors.fill: parent
    }

    ColorOverlay {
        id: imgColor
        anchors.fill: img
        rotation: getRotation()
        source: img
        color: root.iconcolorInActive
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        hoverEnabled: true
        onEntered: imgColor.color = root.iconcolorActive
        onExited: imgColor.color = root.iconcolorInActive
        onPressAndHold: root.pressAndHold()
        onReleased: root.released()
    }
}
