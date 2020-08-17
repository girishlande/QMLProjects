import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Slider Demo")

    QtObject {
        id: gen
        function generate(value) {
            var g = Math.random() * 100
            while(Math.abs(g-value)<20)
                g = Math.random() * 100
            return Math.round(g);
        }
    }

    Row {
        width: parent.width
        Slider {
            id: h1
            width: parent.width -sliderLabel.width
            minimumValue: 0
            maximumValue: 100
            value: 50
        }
        Text {
            id: sliderLabel
            text: Math.round(h1.value)
            font.pointSize: 12
            width: 20
            height: 20
        }
    }

    Column {
        height: parent.height
        Slider {
            id: v1
            orientation: Qt.Vertical
            height: parent.height - sliderLabel2.height
            minimumValue: 0
            maximumValue: 100
            value: 50
        }
        Text {
            id: sliderLabel2
            text: Math.round(v1.value)
            font.pointSize: 12
            width: 20
            height: 20
        }
    }

    Button {
        width: 100
        height: 50
        anchors.centerIn: parent
        text: "UPDATE"
        onClicked: {
            n1.from = h1.value
            n1.to = gen.generate(h1.value)
            n1.start();

            n2.from = v1.value
            n2.to = gen.generate(v1.value)
            n2.start();
        }
    }


    NumberAnimation {
        id: n1
        target: h1
        property: "value"
        duration: 1000
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: n2
        target: v1
        property: "value"
        duration: 1000
        easing.type: Easing.InOutQuad
    }


}
