import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    property alias text : menuitem.text
    property alias enabled : menuitem.enabled
    signal triggered
    width: menuitem.width
    height: menuitem.height
    MenuItem {
        id: menuitem
        text: qsTr("Zoom Out")
        enabled: flag2
        onTriggered: root.triggered()

        ToolTip {
            parent: menuitem.parent
            visible: menuitem.hovered
            text: "Click to " + menuitem.text
        }
    }

    MouseArea {
        id: menuitemMouseArea
        anchors.fill: menuitem
        hoverEnabled: true
        visible: !menuitem.enabled
    }

    ToolTip {
        id: tooltipHelp
        visible: menuitemMouseArea.containsMouse
        text: "Click to " + menuitem.text
    }

}
