import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {
    id:root

    property int sliderlength: root.orientation == Qt.Horizontal ? root.width : root.height
    property int sliderthickness: root.orientation == Qt.Horizontal ? root.height : root.width
    property color slidercolor: "cyan"
    property color backgroundcolor: "gray"

    function incrementSlider() {
        var temp = root.value + root.stepSize;
        if (temp < root.maximumValue)
            root.value = temp;
        else
            root.value = root.maximumValue;
    }

    function decrementSlider() {
        var temp = root.value - root.stepSize;
        if (temp > root.minimumValue)
            root.value = temp;
        else
            root.value = root.minimumValue;
    }

    width: 200
    height: 20
    minimumValue: 0
    maximumValue: 100
    stepSize: 1
    value: 50
    orientation: Qt.Horizontal
    rotation: orientation == Qt.Vertical ? 180 : 0

    style: SliderStyle {
        groove: Rectangle {
            id: grooveRectangle
            implicitWidth: root.sliderlength
            implicitHeight: root.sliderthickness / 2
            color: "transparent"
            radius: root.width / 4
            border {
                width: 2
                color: root.backgroundcolor
            }

            Rectangle {
                width: (root.value / root.maximumValue) * root.sliderlength
                height: root.sliderthickness / 2
                radius: root.sliderthickness / 4
                color: root.slidercolor
            }
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: root.backgroundcolor
            radius: root.sliderthickness / 8
            implicitWidth: root.sliderthickness / 2
            implicitHeight: root.sliderthickness
        }
    }
}
