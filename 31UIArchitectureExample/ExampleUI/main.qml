import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import ExamplePlugin 1.0

Window {
    width: 500
    height: 500
    visible: true

    Rectangle{
        anchors.fill: parent
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
