import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Controls 2.4

Item {
    id: root
    width: 800
    height: 600
    property bool sourceLoaded: false

    Rectangle {
        anchors.fill: parent
        color: "green"
    }

    Loader {
        width: root.width
        height: root.height

        source: "View1.qml"
        asynchronous: true

        onLoaded: sourceLoaded = true
    }

}
