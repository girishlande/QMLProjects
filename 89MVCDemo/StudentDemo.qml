import QtQuick 2.0
import Student 1.0

Item {
    Student {
        id:s1
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        Row {
            Text {
                id: rollLabel
                text: qsTr("Roll:")
                font.pointSize: 16
            }
            TextInput {
                id:rollinput
                width: 100
                height: 30
                font.pointSize: 16
                onTextChanged: {
                    s1.roll = Number(rollinput.text);
                }
            }
        }
        Row {
            Text {
                id: nameLabel
                text: qsTr("Name:")
                font.pointSize: 16
            }
            TextInput {
                id:nameinput
                width: 200
                height: 30

                font.pointSize: 16
                onTextChanged: {
                    s1.name = nameinput.text
                }
            }
        }
        Item {
            height: 20
            width: 20
        }

        Column {
            Text {
                text: "Roll:" + s1.roll
                font.pointSize: 20
            }
            Text {
                text: "Name:" + s1.name
                font.pointSize: 20
            }
        }
    }
}
