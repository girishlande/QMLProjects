import QtQuick 2.12
import QtQuick.Window 2.12
import Student 1.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 500
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
            color: index%2==0?"orange":"yellow"
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
            text: "Add 4 students"
            onClicked: studentmodel.addStudents()
            width: 200
        }
        Button {
            text: "Insert 2 students random"
            onClicked: studentmodel.insertStudents()
            width: 200
        }

        Button {
            text: "Insert a student at end"
            onClicked: studentmodel.insertStudentsAtEnd();
            width: 200
        }

        Button {
            text: "Insert multiple at end"
            onClicked: studentmodel.insertMultipleStudentsAtEnd();
            width: 200
        }

        Button {
            text: "Clear Students"
            onClicked: studentmodel.clearStudents();
            width: 200
        }
    }
}
