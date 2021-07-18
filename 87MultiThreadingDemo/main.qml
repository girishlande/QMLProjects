import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Row {
        spacing: 10
        Button {
            text: "Raise dialog"
            onPressed: scale = 0.9
            onReleased: scale = 1.0
            onClicked: {
                d1.show();
            }
        }
        Button {
            text: "Toggle Timer State:"
            onPressed: scale = 0.9
            onReleased: scale = 1.0
            onClicked: {
                taskmanager.running = !taskmanager.running;
            }
        }

        Rectangle {
            width: 100
            height: 50
            radius: 10
            color: taskmanager.running ? "red" : "green"
            Text {
                text: "C: " + taskmanager.counter
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
    }


    Window {
        id:d1
        width: 200
        height: 200
        Text {
            id: name
            text: qsTr("A simple window")
            font.pointSize: 20
            anchors.centerIn: parent
        }
    }

}
