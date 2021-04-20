import QtQuick 2.0

Rectangle {

    property string pname: "DefaultName"
    width: 100
    height: 100
    radius: 10
    color: "red"
    Drag.active: mousearea.drag.active

    Text {
        id: name
        text: pname
        anchors.centerIn: parent
    }
    MouseArea {
        id: mousearea
        anchors.fill: parent
        drag.target: parent
        onReleased: parent.Drag.drop()
    }
}
