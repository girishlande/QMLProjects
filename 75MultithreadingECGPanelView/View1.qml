import QtQuick 2.0
import QtCharts 2.0
import QtQuick.Controls 2.12
import PointGenerator 1.0

Item {
    id:root

    anchors.fill: parent
    signal clicked();
    signal showPopup();

    Rectangle {
        id: backRect
        anchors.fill: parent
        color: "black"
        ScrollView {
            anchors.fill: parent
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            Column {
                width: parent.width
                height: 1000
                ChartView1 {
                    id: chartView1
                    gridvisible: true
                    linevisible: false
                    labelvisible: false
                    title: "LEAD-I"
                }
                ChartView1 {
                    id: chartVie2
                    gridvisible: true
                    linevisible: false
                    labelvisible: false
                    color1: "lightgreen"
                    color2: "yellow"
                    title: "LEAD-II"
                }
                ChartView1 {
                    id: chartView3
                    gridvisible: true
                    linevisible: false
                    labelvisible: false
                    color1: "orange"
                    color2: "cyan"
                    title: "LEAD-III"
                }
            }
        }
    }

}
