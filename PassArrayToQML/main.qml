import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Controls 2.4

Item {
    width: 800
    height: 600
    property bool sourceLoaded: false

    Component.onCompleted: {
        console.log("Girish Done")
    }

    ListView {
        id: root
        focus: true
        anchors.fill: parent
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 250
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds

        onCurrentIndexChanged: {
        }

        model: ListModel {
            ListElement {component: "View1.qml"}
        }

        delegate: Loader {
            width: root.width
            height: root.height

            source: component
            asynchronous: true

            onLoaded: sourceLoaded = true
        }
    }

}
