import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Extras 1.4

Rectangle {
    id: root
    border.color: "black"
    border.width: 2
    property int minValue: 0
    property int maxValue: 100

    Gauge {
        id: gauge

        height: 100
        anchors.leftMargin: 10
        width: root.width - 20
        orientation: Qt.Horizontal

        minimumValue: root.minValue
        maximumValue: root.maxValue
        value: maximumValue


        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 2
                color: "black"
            }

            tickmark: Item {
                implicitWidth: 30
                implicitHeight: 2

                Rectangle {
                    color: "black"
                    anchors.fill: parent
                    anchors.leftMargin: 3
                    anchors.rightMargin: 3
                }
            }

            minorTickmark : Item {
                implicitWidth: 30
                implicitHeight: 2

                Rectangle {
                    color: "gray"
                    anchors.fill: parent
                    anchors.leftMargin: 3
                    anchors.rightMargin: 3
                }
            }

            tickmarkLabel : Text {
                id: label
                text: Math.round(styleData.value)
            }
        }
    }

    AnnotationBar {
        id: bar1
        anchors.top: gauge.bottom
        anchors.topMargin: 10
        width: parent.width - 10
        x: 5
    }

    AdjustableBar {
        id: bar2
        anchors.top: bar1.bottom
        anchors.topMargin: 10
        width: parent.width - 10
        x: 5
    }

    AdjustableBar {
        id: bar3
        anchors.top: bar2.bottom
        anchors.topMargin: 10
        width: parent.width - 10
        x: 5
    }
}
