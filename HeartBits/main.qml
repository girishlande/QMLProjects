import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Controls 2.4

Item {
    id:root
    visible: true
    width: 640
    height: 480

    property var dummyPoints: [33,73,64,74,90,17,74,20,67,49,21,5,30,61,90,0,36,29,39,23,51,43,39,89,94,32,15,60,41,90,78,74,48,88,32,21,52,19,87,17,0,41,26,50,61,37,36,73,83,81,93,5,10,5,68,94,1,80,26,94,70,22,49,45,75,63,78,98,40,40,12,22,13,34,65,43,1,43,40,66,27,35,50,11,10,83,51,72,75,28,94,54,62,63,77,83,30,15,10,0];


    InspectionPopup {
        id: popup
        x: waveRect.x+waveRect.width/4
        y: waveRect.y+waveRect.height*2
        width: waveRect.width/2
        height: waveRect.height + 20
        points: dummyPoints
    }


    WaveRectangle {
        id: waveRect
        width: parent.width
        height: 230
        color: "darkgray"
        points: dummyPoints
        onInspectWave: {
            popup.startindex = startindex;
            popup.endindex = endindex;
            popup.open();
        }
    }

}
