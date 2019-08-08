import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

MenuItem {
    id: control
    hoverEnabled: true
    height: scaled(42)

    function scaledInt(size) { return Math.round(scaled(size)) }
    function scaled(size) { return size * 1 }

    indicator: Item {
        height: parent.height
        width: 40

        Rectangle {
            id: bar
            width: scaled(4)
            height: parent.height
            color: "blue"
            visible: checked
        }
    }
}
