import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4

Item {
    id: root
    width: Screen.width
    height: Screen.height - 200

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"

        Rectangle {
            anchors.bottom: backgroundRect.bottom
            width: parent.width
            height: 40
            radius: 5
            color: "lightblue"
            Text {
                id: name
                text: qsTr("Status Bar")
                font.pointSize: 20
                color: "black"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    panelStatusBar.toggleState();
                }
            }
        }
    }

    DrawerPanel {
        id: panelStatusBar
        orientation: Qt.Horizontal
        onShowPopup: {
            chartViewDialog.show();
        }
    }


    Window {
        id: chartViewDialog
        width: 800
        height: 600
        title: "ECG waveforms"
        Rectangle {
            id: backRect
            anchors.fill: parent
            color: "black"

            Loader {
                id: charViewLoader
                anchors.fill: parent

                source: "View1.qml"
                asynchronous: true
            }
        }
    }
}
