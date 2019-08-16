import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id:singleStudent
        width: 400
        height: 50
        color: "yellow"

        Text {
            id: sroll
            text: student.roll + ":" + student.name
            anchors.centerIn: parent
            font.pixelSize: 20
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                student.print();
            }
        }
    }

    Column {
        anchors.top: singleStudent.bottom
        anchors.topMargin: 200
        spacing: 5
        Repeater {

            model:studentmodel
            Rectangle {
                width: 400
                height: 50
                color: index%2==0 ? "orange" : "green"

                Text {
                    text: model.roll + ":" + model.name
                    anchors.centerIn: parent
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        student.print();
                    }
                }
            }
        }
    }



}
