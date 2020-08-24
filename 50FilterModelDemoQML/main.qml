import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Filter model Demo")


    FilterView {
        anchors.fill: parent

    }
}
