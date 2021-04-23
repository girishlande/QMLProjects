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
    property var xMax: 300
    property var yMin: 0
    property var yMax: 100
    property alias color1: series1.color
    property alias color2: series2.color
    property alias wavetype: pointgen.wavetype

    signal setWaveType(int index);
    onSetWaveType: {
        console.log("Set wave type:"+index);
        if (index==0)
            pointgen.wavetype=PointGenerator.ECGWave;
        if (index==1)
            pointgen.wavetype=PointGenerator.SineWave;
        if (index==2)
            pointgen.wavetype=PointGenerator.SquareWave;
        if (index==3)
            pointgen.wavetype=PointGenerator.RandomWave;
        pointgen.reset();
    }

    width: parent.width
    height: 200

    legend.visible: false
    antialiasing: true
    backgroundColor: "black"
    theme: ChartView.ChartThemeDark

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
