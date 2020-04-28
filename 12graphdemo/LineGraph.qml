import QtQuick 2.0

Graphbackground{
    id:root
    property var points: [0.5845254338737875,0.056348214866337565,0.2788053511046328,0.898127140709902,0.2705076917012206,0.7016165659150293,0.3732066157284296,0.6725770883610048,0.703349049365034,0.8969260262122936,0.8640118606356296,0.818441725018109,0.5883631532095487,0.6863266289727115,0.8359457597280797,0.08713118474690229,0.7515258438015602,0.873144867111557,0.6467765482685411,0.8077606100719428,0.6858043361012431,0.8854140820402986,0.27044033648954235,0.35920310229765684,0.38565478140454634,0.18395409813549746,0.779831663854672,0.5577853265408682,0.06794730528374149,0.8465190386359579,0.6323717133877006,0.8013186200548311,0.8182558151573053,0.5775584275916175,0.6449067331713451,0.49961903454048584,0.2787641619734592,0.2739161350220808,0.5326715917513692,0.4506430513020293,0.8360388617152539,0.15553990970757292,0.8902476054787976,0.37324471402741,0.9265792976477152,0.386776391303735,0.05877577582484106,0.5045799450228368,0.02966554898931162,0.08458064790053943,0.9983599587015645,0.8071302015961898,0.5002010511596523,0.8707307090692022,0.41542829989166374,0.5233556228747849,0.3529110895128206,0.6345495229773624,0.4523948276472147,0.14021262862786577,0.24650748285955593,0.7372281172804919,0.2516303147867093,0.2987577018826476,0.00031849088707902595,0.050540118091541686,0.40282544181457136,0.45663684784654646,0.11461830121847494,0.019988281891326065,0.7543594303643814,0.04976072253810593,0.9692290095035044,0.3779728357833302,0.8626050523850957,0.2481805182331911,0.766057035563461,0.44719335633142876,0.23898187669946702,0.9215743972938029,0.9412719191903323,0.7971071352296961,0.8555884408773348,0.5118524438714471,0.07131128901318584,0.8106543275776494,0.3650944145662077,0.08899826458625348,0.21448066694328083,0.7562481122090402,0.5018195646905974,0.35641692964263005,0.3852904462244565,0.5411158770775534,0.5715117723816836,0.3987983986494047,0.033159787455070755,0.13338324996334416,0.07387189365581814,0.23235136892298747]
    property var inspectStart: {'x':0,'y':0}
    property var inspectEnd: {'x':0,'y':0}
    property var lineCount: 3
    property var dragging: false
    property var linesDrawn: false
    signal inspectWave(var startindex,var endindex)
    property var lineColors: ["green","orange","blue","pink","red","cyan","yellow","lightblue"]
    property var annotationPoints: []

    function getStrokeStyle(index) {
        if (index<root.lineColors.length) {
            return root.lineColors[index%root.lineColors.length];
        }
        return "green";
    }

    function pntOnLine(pt1,pt2) {
        var t = 0.5
        var xt = (t) * pt1.x + (t * pt2.x)
        var yt = (t) * pt1.y + (t * pt2.y)
        return {'x':xt, 'y':yt};
    }

    function clearContext(ctx) {
        ctx.strokeStyle = "white"
        ctx.fillRect(0,0,drawingCanvas.width,drawingCanvas.height);
        ctx.lineWidth = 2;
    }

    function addAnnotationTexts(ctx) {
        //ctx.font = "20px normal sans-serif";
        ctx.beginPath();
        ctx.font = "oblique 17px sans-serif";
        ctx.strokeStyle = "white"
        if(root.annotationPoints.length>0) {
            for(var j=0;j<annotationPoints.length;j+=2) {
                var from = annotationPoints[j];
                var to = annotationPoints[j+1];
                var dist = Math.floor(Math.hypot(from.x-to.x, from.y-to.y));
                var midPoint = pntOnLine(from,to);
                ctx.strokeText(dist,midPoint.x,midPoint.y);
                ctx.stroke();
            }
        }
    }

    function drawLines(ctx) {
        var yoffset = drawingCanvas.height / 2;
        var xinc = 200;
        var pointIndex = 0;
        for(var index=0;index<root.lineCount;index++) {
            var xpos = 0;
            ctx.beginPath();
            ctx.strokeStyle = root.getStrokeStyle(index);
            ctx.moveTo(0, 0);
            while(xpos<drawingCanvas.width) {
                xpos+=xinc;
                ctx.lineTo(xpos,Math.floor(points[pointIndex++] * yoffset));
            }
            ctx.stroke();
        }
    }

    function drawDraggingAnnotationText(ctx) {
        if (root.dragging) {
            ctx.beginPath();
            ctx.strokeStyle = "white"
            var from = root.inspectStart;
            var to = root.inspectEnd;
            var dist = Math.floor(Math.hypot(from.x-to.x, from.y-to.y));
            var midPoint = pntOnLine(from,to);
            ctx.strokeText(dist,midPoint.x,midPoint.y);
            ctx.stroke();
        }
    }

    function drawAnnotationLines(ctx) {
        var cached = ctx.getLineDash();
        var space = 4;
        ctx.beginPath();
        ctx.setLineDash([3, space, 3, space]);
        ctx.strokeStyle = "gray"

        if(root.annotationPoints.length>0) {
            for(var j=0;j<annotationPoints.length;j+=2) {
                var from = annotationPoints[j];
                var to = annotationPoints[j+1];

                ctx.moveTo(from.x, from.y);
                ctx.lineTo(to.x, to.y);

            }
        }
        ctx.stroke();
        ctx.setLineDash(cached);
    }

    function drawDraggingAnnotationLine(ctx) {
        if(root.dragging) {
            ctx.beginPath();
            ctx.moveTo(root.inspectStart.x, root.inspectStart.y);
            ctx.lineTo(root.inspectEnd.x, root.inspectEnd.y);
            ctx.stroke();
        }
    }

    Canvas
    {
        id: drawingCanvas
        anchors.fill: parent

        onPaint:
        {
            var ctx = getContext("2d")

            clearContext(ctx);
            addAnnotationTexts(ctx);
            drawLines(ctx);

            drawDraggingAnnotationText(ctx);

            drawAnnotationLines(ctx);

            drawDraggingAnnotationLine(ctx);
        }

        MouseArea {
            anchors.fill: parent

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
                if (root.dragging) {
                    root.inspectEnd.x = mouseX;
                    root.inspectEnd.y = mouseY;
                    drawingCanvas.requestPaint();
                }

            }
        }

    }
}
