import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12

Window {
    id: root
    visible: true
    width: Screen.width * .8
    height: Screen.height * .8
    title: qsTr("Custom Slider with Arrows")

    property color scolor: "maroon"
    property bool flag: true

    Column {
        spacing: 20
        visible: root.flag
        CustomSlider {
            id: c1
            width: root.width
            height: 40
            orientation: Qt.Horizontal
            color: root.scolor
            onValueChanged: c2.value = c1.value
        }
        CustomSlider {
            id: c2
            width: root.width
            height: 40
            orientation: Qt.Horizontal
            color: root.scolor
            onValueChanged: c1.value = c2.value
        }
    }

    Row {
        spacing: 20
        visible: !root.flag
        CustomSlider {
            id: r1
            height: root.height
            width: 40
            orientation: Qt.Vertical
            color: root.scolor
            onValueChanged: r2.value = value
        }
        CustomSlider {
            id:r2
            height: root.height
            width: 40
            orientation: Qt.Vertical
            color: root.scolor
            onValueChanged: r1.value = value
        }
    }

    Button {
        text:"orientation"
        width: 200
        height: 50
        anchors.centerIn: parent
        onClicked: {
            root.flag = !root.flag
        }
    }

    GColorpallete {
        id: pallete
        x: root.width - width
        y: root.height - height
        onPalletcolorChanged: root.scolor = palletcolor
    }
}
