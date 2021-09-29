import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    id: root
    property bool cardiac: false
    property int btnheight: 20
    property int power: 2

    Rectangle {
        anchors.fill:parent
        color: "gray"
    }

    Column {
        spacing: 10
        RadioButton {
            width: root.btnheight
            height: root.btnheight
            text: "RadioButton1"
            color: "black"
            active: root.cardiac
            onClicked: {
                root.cardiac = true;
            }
        }
        RadioButton {
            width: root.btnheight
            height: root.btnheight
            text: "RadioButton2"
            color: "black"
            active: !root.cardiac
            onClicked: {
                root.cardiac = false;
            }
        }
    }
}
