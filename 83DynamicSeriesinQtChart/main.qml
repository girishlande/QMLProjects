import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import WaveViewModel 1.0

Item {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height *.6

    property var snames: []
    property int scount: 0
    property var tnames: []
    property int tcount: 0

    WaveViewModel{
        id: viewmodel
        onCreateSlotWave: {
            root.addseries();
        }
        onRemoveSlotWave: {
            root.removeSeries();
        }
        onCreateTriggerWave: {
            root.addtriggerwave(xpos);
        }
        onCreateTriggerWaveXY: {
            root.addtriggerwaveXY(xpos,ypos);
        }
        onRemoveTriggerWave: {
            root.removetriggerwave();
        }
    }

    function addseries()
    {
        var p1 = diabBig.createSeries(ChartView.SeriesTypeLine, "S"+root.scount++, diabBig.axisX(s1), diabBig.axisY(s1));
        var p2 = diabBig.createSeries(ChartView.SeriesTypeLine, "S"+root.scount, diabBig.axisX(s1), diabBig.axisY(s1));
        viewmodel.addSlotSeries(p1,p2);
        snames.push(p1);
        snames.push(p2);
        diabBig.update();
        root.scount++;
    }

    function removeSeries() {
        var p1 = snames.shift();
        var p2 = snames.shift();
        diabBig.removeSeries(p1);
        diabBig.removeSeries(p2);
    }

    function addtriggerwave(xpos)
    {
        var p1 = diabBig.createSeries(ChartView.SeriesTypeLine, "T"+root.tcount, diabBig.axisX(s1), diabBig.axisY(s1));
        p1.color = "red";
        p1.append(xpos,100);
        p1.append(xpos,200);
        tnames.push(p1);
        diabBig.update();
        root.tcount++;
    }

    function addtriggerwaveXY(xpos,ypos)
    {
        var p1 = diabBig.createSeries(ChartView.SeriesTypeLine, "T"+root.tcount, diabBig.axisX(s1), diabBig.axisY(s1));
        p1.color = "red";
        p1.append(xpos,ypos);
        p1.append(xpos,ypos-100);
        tnames.push(p1);
        diabBig.update();
        root.tcount++;
    }

    function removetriggerwave() {
        var p1 = tnames.shift();
        diabBig.removeSeries(p1);
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Column{
        Row {
            spacing: 10
            Button {
                text: "Add Slot"
                onPressed: {
                    addseries();
                }
                onReleased: {
                    viewmodel.finishSlotSeries();
                }
            }
        }

        ChartView{
            id: diabBig
            width: root.width
            height: root.height *0.75
            title: "Line"
            theme: ChartView.ChartThemeDark

            antialiasing: true

            ValueAxis{
                id: vlaueAxisX
                min: 0
                max: 1000
            }
            ValueAxis{
                id: valueAxisY
                min:0
                max: 256
            }

            LineSeries {
                id: s1
                axisX: vlaueAxisX
                axisY: valueAxisY
                name: "Series1"
                color: "green"
            }
            LineSeries {
                id: s2
                axisX: vlaueAxisX
                axisY: valueAxisY
                color: "orange"
                name: "Series2"
            }
            ScatterSeries{
                color: "red"
                borderColor: "red"
            }

            Component.onCompleted: {
                viewmodel.addSeries(diabBig.series(0),diabBig.series(1));
                viewmodel.addPointSeries(diabBig.series(2));
            }
        }
    }
}
