import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MyProgress2 {
        id: p1
        width: 150
        height: 150
        value: g1.value/100
        primaryColor: "orange"
    }

    Slider {
        id: g1
        width: parent.width
        height: 40
        value: 50
        from: 0
        to: 100
        anchors.top: p1.bottom
        orientation: Qt.Horizontal
    }
}
