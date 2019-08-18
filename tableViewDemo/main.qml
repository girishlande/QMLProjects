import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1600
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id:headers
        width: 1600
        height: 50
        color: "lightblue"
        MyHeader {

        }
    }

    TableData {
        anchors.top: headers.bottom
        anchors.topMargin: 40
    }
}
