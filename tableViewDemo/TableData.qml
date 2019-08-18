import QtQuick 2.0

Column {

    spacing: 5
    Repeater {

        model:groupmodel
        Rectangle {
            id:rowRect
            width: 1600
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
