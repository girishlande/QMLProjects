import QtQuick 2.0

Grid {
    id: root

    property var names: ["red","green","blue","pink","maroon","lightblue","lightgreen","orange"];
    property var gridItemSize: 50

    property var orientation: Qt.Vertical
    property alias rows: root.rows
    property alias columns: root.columns
    property var selectedColor: names[0]

    signal selected();

    spacing: 2
    rows: 2
    columns: names.length / root.rows

    Repeater {
        model: names
        delegate: Rectangle {
            width: gridItemSize
            height: gridItemSize
            color: modelData
            border.color: "black"
            border.width: root.selectedColor === names[index] ? 2: 0

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.selectedColor = names[index];
                    root.selected();
                }
            }
        }
    }
}
