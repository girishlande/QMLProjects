import QtQuick 2.0

Column {
    id: root
    width: parent.width
    spacing: 5

    Repeater {

        model:groupmodel

        Rectangle {
            id:rowRect

            width: root.width
            height: rowRectMouseArea.containsMouse ? 54 : 50
            color: rowRectMouseArea.containsMouse ? "blue" : (index%2==0 ? "orange" : "green")

            TableRow{}
            MouseArea {
                id:rowRectMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }
}
