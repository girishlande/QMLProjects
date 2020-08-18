import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {
    id: root

    property color slidercolor: "#ff0000"
    property color backgroundcolor: "gray"
    property int sliderthickness: 15
    property int sliderlength: 300
    property bool horizontal: root.orientation === Qt.Horizontal
    property bool vertical: root.orientation === Qt.Vertical

    function updateValue(newvalue) {
        animator.from = root.value
        animator.to = newvalue;
        animator.start();
    }

    orientation: Qt.Horizontal
    width: root.horizontal ? root.sliderlength : root.sliderthickness * 2
    height: root.vertical ? root.sliderlength : root.sliderthickness * 2
    minimumValue: 0
    maximumValue: 100
    value: 50
    rotation: root.vertical ? 180 : 0

    style: SliderStyle {
        groove: Rectangle {
            id: grooveRectangle
            implicitWidth: root.sliderlength
            implicitHeight: root.sliderthickness
            color: root.backgroundcolor
            radius: 8

            Rectangle {
                property int filllength: (root.value / root.maximumValue) * root.sliderlength
                width: filllength
                height: root.sliderthickness
                radius: root.sliderthickness / 2
                color: root.slidercolor
            }
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: control.pressed ? "white" : "lightgray"
            border.color: "gray"
            border.width: 2
            implicitWidth: 15
            implicitHeight: 25
            radius: 12
        }
    }

    NumberAnimation {
        id: animator
        target: root
        property: "value"
        duration: 500
        easing.type: Easing.InOutQuad
    }
}
