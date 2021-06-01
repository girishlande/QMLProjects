import QtQuick 2.0
import QtCharts 2.0
import QtQuick.Controls 2.12

Item {
    id:root

    anchors.fill: parent
    signal clicked();
    signal showPopup();

    Column {
        anchors.fill: parent

        ChartView1 {
            id: chartView1
            gridvisible: true
            linevisible: false
            labelvisible: false
            title: "LEAD-I"
        }
//        ChartView1 {
//            id: chartVie2
//            gridvisible: true
//            linevisible: false
//            labelvisible: false
//            color1: "lightgreen"
//            color2: "yellow"
//            title: "LEAD-II"
//        }
//        ChartView1 {
//            id: chartView3
//            gridvisible: true
//            linevisible: false
//            labelvisible: false
//            color1: "orange"
//            color2: "cyan"
//            title: "LEAD-III"
//        }
//        ChartView1 {
//            id: chartVie4
//            gridvisible: true
//            linevisible: false
//            labelvisible: false
//            color1: "green"
//            color2: "pink"
//            title: "LEAD-IV"
//        }
//        ChartView1 {
//            id: chartView5
//            gridvisible: true
//            linevisible: false
//            labelvisible: false
//            color1: "white"
//            color2: "red"
//            title: "LEAD-V"
//        }
    }

}
