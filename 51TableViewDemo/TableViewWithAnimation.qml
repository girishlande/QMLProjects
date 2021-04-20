import QtQuick 2.12
import QtQuick.Window 2.12
import tablemodel 1.0

Item {

    anchors.fill: parent
    TableView {
        id: tview
        anchors.fill: parent
        columnSpacing: 1
        rowSpacing: 1
        clip: true

        model: TableModel {}

        delegate: tableViewDelegate

        Component.onCompleted: {
            console.log("Implicit width:" + tview.implicitWidth + " height:" + tview.implicitHeight)
        }
    }

    Component {
        id: tableViewDelegate
        Rectangle {
            implicitWidth: 100
            implicitHeight: 50

            TableView.onPooled: rotationAnimation.pause()
            TableView.onReused: rotationAnimation.resume()

            Rectangle {
                id: rect
                anchors.centerIn: parent
                width: 40
                height: 5
                color: "green"

                RotationAnimation {
                    id: rotationAnimation
                    target: rect
                    duration: (Math.random() * 2000) + 200
                    from: 0
                    to: 359
                    running: true
                    loops: Animation.Infinite
                }
            }
        }
    }
}
