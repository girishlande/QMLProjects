import QtQuick 2.0
import QtQuick.Layouts 1.12

Rectangle {
    id: root

    property alias text: mtext.text
    property alias validator: mtext.validator
    property alias stext: mtext

    signal datamodified();

    Layout.fillWidth: true
    height: parent.height
    border.color: "black"
    TextInput {
        anchors.centerIn: parent
        id: mtext
        font.pointSize: 16
        text: qsTr("text")
        onTextChanged: root.datamodified()
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered:  root.color = "steelblue"
        onExited: root.color = "white"
        onClicked: {
            mtext.selectAll()
            mtext.forceActiveFocus()
        }
    }
}
