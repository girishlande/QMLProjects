/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Charts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtCharts 2.0

Item {
    id:root

    anchors.fill: parent
    property var inspectStart: {'x':0,'y':0}
    property var inspectEnd: {'x':0,'y':0}
    property var mousePos:  {'x':0,'y':0}
    property var xMin: 0
    property var xMax: 30
    property var yMin: -0.5
    property var yMax: 1.5
    property bool dragging: false
    property var annotationPoints: []
    property bool pixelDistance: false

    function getPixelDistance(p1,p2) {
        var a = p1.x - p2.x;
        var b = p1.y - p2.y;
        var c = Math.sqrt( a*a + b*b );
        return c;
    }

    function getUnitDistance(p1,p2) {
        var a = Math.abs(p1.x - p2.x);
        var b = Math.abs(p1.y - p2.y);
        var distStr="(x:" + a + ",y:" + b + ")";
        return distStr;
    }

    function distanceBetweenPoints(p1,p2) {
        if(root.pixelDistance)
            return getPixelDistance(p1,p2);
        return getUnitDistance(p1,p2);
    }

    function getVector(p1,p2) {
        return {'x':p2.x-p1.x,'y':p2.y-p1.y};
    }

    function normalize(v) {
        var length = Math.sqrt(v.x*v.x+v.y*v.y);
        v.x = v.x/length;
        v.y = v.y/length;
        return {'x':v.x,'y':v.y};
    }

    function giveLengthToVector(v,length) {
        v.x = v.x*length;
        v.y = v.y*length;
        return v;
    }

    function getNewPoint(vec,point) {
        return {'x':point.x+vec.x,'y':point.y+vec.y};
    }

    function negateVector(vec) {
        return {'x':-vec.x,'y':-vec.y};
    }

    function rotateVector(vec,ang) {
        ang = ang * (Math.PI/180);
        return { 'x':vec.x * Math.cos(ang) - vec.y * Math.sin(ang),
                  'y':vec.x * Math.sin(ang) + vec.y * Math.cos(ang)};
    }

    function calculateCrossPoints(p1,p2) {
        var crossLength = 10;
        var vec = getVector(p1,p2);
        vec = normalize(vec);
        vec = rotateVector(vec,45);
        var unitvec = {'x':vec.x,'y':vec.y};
        vec = giveLengthToVector(vec,crossLength)
        var c1 = getNewPoint(vec,p1);
        vec = negateVector(vec);
        var c2 = getNewPoint(vec,p1);

        vec = unitvec;
        vec = rotateVector(vec,90);
        vec = giveLengthToVector(vec,crossLength)
        var c3 = getNewPoint(vec,p1);
        vec = negateVector(vec);
        var c4 = getNewPoint(vec,p1);
        var points = [];
        points.push(c1);points.push(c2);points.push(c3);points.push(c4);
        return points;
    }

    function pntOnLine(pt1,pt2) {
        var t = 0.5
        var xt = (t) * pt1.x + (t * pt2.x)
        var yt = (t) * pt1.y + (t * pt2.y)
        return {'x':xt, 'y':yt};
    }


    function drawDraggingAnnotationLine(ctx) {
        if(root.dragging) {
            ctx.beginPath();
            var cached = ctx.getLineDash();
            var space = 4;
            //ctx.setLineDash([3, space, 3, space]);
            ctx.strokeStyle = "black"
            ctx.moveTo(root.inspectStart.x, root.inspectStart.y);
            ctx.lineTo(root.inspectEnd.x, root.inspectEnd.y);
            ctx.stroke();
            //ctx.setLineDash(cached);
        }
    }


    function drawAnnotationLines(ctx) {
        if(root.annotationPoints.length>0) {
            var cached = ctx.getLineDash();
            var space = 4;
            ctx.beginPath();
            ctx.lineWidth = 3;
            //ctx.setLineDash([3, space, 3, space]);
            ctx.strokeStyle = "black"
            for(var j=0;j<annotationPoints.length-1;j++) {
                var from = annotationPoints[j];
                var to = annotationPoints[j+1];
                ctx.moveTo(from.x, from.y);
                ctx.lineTo(to.x, to.y);
            }
            ctx.stroke();
            //ctx.setLineDash(cached);
        }
    }



    ChartView {
        id:chart
        title: "Creating wave"
        width: parent.width * .9
        height: parent.height * .9
        legend.visible: false
        antialiasing: true
        //theme: ChartView.ChartThemeDark
        anchors.centerIn: parent

        ValueAxis {
            id: axisX
            min: 0
            max: 30
            tickCount: 20
            labelsVisible: false
            lineVisible: false
        }

        ValueAxis {
            id: axisY
            min: 0
            max: 20
            tickCount: 30
            labelsVisible: false
            lineVisible: false
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

        Rectangle {
            id:plotarea
            x: chart.plotArea.x
            y: chart.plotArea.y
            width: chart.plotArea.width
            height: chart.plotArea.height
            color: "transparent"
        }

        Canvas
        {
            id: drawingCanvas
            anchors.fill: plotarea

            onPaint:
            {
                var ctx = getContext("2d")
                ctx.reset();

                drawAnnotationLines(ctx);
                drawDraggingAnnotationLine(ctx);
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPressed: {
                    annotationPoints.push({x:mouseX,y:mouseY});
                    root.dragging = true;
                }
                onReleased: {
                    root.dragging = false;
                }
                onMouseXChanged: {
                    if (root.dragging) {
                        annotationPoints.push({x:mouseX,y:mouseY});
                    }
                    drawingCanvas.requestPaint();
                }

                onMouseYChanged: {
                    if (root.dragging) {
                        annotationPoints.push({x:mouseX,y:mouseY});
                    }
                    drawingCanvas.requestPaint();
                }

            }

        }
    }

}
