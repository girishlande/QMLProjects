import QtQuick 2.0
import QtCharts 2.0

Item {
    id:root

    anchors.fill: parent
    property var xMin: 0
    property var xMax: 100
    property var yMin: -100
    property var yMax: 200

    ChartView {
        id:chart
        title: "Demo of Adding points to the curve using Timer"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true
        backgroundColor: "black"
        theme: ChartView.ChartThemeBrownSand

        ValueAxis {
            id: axisX
            min: root.xMin
            max: root.xMax
            tickCount: 5
        }

        ValueAxis {
            id: axisY
            min: root.yMin
            max: root.yMax
        }

        LineSeries {
            id: series1
            axisX: axisX
            axisY: axisY
        }
        LineSeries {
            id: series2
            axisX: axisX
            axisY: axisY
        }

        ScatterSeries {
            id: pointSeries
            axisX: axisX
            axisY: axisY
        }

    }

    Component.onCompleted: {
        pointgenerator.setSeries(chart.series(0),chart.series(1));
    }
}
