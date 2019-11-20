import QtQuick 2.0
import QtQuick.Controls 2.4

Item {
    id: root

    property alias color: strip.color
    property color combcolor: "lightgray"
    property var combRectWidth: 5
    property var combRectGap: 15
    property var points: []
    property var totalWidth: root.width
    property var totalCombRects: totalWidth / (combRectWidth+combRectGap)

    property var inspectStartX: 0
    property var inspectEndX: 0
    property var startindex:0
    property var endindex: 0

    signal inspectWave(var startindex,var endindex)

    onStartindexChanged: {
        drawingCanvas.requestPaint();
    }

    onEndindexChanged: {
        drawingCanvas.requestPaint();
    }

    Rectangle {
        id: strip
        anchors.fill: parent
        color: "black"

        Repeater {
            model:totalCombRects

            delegate : Rectangle {
                width: combRectWidth
                height: combRectGap
                color: combcolor
                x: index * 20
            }
        }

        Repeater {
            model:totalCombRects

            delegate : Rectangle {
                width: combRectWidth
                height: combRectGap
                color: combcolor
                x: index * 20
                y: strip.height - height
            }
        }

        Canvas
        {
            id: drawingCanvas
            anchors.fill: parent

            onPaint:
            {
                var ctx = getContext("2d")
                ctx.lineWidth = 3;
                ctx.strokeStyle = "green"
                ctx.beginPath()
                var yoffset = 50;

                if (root.points.length>0) {
                    if (root.startindex<root.endindex) {
                        var indexrange = root.endindex - root.startindex;
                        var xinc = root.width / indexrange;
                        ctx.moveTo(0, root.points[root.startindex]+yoffset)
                        for(var index=1;index<=indexrange;index++) {
                            ctx.lineTo(index*xinc,root.points[root.startindex+index]+yoffset);
                        }
                    } else {
                        ctx.moveTo(0, yoffset)
                        xinc = root.width / root.points.length;
                        for(index=0;index<root.points.length;index++) {
                            ctx.lineTo(index*xinc,root.points[index]+yoffset);
                        }
                    }
                } else {
                    ctx.moveTo(0, 50)
                    for(i=0;i<strip.width;i+=4) {
                        ctx.lineTo(i, Math.floor(Math.random() * 100) + 100)
                    }
                }
                ctx.stroke()
            }

            MouseArea {
                anchors.fill: parent
                property var dragging: false
                onPressed: {
                    if (root.inspectStartX<root.inspectEndX)
                        root.inspectEndX = 0;
                    root.inspectStartX = mouseX;
                    dragging = true;
                }
                onReleased: {
                    root.inspectEndX = mouseX;
                    dragging=false;
                    var starttx = Math.floor((root.inspectStartX * root.points.length) / root.width);
                    var enddx = Math.floor((root.inspectEndX * root.points.length) / root.width);
                    root.inspectWave(starttx,enddx);
                }
                onMouseXChanged: {
                    if (dragging) {
                        if(mouseX>root.inspectStartX)
                            root.inspectEndX = mouseX;
                    }

                }
            }


            WaveHighlighter {
                x: root.inspectStartX
                startx: root.inspectStartX
                endx: root.inspectEndX
            }
        }
    }
}
