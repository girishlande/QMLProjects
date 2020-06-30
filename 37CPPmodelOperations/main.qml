import QtQuick 2.12
import QtQuick.Window 2.12
import student 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 1000
    height: Screen.height
    title: qsTr("Hello World")


    Student {
        id:studentmodel
    }

    Column {
        id: modeleditor
        leftPadding: 100
        width: parent.width/2
        height: parent.height - 100
        spacing: 10
        Text {
            id: labelLeft
            text: qsTr("Model Editor")
            font.pointSize: 25
            leftPadding: 100
        }
        ListView {
            height: 400
            width: parent.width
            spacing: 2
            model: studentmodel
            delegate: RowLayout {
                Rectangle {
                    width: 300
                    height: 30
                    radius: 10
                    color: index%2==0?"lightblue":"steelblue"
                    TextInput {
                        id: snametext
                        text: sname
                        anchors.centerIn: parent
                        font.pointSize: 16
                        selectByMouse: true
                        onTextChanged: {
                            sname=snametext.text
                        }
                    }
                }
                Rectangle {
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    radius: 5
                    color: "orange"
                    SymbolText{}
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            studentmodel.addStudent(index);
                        }
                    }
                }
                Rectangle {
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    radius: 5
                    color: "lightgreen"
                    SymbolText{
                        text: "-"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            studentmodel.removeStudent(index);
                        }
                    }
                }
            }
        }

    }

    Column {
        anchors.left: modeleditor.right
        width: parent.width/2
        height: parent.height - 100
        spacing: 10
        Text {
            id: labelRight
            text: qsTr("Model Viewer")
            font.pointSize: 25
            leftPadding: 100
        }
        ListView {
            height: 400
            width: parent.width
            spacing: 2
            model: studentmodel
            delegate: RowLayout {
                Rectangle {
                    width: 300
                    height: 30
                    radius: 10
                    color: index%2==0?"orange":"yellow"
                    Text {
                        text: sname
                        anchors.centerIn: parent
                        font.pointSize: 16
                    }
                }
            }
        }
    }
}
