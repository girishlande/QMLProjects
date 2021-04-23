import QtQuick 2.0
import QtCharts 2.3
import PointGenerator 1.0

ChartView {
    id:root
    title: "Lead 1"

    property bool gridvisible: true
    property bool linevisible: true
    property bool labelvisible: true
    property var xTickCount: 5
    property var yTickCount: 5
    property var xMin: 0
    property var xMax: 500
    property var yMin: 0
    property var yMax: 100
    property alias color1: series1.color
    property alias color2: series2.color

    width: parent.width
    height: 200

    legend.visible: false
    antialiasing: true
    backgroundColor: "black"
    theme: ChartView.ChartThemeDark

    PointGenerator {
        id: pointgen
    }

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
        pointgen.setSeries(root.series(0),root.series(1));
    }
}
