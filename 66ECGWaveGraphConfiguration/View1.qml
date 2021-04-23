import QtQuick 2.0
import QtCharts 2.0
import QtQuick.Controls 2.12

Item {
    id:root

    anchors.fill: parent

    Column {
        anchors.fill: parent

        ChartView1 {
            id: chartView1
            gridvisible: gridCheckbox.checked
            linevisible: lineCheckbox.checked
            labelvisible: labelCheckbox.checked
            yMin: yMinSlider.value
            yMax: yMaxSlider.value
            xTickCount: xTickCountSlider.value
            yTickCount: yTickCountSlider.value
            xMax: xMaxSlider.value
        }
        CheckBox {
            id: gridCheckbox
            text: "Grid"
        }
        CheckBox {
            id: lineCheckbox
            text: "Lines"
        }
        CheckBox {
            id: labelCheckbox
            text: "Labels"
        }
        Row{
            Slider {
                id: xMaxSlider
                from: 1
                value: 100
                to: 1000
                stepSize: 10
                width: root.width * .9
                onValueChanged: {
                    pointgenerator.setMaxXPoints(value);
                }
            }
            Text {
                text: qsTr("X Max:") + xMaxSlider.value
                font.pointSize: 15
            }
        }
        Row{
            Slider {
                id: yMaxSlider
                from: 1
                value: 100
                to: 1000
                stepSize: 10
                width: root.width * .9
            }
            Text {
                text: qsTr("Y Max:") + yMaxSlider.value
                font.pointSize: 15
            }
        }
        Row{
            Slider {
                id: yMinSlider
                from: -1
                value: -100
                to: -1000
                stepSize: 10
                width: root.width * .9
            }
            Text {
                text: qsTr("Y Min:") + yMinSlider.value
                font.pointSize: 15
            }
        }

        Row{
            Slider {
                id: xTickCountSlider
                from: 5
                value: 5
                to: 100
                stepSize: 5
                width: root.width * .9
            }
            Text {
                text: qsTr("X Tick:") + xTickCountSlider.value
                font.pointSize: 15
            }
        }

        Row{
            Slider {
                id: yTickCountSlider
                from: 5
                value: 5
                to: 100
                stepSize: 5
                width: root.width * .9
            }
            Text {
                text: qsTr("Y Tick:") + yTickCountSlider.value
                font.pointSize: 15
            }
        }
    }

}
