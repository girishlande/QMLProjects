import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")
    Rectangle {
        anchors.fill: parent
        color: "grey"
    }

    Row {
        spacing: 10

        Button {
            text: "window"
            onClicked: {
                r.show();
            }
        }

        Button {
            text: "window1"
            onClicked: {
                r1.show();
            }
        }
        Button {
            text: "window2"
            onClicked: {
                r2.show();
            }
        }
    }

    MyWindow {
        id: r
        title: "ECG display"
        width: root.width*.8
        height: 300

        Rectangle {
            id:backrect
            anchors.fill: parent
            color: "black"
        }
        TitleBar {
            id: titlebar
            titleHeight: 30
            onClose: r.close()
            onMinimize: r.showMinimized()
        }
    }


    MyWindow1 {
        id: r1
        title: "ECG display"
        width: root.width*.8
        height: 300
    }

    MyWindow2 {
        id: r2
        title: "ECG display"
        width: root.width*.8
        height: 300
    }

}
