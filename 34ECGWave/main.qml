import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.3

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property int xMax: width
    property var pts: [0,0.1,0.2,0.1,0,0,-0.2,1,-0.2,0,0.1,0.2,0.1,0,0]
    property var ptsxy: [{x:0,y:0},{x:1,y:0},{x:1.5,y:1},{x:2,y:1.8},{x:3,y:2},
    {x:4,y:1},{x:4.5,y:0},{x:6,y:0},{x:7,y:-2},{x:9,y:9},{x:10,y:-3},
        {x:11,y:0},{x:13,y:0},{x:14,y:1},{x:15,y:2},{x:16,y:2},{x:17,y:1},{x:18,y:0}
    ]

    Component.onCompleted: {
        root.insertPoints();
    }
    onWidthChanged: {
        root.insertPoints();
    }

    function insertPoints() {
        series1.clear();
        for(var x=0,cnt=0;cnt<5;cnt++) {
            for(var i=0;i<18;i++)
              series1.append(cnt*20 + ptsxy[i].x,ptsxy[i].y);
        }
    }

    ChartView {
        id:chart
        title: "Two Series, Common Axes"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        ValueAxis {
            id: axisX
            min: 0
            max: 100
            tickCount: 5
        }

        ValueAxis {
            id: axisY
            min: -15
            max: 15
        }

        LineSeries {
            id: series1
            axisX: axisX
            axisY: axisY
        }

        ScatterSeries {
            id: series2
            axisX: axisX
            axisY: axisY
        }



    }
}
