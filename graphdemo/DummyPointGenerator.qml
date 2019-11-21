import QtQuick 2.0
import QtQuick.Controls 2.4

Item {
    function getPoints() {
        var pts = [];
        for(var i=0;i<100;i++) {
            pts.push(Math.random())
        }
        console.log(pts);
    }
    Button {
        text: "click"
        onClicked: {
            getPoints();
            //getSineWavePoints(400,200);
        }
    }

    function getSineWavePoints(width,height) {
        var pts = [];
        var x = 0;
        var y = 0;
        var amplitude = 100;
        var frequency = 10;
        while (x < width) {
            y = height/2 + amplitude * Math.sin(x/frequency);
            x = x + 1;
            y = Math.floor(y);
            pts.push(y);
        }
        console.log(pts);
    }
}
