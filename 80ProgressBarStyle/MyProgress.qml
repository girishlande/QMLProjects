import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ProgressBar {
    id: p1
    maximumValue: 100
    minimumValue: 0
    width: parent.width
    height: 50
    style: ProgressBarStyle {
        background: Rectangle {
            radius: 2
            color: "lightgray"
            border.color: "gray"
            border.width: 1
            implicitWidth: 200
            implicitHeight: 24
        }
        progress: Rectangle {
            color: "lightsteelblue"
            border.color: "steelblue"
        }
    }
}
