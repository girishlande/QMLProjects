import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ColumnLayout {
    id: repeater

    readonly property var gripperIconHeight: scaledInt(7)

    function scaled(size) { return size * 1 }
    function scaledInt(size) { return Math.round(size * 1) }

    spacing: -scaledInt(4)

    Repeater {
        id: gripperIconRepeater
        model: (repeater.height / gripperIconHeight)

        RowLayout {
            id: iconRow
            spacing: -scaledInt(4)

            Image {
                source: "qrc:/icons/gripper.svg"
                opacity: scaled(0.3)
                sourceSize: Qt.size(scaledInt(10), scaledInt(10))
            }

            Image {
                source: "qrc:/icons/gripper.svg"
                opacity: scaled(0.3)
                sourceSize: Qt.size(scaledInt(10), scaledInt(10))
            }
        }
    }
}
