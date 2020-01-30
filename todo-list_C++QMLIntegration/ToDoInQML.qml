import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: tasks
        ListElement {
            done: false
            description: "Walk the dog"
        }
        ListElement {
            done: false
            description: "Clean the car"
        }
        ListElement {
            done: false
            description: "Do the homework"
        }
    }

    Label {
        text: "To Do list"
        anchors.bottom: toDoFrame.top
        anchors.horizontalCenter: toDoFrame.horizontalCenter
        font.pointSize: 30
    }

    Frame {
        id: toDoFrame
        anchors.centerIn: parent
        width: 400
        height: 400

        ColumnLayout {
            anchors.fill: parent
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model:tasks

                clip: true

                delegate: RowLayout {
                    width: parent.width
                    CheckBox {
                        checked: model.done
                        onClicked: {
                            model.done = checked;
                        }
                    }
                    TextField {
                        Layout.fillWidth: true
                        font.pointSize: 16
                        text: model.description
                    }
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Button {
                    Layout.fillWidth: true
                    text: "Add task"
                    onClicked: {
                        tasks.append({done:false,description:''});
                    }
                }
                Button {
                    Layout.fillWidth: true
                    text: "Remove completed task"
                    onClicked: {
                        for(let i=0;i<tasks.count;) {
                            if (tasks.get(i).done)
                                tasks.remove(i);
                            else
                                i++;
                        }
                    }
                }
            }
        }
    }
}
