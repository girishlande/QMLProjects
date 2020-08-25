import QtQuick 2.12
import QtQuick.Window 2.12
import tablemodel 1.0

Item {
    property var columnWidths: [100, 200, 100, 100]
    property var rowHeights: [50]
    property var colNames: ["Roll","Student Name","Marks","City"]

    anchors.fill: parent

    Row {
        id: headerRow
        spacing: 1
        Repeater {
            model: columnWidths
            delegate: Rectangle {
                width: columnWidths[index]
                height: 50
                color: "green"
                Text {
                    id: name
                    text: colNames[index]
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
            }
        }
    }

    TableView {
        id: tableView

        anchors.top: headerRow.bottom
        anchors.topMargin: 2
        width: root.width
        height: root.height - headerRow.implicitHeight

        columnWidthProvider: function (column) { return columnWidths[column] }
        rowHeightProvider: function(row) { return rowHeights[row]; }

        Rectangle {
            width: parent.width
            height: 50
            z:2
            visible: false
            Text {
                id: header
                text: "A table header"
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }

        columnSpacing: 1
        rowSpacing: 1
        clip: true

        model: TableModel {}

        delegate: Rectangle {
            implicitWidth: 100
            implicitHeight: 50
            color: "orange"
            Text {
                text: display
                anchors.centerIn: parent
                font.pointSize: 16
            }
        }
    }
}
