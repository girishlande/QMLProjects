import QtQuick 2.12
import QtQuick.Window 2.12
import tablemodel 1.0

Rectangle {
    width: 400
    height: 400
    color: "red"
    anchors.centerIn: parent

    TableView {
        anchors.fill: parent
        columnSpacing: 1
        rowSpacing: 1
        clip: true

        model: TableModel {}

        delegate: Rectangle {
            implicitWidth: 100
            implicitHeight: 50
            color: "yellow"
            Text {
                text: display
                anchors.centerIn: parent
                font.pointSize: 16
            }
        }
    }
}
