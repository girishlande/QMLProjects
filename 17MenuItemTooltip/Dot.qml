import QtQuick 2.0

Rectangle {
    id:root
    property bool flag: true
    width: 25
    height: 25
    radius: 10
    color: root.flag ? "green" : "red"

    MouseArea{
        anchors.fill: parent
        onClicked: {
            root.flag = !root.flag;
        }

    }
}
