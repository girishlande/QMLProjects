import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("GongJianBo 1992")

    CircleProgress{
        id: circle_progress
        anchors.centerIn: parent
        value: 50

                 //For testing, set the progress value cyclically
        NumberAnimation on value {
            from: 0
            to: 100
            duration: 5000
            running: true
            loops: Animation.Infinite
        }
    }
}
