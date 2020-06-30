import QtQuick 2.12
import QtQuick.Window 2.12
import Student 1.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: Screen.width * .9
    height: Screen.height * .9
    title: qsTr("Hello World")


    Stud {
        id:studentmodel
    }
    ListView {
        spacing: 10
        width:400
        height: parent.height
        model: studentmodel
        delegate: Rectangle {
            width: 300
            height: 30
            radius: 10
            color: index%2==0?"red":"green"
            Text {
                text: sname
                anchors.centerIn: parent
                font.pointSize: 16
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        spacing: 10
        Button {
            text: "Add students"
            onClicked: studentmodel.addStudents()

        }
        Button {
            text: "Insert students random"
            onClicked: studentmodel.insertStudents()
        }

        Button {
            text: "Insert student at end"
            onClicked: studentmodel.insertStudentsAtEnd();
        }

        Button {
            text: "Insert multiple at end"
            onClicked: studentmodel.insertMultipleStudentsAtEnd();
        }

        Button {
            text: "Clear Students"
            onClicked: studentmodel.clearStudents();
        }
    }
}
