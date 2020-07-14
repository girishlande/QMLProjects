import QtQuick 2.0
import QtQuick.Controls 2.4

Popup {
    x: 100
    y: 100
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    visible: false

    Rectangle {
        anchors.fill: parent
        color: "green"
    }

}
