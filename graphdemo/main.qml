import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    LineGraph {
        id: linegraph
        anchors.centerIn: parent
        width: parent.width-100
        height: parent.height-100
        lineCount: 3
    }
}
