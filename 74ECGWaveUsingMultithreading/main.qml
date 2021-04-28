import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import PointGenerator 1.0

Item {
    id: root
    width: Screen.width
    height: Screen.height


    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"

        Rectangle {
            id: backRect
            anchors.right: backgroundRect.right
            width: parent.width*.85
            height: parent.height
            color: "black"
            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                Column {
                    spacing: -40
                    ChartView1 {
                        id: chartView1
                        width: backRect.width - 10
                        gridvisible: true
                        linevisible: false
                        labelvisible: false
                        title: "LEAD-I"
                        wavetype: PointGenerator.ECGWave
                    }
                    ChartView1 {
                        id: chartView2
                        width: backRect.width - 10
                        gridvisible: true
                        linevisible: false
                        labelvisible: false
                        title: "LEAD-II"
                        wavetype: PointGenerator.ECGWave1
                    }
                    ChartView1 {
                        id: chartView3
                        width: backRect.width - 10
                        gridvisible: true
                        linevisible: false
                        labelvisible: false
                        title: "LEAD-III"
                        wavetype: PointGenerator.ECGWave2
                    }
                    ChartView1 {
                        id: chartView4
                        width: backRect.width - 10
                        gridvisible: true
                        linevisible: false
                        labelvisible: false
                        title: "LEAD-IV"
                        wavetype: PointGenerator.ECGWave3
                    }
                    ChartView1 {
                        id: chartView5
                        width: backRect.width - 10
                        gridvisible: true
                        linevisible: false
                        labelvisible: false
                        title: "LEAD-V"
                        wavetype: PointGenerator.RandomWave
                    }
                }
            }
        }

        Column {
            anchors.right: backRect.left
            anchors.rightMargin: 10
            spacing: 10

            Row{
                Text {
                    text: qsTr("Wave:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                ComboBox {
                    model: ["ECG", "ECG1", "ECG2", "ECG3", "Sine", "Square","Random"]
                    currentIndex: 0
                    onCurrentIndexChanged: {
                        if (model[currentIndex]==="ECG")
                            chartView1.setWaveType(0);
                        else if (model[currentIndex]==="ECG1")
                            chartView1.setWaveType(1);
                        else if (model[currentIndex]==="ECG2")
                            chartView1.setWaveType(2);
                        else if (model[currentIndex]==="ECG3")
                            chartView1.setWaveType(3);
                        else if (model[currentIndex]==="Sine")
                            chartView1.setWaveType(4);
                        else if (model[currentIndex]==="Square")
                            chartView1.setWaveType(5);
                        else if (model[currentIndex]==="Random")
                            chartView1.setWaveType(6);
                    }
                }

            }
            Row{
                Text {
                    text: qsTr("Delay:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                SpinBox {
                    from: 10
                    to: 100
                    value: 10
                    stepSize: 10
                    onValueChanged: chartView1.setTimerDelay(value)
                }
            }

            Row{
                Text {
                    text: qsTr("X Axis:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                SpinBox {
                    from: 100
                    to: 500
                    value: 200
                    stepSize: 100
                    onValueChanged: chartView1.xMax = value
                }
            }
            Row{
                Text {
                    text: qsTr("Y Axis:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                SpinBox {
                    from: 100
                    to: 500
                    value: 100
                    stepSize: 100
                    onValueChanged: chartView1.yMax = value
                }
            }
            Row{
                Text {
                    text: qsTr(" X tick:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                SpinBox {
                    from: 5
                    to: 100
                    value: 100
                    stepSize: 5
                    onValueChanged: chartView1.xTickCount = value
                }
            }
            Row{
                Text {
                    text: qsTr(" Y tick:")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                }
                SpinBox {
                    from: 5
                    to: 50
                    value: 13
                    stepSize: 1
                    onValueChanged: chartView1.yTickCount = value
                }
            }
            CheckBox {
                text: "Grid"
                checked: chartView1.gridvisible
                onCheckedChanged: chartView1.gridvisible = checked
            }
            CheckBox {
                text: "Labels"
                checked: chartView1.labelvisible
                onCheckedChanged: chartView1.labelvisible = checked
            }
            CheckBox {
                text: "Labels"
                checked: chartView1.labelvisible
                onCheckedChanged: chartView1.labelvisible = checked
            }
//            CheckBox {
//                text: "Lead-II"
//                checked: chartView2.visible
//                onCheckedChanged: chartView2.visible = checked
//            }
//            CheckBox {
//                text: "Lead-III"
//                checked: chartView3.visible
//                onCheckedChanged: chartView3.visible = checked
//            }
//            CheckBox {
//                text: "Lead-IV"
//                checked: chartView4.visible
//                onCheckedChanged: chartView4.visible = checked
//            }
//            CheckBox {
//                text: "Lead-V"
//                checked: chartView5.visible
//                onCheckedChanged: chartView5.visible = checked
//            }
        }

    }
}
