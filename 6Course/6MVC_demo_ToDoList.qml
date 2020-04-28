import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: todoModel
        ListElement { done: false; description: "Wash the car"}
        ListElement { done: false; description: "Clean garage"}
        ListElement { done: true; description: "Do the homework"}
        ListElement { done: false; description: "Learn to play tabla"}
    }


    Frame {
        id: todoFrame
        width: 300
        height: 400
        anchors.centerIn: parent

        ListView {
            model: todoModel
            anchors.fill: parent
            clip: true

            delegate: Row {
                CheckBox {
                    checked: model.done
                    onClicked: {
                        model.done=checked;
                    }
                }
                TextField {
                    text: model.description
                }
            }
        }
    }

    Row {
        width: todoFrame.width
        anchors.bottom: todoFrame.top
        anchors.left: todoFrame.left
        spacing: 2

        Button {
            text: "Add new Task"
            width: parent.width/2
            onClicked: {
                todoModel.append({done: false, description: "New task"})
            }
        }
        Button {
            text: "Remove completed tasks"
            width: parent.width/2
            onClicked: {
                for(var i=0;i<todoModel.count;) {
                    var item = todoModel.get(i);
                    if (item.done===true) {
                        todoModel.remove(i);
                    } else {
                        i++;
                    }
                }
            }
        }
    }
}
