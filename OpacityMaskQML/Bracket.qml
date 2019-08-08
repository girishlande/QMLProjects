import QtQuick 2.0

Rectangle {
    id: root
    property int minPosition: 0
    property int maxPosition: 100
    property color slotColor: "black"
    property bool leftPosition: true

    Rectangle {
        id: slot
        height: root.height * .8
        width: root.width * .5
        x: {
            if (root.leftPosition===true)
                return slot.width;
            return 0;
        }
        y: (root.height - slot.height) * .5
        color: root.slotColor
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        MouseArea {
            anchors.fill: parent
            drag.target: root
            drag.axis: Drag.XAxis
            drag.minimumX: root.minPosition
            drag.maximumX: root.maxPosition
        }
    }
}
