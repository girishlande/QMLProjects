import QtQuick 2.0
import QtQuick.Controls 2.4

Item {
    function getPoints() {
        var pts = [];
        for(var i=0;i<100;i++) {
            pts.push(Math.floor(Math.random() * 100))
        }
        console.log(pts);
    }
    Button {
        text: "click"
        onClicked: {
            getPoints();
        }
    }
}
