import QtQuick 2.0

DropArea {
    id: dragTarget

    property string colorKey
    property alias dropProxy: dragTarget

    width: 64; height: 64
    keys: [ colorKey ]

    Rectangle {
        id: dropRectangle

        anchors.fill: parent
        color: dragTarget.colorKey

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: dropRectangle
                    color: "grey"
                }
            }
        ]
    }
}
