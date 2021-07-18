import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Controls 2.4

Item {
    id: root
    width: Screen.width
    height: 600

    property bool sourceLoaded: false
    property int graphWidth : 2000

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"

        Rectangle {
            id: backRect
            width: parent.width
            height: pointgenerator.gheight + 10
            color: "green"
            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOn

                Row {
                    View1 {
                        xMin: 0
                        xMax: pointgenerator.gwidth
                        yMax: pointgenerator.gheight
                    }
                }
            }
        }
    }


}
