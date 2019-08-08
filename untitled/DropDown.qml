import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

TextField {
    id: control

    default property alias contentData: menu.contentData
    property alias menu: menu
    property alias dropdownBorderColor: dropdownBackground.borderColor
    property alias dropdownBackgroundColor: dropdownBackground.backgroundColor
    property alias fullTextWidth: textMetrics.advanceWidth
    property alias topMenuPadding: menu.topPadding
    property alias bottomMenuPadding: menu.bottomPadding
    property alias model: menuItemRepeater.model
    property int currentIndex: 0
    property string textRole: "text"


    function scaled(size) { return size * 1 }
    function scaledInt(size) { return Math.round(scaled(size)) }
    function close() { menu.close() }

    QtObject {
        id: internal
        property bool menuOpened: false

        function fieldClckedHandler() {
            if(menuOpened) {
                menu.close()
                menuOpened = false
            } else {
                menu.open()
                menuOpened = true
            }
        }
    }

    implicitWidth: scaled(275)
    readOnly: true
    background.height: scaledInt(44)
    text: control.model && control.textRole ? control.model.get(control.currentIndex)[control.textRole] : ""

    MouseArea {
        anchors.fill: parent
        onClicked: {
            internal.fieldClckedHandler()
        }
    }

    Menu {
        id: menu
        y: control.height
        width: control.width

        topPadding: scaledInt(8)
        bottomPadding: scaledInt(8)

        Repeater {
            id: menuItemRepeater
            delegate: CustomMenuItem {
                id: menuItem
                width: control.width
                text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
                checked: false//control.currentIndex === index
                onClicked: {
                    control.currentIndex = index
                }
            }
        }

        background: DropdownBackground {
            id: dropdownBackground
            radius: scaledInt(4)
            squareCornersOnTop: true
            squareCornersOnBottom: false
            backgroundColor: "gray"
            borderColor: "orange"
            borderWidth: scaledInt(1)
        }
    }

    TextMetrics {
        id: textMetrics
        text: control.text
        font: control.font
    }
}
