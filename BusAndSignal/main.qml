import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")


    Rectangle {
        id: road
        y:50
        width: parent.width
        height: 200
        color: "black"

        Rectangle {
            y: 4
            width: root.width
            height: 4
            color: "white"
        }
        Rectangle {
            y: road.height - height*2
            width: root.width
            height: 4
            color: "white"
        }

    }

    Bus {
        id: bus
        x:100
        y:100
    }

    Button {
        text: "click"
        onClicked: {
            bus.startAnimation();
        }
    }

}
