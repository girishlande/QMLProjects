import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import ExamplePlugin 1.1

Window {
    width: 500
    height: 500
    visible: true

    MyRect {
        id: r1
        width: 200
        height: 100
        anchors.bottom: parent.bottom
    }

    MyButton {
        anchors.left: r1.right
        anchors.bottom: parent.bottom
        onClicked: {
            console.log("MyButton clicked!");
        }
    }

    Rectangle{
        width: 500
        height: 300
        anchors.margins: 10

        Component.onCompleted: PatientProvider.fetchMockPatients()

        ListView {
            id: displayList
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            model: PatientProvider.patientModel
            delegate: Row {
                spacing: 10
                Text {
                    text: "Name: " + name
                }
                Text {
                    text: "age: " + age
                }
            }
        }

        ListView {
            anchors.top: parent.top
            anchors.bottom: buttonRow.top
            anchors.left: displayList.right
            anchors.right: parent.right
            anchors.leftMargin: 10

            model: PatientProvider.patientModel
            delegate: Row {
                TextField {
                    id: field
                    text: name
                    echoMode: TextInput.Normal
                    onAccepted: name = field.text
                }
            }
        }

        Row {
            id: buttonRow

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            spacing: 10

            Button {
                text: "Append Patient C++"
                onClicked: PatientProvider.appendPatient()
            }

            Button {
                text: "Modify Patient Name C++"
                onClicked: PatientProvider.modifyPatient()
            }
        }
    }
}
