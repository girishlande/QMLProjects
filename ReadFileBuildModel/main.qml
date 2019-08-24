import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ScrollView {
        anchors.fill: parent
        ListView {
            anchors.fill: parent
            spacing: 5
            model: linesmodel
            delegate: Rectangle {
                height: 25
                width: 100
                Text { text: title }
            }
        }
    }
}
