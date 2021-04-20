import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: Screen.height *.8
    height: Screen.height *.8
    title: qsTr("Slider Demo")

    property int imageCount: 0

    Component.onCompleted: imageTimer.start()

    GColorpallete {
        id: colorpallete
        x:100
        y:100
        onColorSelected: mslider.slidercolor = newcolor;
    }

    QtObject {
        id: gen
        function generate(value) {
            var g = Math.random() * 100
            while(Math.abs(g-value)<20)
                g = Math.random() * 100
            return Math.round(g);
        }
    }

    GSlider {
        id: mslider
        sliderlength: parent.width
    }

    Grid {
        rows: 3
        columns: 3
        anchors.centerIn: parent
        spacing: 10
        Button {
            width: 100
            height: 50
            text: "Manul"
            onClicked: mslider.updateValue(gen.generate(mslider.value))
        }

        Button {
            width: 100
            height: 50
            text: "Stop"
            onClicked: imageTimer.stop()
        }
        Button {
            width: 100
            height: 50
            text: "Reset"
            onClicked: {
                root.imageCount =  0;
                imageTimer.restart();
            }
        }

        Button {
            width: 100
            height: 50
            text: "Orientation"
            onClicked: {
                if (mslider.orientation===Qt.Vertical)
                    mslider.orientation = Qt.Horizontal
                else
                    mslider.orientation = Qt.Vertical
            }
        }
    }

    Timer {
        id: imageTimer
        interval: 1000
        repeat: true
        onTriggered: {
            root.imageCount+=10;
            if (root.imageCount<=100) {
                mslider.updateValue(root.imageCount)
            } else if (root.imageCount>100) {
                root.imageCount = 0;
                mslider.updateValue(root.imageCount)
            }
        }
    }

}
