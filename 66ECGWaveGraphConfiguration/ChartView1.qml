import QtQuick 2.0
import QtCharts 2.3

ChartView {
    id:root
    title: "Demo of Adding points to the curve using Timer"

    property bool gridvisible: true
    property bool linevisible: true
    property bool labelvisible: true
    property var xTickCount: 5
    property var yTickCount: 5
    property var xMin: 0
    property var xMax: 100
    property var yMin: 0
    property var yMax: 100

    width: parent.width
    height: 300

    legend.visible: false
    antialiasing: true
    backgroundColor: "black"
    theme: ChartView.ChartThemeBrownSand

    ValueAxis {
        id: axisX
        min: root.xMin
        max: root.xMax
        tickCount: root.xTickCount
        gridVisible: root.gridvisible
        lineVisible: root.linevisible
        labelsVisible: root.labelvisible
    }

    ValueAxis {
        id: axisY
        min: root.yMin
        max: root.yMax
        tickCount: root.yTickCount
        gridVisible: root.gridvisible
        lineVisible: root.linevisible
        labelsVisible: root.labelvisible
    }

    LineSeries {
        id: series1
        axisX: axisX
        axisY: axisY
        color: "cyan"
    }
    LineSeries {
        id: series2
        axisX: axisX
        axisY: axisY
        color: "orange"
    }

    ScatterSeries {
        id: pointSeries
        axisX: axisX
        axisY: axisY
    }

    Component.onCompleted: {
        pointgenerator.setSeries(root.series(0),root.series(1));
    }
}
