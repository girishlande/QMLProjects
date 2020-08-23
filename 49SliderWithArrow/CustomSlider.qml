import QtQuick 2.0
import QtQuick.Layouts 1.12

GridLayout {
    id: root

    width: 200
    height: 40
    rowSpacing: 5
    columnSpacing: 5

    property int thickness: root.width < root.height ? root.width : root.height
    property int length: root.width > root.height ? root.width : root.height
    property alias orientation: slider.orientation
    property alias color: slider.slidercolor
    property alias value: slider.value
    property bool positiveChange: true

    function updateSlider() {
        if(root.positiveChange)
            slider.incrementSlider();
        else
            slider.decrementSlider();
    }

    rows: slider.orientation === Qt.Horizontal ? 1 : 3
    columns: slider.orientation === Qt.Horizontal ? 3 : 1

    ArrowMarker {
        width: root.thickness / 2
        height: root.thickness / 2
        direction: slider.orientation === Qt.Horizontal ? "left" : "up"
        Layout.alignment: slider.orientation === Qt.Horizontal ? Qt.AlignVCenter : Qt.AlignHCenter
        onClicked: slider.decrementSlider()
        iconcolorActive: slider.slidercolor
        onPressAndHold: {
            root.positiveChange = false;
            timer.start();
        }
        onReleased: timer.stop()
    }

    GSlider {
        id: slider
        width: slider.orientation === Qt.Horizontal ? (root.length - root.thickness - root.rowSpacing * 2) : root.thickness
        height: slider.orientation === Qt.Horizontal ? root.thickness : (root.length - root.thickness - root.rowSpacing * 2)
        orientation: Qt.Horizontal
    }

    ArrowMarker {
        width: root.thickness / 2
        height: root.thickness / 2
        direction: slider.orientation === Qt.Horizontal ? "right" : "down"
        Layout.alignment: slider.orientation === Qt.Horizontal ? Qt.AlignVCenter : Qt.AlignHCenter
        onClicked: slider.incrementSlider()
        iconcolorActive: slider.slidercolor
        onPressAndHold: {
            root.positiveChange = true;
            timer.start();
        }
        onReleased: timer.stop()
    }

    Timer {
        id: timer
        repeat: true
        interval: 125
        running: false
        onTriggered: updateSlider()
    }
}
