import QtQuick 2.0
import QtCharts 2.3
import PointGenerator 1.0

ChartView {
    id:root
    title: "Lead 1"

    property bool gridvisible: true
    property bool linevisible: true
    property bool labelvisible: true
    property var xTickCount: 100
    property var yTickCount: 13
    property var xMin: 0
    property var xMax: 200
    property var yMin: 0
    property var yMax: 100
    property alias color1: series1.color
    property alias color2: series2.color
    property alias wavetype: pointgen.wavetype

    signal setTimerDelay(int value);
    signal setWaveType(int index);

    width: parent.width
    height: 300
    legend.visible: false
    antialiasing: true
    backgroundColor: "black"
    theme: ChartView.ChartThemeDark // ChartView.ChartThemeDark

    PointGenerator {
        id: pointgen
        wavetype: PointGenerator.ECGWave
        xMin: root.xMin
        xMax: root.xMax
        yMin: root.yMin
        yMax: root.yMax
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
        width: 3
        style: Qt.SolidLine
    }
    LineSeries {
        id: series2
        axisX: axisX
        axisY: axisY
        width: 3
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
