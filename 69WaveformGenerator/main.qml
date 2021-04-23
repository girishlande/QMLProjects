import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import PointGenerator 1.0
Item {
    id: root
    width: Screen.width / 2
    height: Screen.height /2


    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"

        Rectangle {
            id: backRect
            width: parent.width
            height: parent.height * .5
            color: "black"

            ChartView1 {
                id: chartView1
                gridvisible: true
                linevisible: false
                labelvisible: false
                title: "LEAD-I"
            }
        }

        Column {
            anchors.top: backRect.bottom
            CheckBox {
                text: "Grid"
                checked: chartView1.gridvisible
                onCheckedChanged: chartView1.gridvisible = checked
            }
            ComboBox {
                model: ["ECG", "Sine", "Square","Random"]
                currentIndex: 0
                onCurrentIndexChanged: {
                    if (model[currentIndex]==="ECG")
                        chartView1.setWaveType(0);
                    else if (model[currentIndex]==="Sine")
                        chartView1.setWaveType(1);
                    else if (model[currentIndex]==="Square")
                        chartView1.setWaveType(2);
                    else if (model[currentIndex]==="Random")
                        chartView1.setWaveType(3);
                }
            }
        }
    }

}
