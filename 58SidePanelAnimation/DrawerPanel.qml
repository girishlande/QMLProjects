import QtQuick 2.0

Item {
    id: root

    anchors.fill: parent

    property var panelstates: ["openHorizontal","closeHorizontal","openvertical","closevertical"]
    property int counter: 0
    property int thickness: 200
    property var orientation: Qt.Vertical
    property int stateOffset: orientation == Qt.Vertical ? 0 : 2

    Rectangle {
        id:panel

        x: orientation == Qt.Horizontal ? 0 : -thickness + thickness*0.1
        y: orientation == Qt.Horizontal ? -thickness + thickness*0.1 : 0
        width: orientation == Qt.Horizontal ? parent.width : thickness
        height: orientation == Qt.Horizontal ? thickness : parent.height
        radius: thickness * 0.1
        color: "green"
        state: panelstates[counter]
        MouseArea{
            anchors.fill: parent
            onClicked: {
                counter = (counter+1)%2 + stateOffset
            }
        }

        states: [
            State {
                name: "openvertical"
                PropertyChanges {  target: panel;      y:-thickness*0.1}
            },
            State {
                name: "closevertical"
                PropertyChanges {  target: panel;      y:-thickness + thickness*0.1}
            },
            State {
                name: "openHorizontal"
                PropertyChanges {  target: panel;      x:-thickness*0.1}
            },
            State {
                name: "closeHorizontal"
                PropertyChanges {  target: panel;      x:-thickness + thickness*0.1}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation {
                    properties: "x,y"
                    duration: 500
                }

            }
        ]
    }
}
