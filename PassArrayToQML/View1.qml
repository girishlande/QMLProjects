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
    property var yMin: 20
    property var yMax: 40
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

    function drawDraggingCrossLines(ctx) {
        if(!root.dragging)
            return;

        var p1 = root.inspectStart;
        var p2 = root.inspectEnd;
        var cp = calculateCrossPoints(p1,p2);
        drawCross(ctx,cp);
        cp = calculateCrossPoints(p2,p1);
        drawCross(ctx,cp);
    }

    function drawCross(ctx,cp) {
        ctx.beginPath();
        for(var i=0;i<4;i++) {
            if (i%2==0)
                ctx.moveTo(cp[i].x, cp[i].y);
            else
                ctx.lineTo(cp[i].x, cp[i].y);
        }
        ctx.stroke();
    }

    function drawAnnotationCrossLines(ctx) {
        if(root.annotationPoints.length>0) {
            for(var j=0;j<annotationPoints.length;j+=2) {
                var p1 = annotationPoints[j];
                var p2 = annotationPoints[j+1];
                var cp = calculateCrossPoints(p1,p2);
                drawCross(ctx,cp);
                cp = calculateCrossPoints(p2,p1);
                drawCross(ctx,cp);
            }
        }
    }

    function pntOnLine(pt1,pt2) {
        var t = 0.5
        var xt = (t) * pt1.x + (t * pt2.x)
        var yt = (t) * pt1.y + (t * pt2.y)
        return {'x':xt, 'y':yt};
    }

    function drawDraggingAnnotationText(ctx) {
        if (root.dragging) {
            ctx.beginPath();
            ctx.strokeStyle = "black"
            var from = root.inspectStart;
            var to = root.inspectEnd;
            var dist = distanceBetweenPoints(from,to);
            if (!isNaN(dist))
                dist = Math.floor(dist);
            var midPoint = pntOnLine(from,to);
            ctx.moveTo(midPoint.x,midPoint.y);
            ctx.strokeText(dist,midPoint.x,midPoint.y);
        }
    }

    function drawDraggingAnnotationLine(ctx) {
        if(root.dragging) {
            ctx.beginPath();
            var cached = ctx.getLineDash();
            var space = 4;
            ctx.setLineDash([3, space, 3, space]);
            ctx.strokeStyle = "black"
            ctx.moveTo(root.inspectStart.x, root.inspectStart.y);
            ctx.lineTo(root.inspectEnd.x, root.inspectEnd.y);
            ctx.stroke();
            ctx.setLineDash(cached);
        }
    }

    function drawAnnotationTexts(ctx) {
        ctx.beginPath();
        //ctx.font = "oblique 17px sans-serif";
        ctx.strokeStyle = "black"
        if(root.annotationPoints.length>0) {
            for(var j=0;j<annotationPoints.length;j+=2) {
                var from = annotationPoints[j];
                var to = annotationPoints[j+1];
                var dist = distanceBetweenPoints(from,to);
                if (!isNaN(dist))
                    dist = Math.floor(dist);
                var midPoint = pntOnLine(from,to);
                ctx.strokeText(dist,midPoint.x,midPoint.y);
                ctx.stroke();
            }
        }
    }

    function drawAnnotationLines(ctx) {
        if(root.annotationPoints.length>0) {
            var cached = ctx.getLineDash();
            var space = 4;
            ctx.beginPath();
            ctx.setLineDash([3, space, 3, space]);
            ctx.strokeStyle = "black"
            for(var j=0;j<annotationPoints.length;j+=2) {
                var from = annotationPoints[j];
                var to = annotationPoints[j+1];
                ctx.moveTo(from.x, from.y);
                ctx.lineTo(to.x, to.y);
            }
            ctx.stroke();
            ctx.setLineDash(cached);
        }
    }


    function drawHairLine(ctx) {
        var cx = root.mousePos.x;
        var cy = root.mousePos.y;
        var w = plotarea.width;
        var h = plotarea.height;
        ctx.beginPath();
        ctx.lineWidth=0.5;
        ctx.moveTo(0,cy);
        ctx.lineTo(w,cy);
        ctx.moveTo(cx,0);
        ctx.lineTo(cx,h);
        ctx.moveTo(cx,cy);
        ctx.arc(cx, cy, 4, 0, Math.PI * 0.5, false);
        ctx.arc(cx, cy, 4, Math.PI * 0.5, Math.PI * 2, false);
        ctx.stroke();
    }

    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    ChartView {
        id:chart
        title: "Two Series, Common Axes"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true


        ValueAxis {
            id: chartaxisX
            min: root.xMin
            max: root.xMax
            tickCount: 5
        }

        ValueAxis {
            id: chartaxisY
            min: root.yMin
            max: root.yMax
        }

        LineSeries {
            id: series0
            axisX: chartaxisX
            axisY: chartaxisY
        }
        LineSeries {
            id: series1
            axisX: chartaxisX
            axisY: chartaxisY
        }
        LineSeries {
            id: series2
            axisX: chartaxisX
            axisY: chartaxisY
        }
        LineSeries {
            id: series3
            axisX: chartaxisX
            axisY: chartaxisY
        }

        ScatterSeries {
            id: pointSeries
            axisX: chartaxisX
            axisY: chartaxisY
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

                drawHairLine(ctx);

                drawDraggingCrossLines(ctx);
                drawAnnotationCrossLines(ctx);

                drawDraggingAnnotationText(ctx);
                drawAnnotationTexts(ctx);
                drawAnnotationLines(ctx);

                drawDraggingAnnotationLine(ctx);

            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPressed: {
                    root.inspectStart.x = mouseX;
                    root.inspectStart.y = mouseY;
                    root.dragging = true;
                }
                onReleased: {
                    root.inspectEnd.x = mouseX;
                    root.inspectEnd.y = mouseY;
                    annotationPoints.push({x:root.inspectStart.x,y:root.inspectStart.y});
                    annotationPoints.push({x:root.inspectEnd.x,y:root.inspectEnd.y});
                    root.dragging = false;
                }
                onMouseXChanged: {
                    root.mousePos = {'x':mouseX,'y':mouseY};
                    if (root.dragging) {
                        root.inspectEnd.x = mouseX;
                        root.inspectEnd.y = mouseY;
                    }
                    drawingCanvas.requestPaint();
                }

                onMouseYChanged: {
                    root.mousePos = {'x':mouseX,'y':mouseY};
                    drawingCanvas.requestPaint();
                }

            }

        }
    }

    Component.onCompleted: {
        console.log("chart created")
        for(var i=0;i<graphreader.lineCount();i++) {
            console.log("Line created")
            var points = graphreader.linePoints(i);
            var component = Qt.createComponent("GLineSeries.qml");
            if (component.status === Component.Ready) {
                console.log("component created")
                var newObject = component.createObject(chart, {axisX: chartaxisX, axisY: chartaxisY});
                if (newObject===null) {
                    console.log("Error creating object");
                } else{
                    console.log("object created" + chart.children.length)
                    for (var j = 0; j < points.length; j++) {
                        var val = points[j];
                        //newObject.addPoint(j,val);
                        if (i===0) series0.append(j,val);
                        if (i===1) series1.append(j,val);
                        if (i===2) series2.append(j,val);
                        if (i===3) series3.append(j,val);

                        //pointSeries.append(j, val);
                    }

                }
            }
        }
    }

}
