import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: radioGroup
    Layout.minimumHeight: 30
    Layout.maximumHeight: 30
    implicitHeight: grid.height//Style.preferredSize * grid.rows + (5 * (grid.rows - 2))
    implicitWidth: grid.width//childrenRect.width//Style.preferredSize * grid.columns + (5 * (grid.columns - 2))


    property alias rows: grid.rows
    property alias columns: grid.columns
    property alias columnSpacing: grid.columnSpacing
    property alias model: repeater.model
    property int index: 0
    property var currentData: model[index]

    property color color: "cyan"
    property color labelColor: "cyan"



    GridLayout{
        id: grid
        columnSpacing: 40
        rowSpacing: 10

        columns: parent.model.length
        rows: 1
        Repeater{
            id: repeater
            RadioButton {
                text: modelData
                active: radioGroup.index == index
                onClicked: radioGroup.index = index
                color: radioGroup.color
                labelColor: radioGroup.labelColor
            }
        }
    }
}

