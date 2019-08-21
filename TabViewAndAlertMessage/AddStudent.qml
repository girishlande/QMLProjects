import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick 2.13

Rectangle {
    id:root
    MsgPopup {
        id: msg
        x: parent.width - width - scaledInt(27)
        y: parent.height - height - scaledInt(27)
    }

    Connections {
        target: popupmanager
        onShowError: root.showMsg(msgModel)
        onShowWarning: root.showMsg(msgModel)
        onShowInfo: root.showMsg(msgModel)
    }

    function showMsg(msgModel) {
        msg.forceClose();
        msg.model = msgModel;
        msg.open();
    }

    Rectangle {
        anchors.centerIn: parent
        width: 300
        height: 200
        border.width: 1

        Column {
            spacing: 50

            anchors.centerIn: parent
            Grid {
                columns: 2
                spacing: 10
                Text {
                    text: qsTr("Roll: ")
                    font.pixelSize: 20
                }
                Rectangle {
                    width: 200
                    height: 30
                    border.width: 1
                    TextEdit {
                        id: roll
                        anchors.fill: parent
                        font.pixelSize: 20
                        padding: 4
                        clip: true
                    }
                }
                Text {
                    text: qsTr("Name: ")
                    font.pixelSize: 20
                }
                Rectangle {
                    width: 200
                    height: 30
                    border.width: 1
                    TextEdit {
                        id:name
                        anchors.fill: parent
                        font.pixelSize: 20
                        padding: 4
                        clip: true
                    }
                }
            }

            Row {
                spacing: 20
                Button {
                    text: "Add Student"
                    onClicked: {
                        studentmodel.addNewStudent(roll.text,name.text)
                        popupmanager.show("Added student:" + name.text);
                    }
                }
                Button {
                    text: "cancel"
                    onClicked: {

                    }
                }
            }

        }
    }
}
