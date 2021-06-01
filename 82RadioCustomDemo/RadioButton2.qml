import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

RadioButton {
    id: control
    text: qsTr("RadioButton")
    checked: true
    property var iwidth: 12
    indicator: Rectangle {
        id: outerRing
        implicitWidth: control.iwidth
        implicitHeight: control.iwidth
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: control.width/2
        border.color: control.down ? "#17a81a" : "#21be2b"

        Rectangle {
            id: innerRing
            width: outerRing.implicitWidth/2
            height: width
            x: width/2
            y: width/2
            radius: width/2
            color: control.down ? "#17a81a" : "#21be2b"
            visible: control.checked
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#17a81a" : "#21be2b"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
