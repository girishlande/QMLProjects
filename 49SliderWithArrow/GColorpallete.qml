import QtQuick 2.0

Rectangle {
    id: root

    property var names: ["red","green","blue","orange","pink","maroon","yellow","steelblue","#3AE6F9","#00ff00"]
    property color palletcolor: "red"

    width: mgrid.implicitWidth + 10
    height: mgrid.implicitHeight + 10
    border.width: 2
    border.color: "black"

    Grid {
        id: mgrid
        anchors.centerIn: parent
        spacing: 2
        rows: 2
        columns: names.length / mgrid.rows
        Repeater {
            model: names
            delegate: Rectangle {
                id: colorRect
                width: 50
                height: 50
                radius: 5
                color: model.modelData

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: colorRect.scale = 1.05
                    onExited: colorRect.scale = 1
                    onClicked: root.palletcolor = colorRect.color
                    onPressed: colorRect.scale = 1
                    onReleased: colorRect.scale = 1.05
                }
            }
        }
    }
}
