import QtQuick 2.12
import QtQuick.Window 2.12
import Stud 1.0
import QtQuick.Controls 2.0

Window {
    id:root
    visible: true
    x: Screen.width / 2
    y: 100
    width: Screen.width / 2
    height: Screen.height - 100
    title: qsTr("Hello World")

    Student {
        id: s
    }

    Column {
        width: parent.width/2
        height: parent.height
        spacing: 10
        Repeater {
            model: stud
            delegate: Studui {
                sindex: index
            }
        }
    }

    Column {
        spacing: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.rightMargin: 100
        Button {
            width: 200
            height: 50
            text: "Add Student"
            onClicked: {
                stud.addStudent();
            }
        }
        Button {
            width: 200
            height: 50
            text: "Add 10 Students in one go"
            onClicked: {
                stud.addStudentsInOneGo();
            }
        }
        Button {
            width: 200
            height: 50
            text: "Add 10 Students one by one"
            onClicked: {
                stud.addStudentsOneByOne();
            }
        }
        Button {
            width: 200
            height: 50
            text: "Clear Students"
            onClicked: {
                stud.clearStudents();
            }
        }

        Button {
            width: 200
            height: 50
            text: "Update Students"
            onClicked: {
                stud.updateStudent();
            }
        }

    }
}
