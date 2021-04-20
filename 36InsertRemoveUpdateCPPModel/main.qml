import QtQuick 2.12
import QtQuick.Window 2.12
import Stringlist 1.0
import Student 1.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2

Window {
    visible: true
    width: Screen.width*.8
    height: Screen.height * 0.8
    title: qsTr("Hello World")

    Stud {
        id: studentmodel
    }

    Text {
        id: titleText
        text: qsTr("Demo of How to insert/remove and update c++ models")
        font.pointSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        anchors.top: titleText.bottom
        anchors.topMargin: 100
        width: parent.width
        height: parent.height*.8

        ListView {
            id:view

            spacing: 5
            width: parent.width/2
            height: parent.height
            model: studentmodel

            delegate:RowLayout {
                width: parent.width
                height: 50
                spacing: 5
                Rectangle {
                    Layout.preferredWidth: parent.width * .6
                    height: 50
                    radius: 10
                    color: index%2==0?"red":"green"
                    TextInput {
                        id: textname
                        anchors.centerIn: parent
                        font.pointSize: 16
                        text: model.display
                        selectByMouse: true
                        onTextChanged: model.display = textname.text
                        onAccepted: model.display = textname.text
                    }
                }
                Button {
                    width: parent.width * .2
                    height: 50
                    text: "INSERT"
                    onClicked: {
                        studentmodel.insertStudent(index);
                    }
                }
                Button {
                    width: parent.width * .2
                    height: 50
                    text: "REMOVE"
                    onClicked: {
                        studentmodel.removeStudent(index);
                    }
                }
            }
        }

        ListView {
            spacing: 5
            width: parent.width/2
            height: parent.height
            model: studentmodel

            delegate:
                Rectangle {
                width: parent.width*.6
                height: 50
                radius: 10
                color: index%2==0?"orange":"pink"
                Text {
                    anchors.centerIn: parent
                    font.pointSize: 16
                    text: model.display
                }
            }
        }
    }
}
