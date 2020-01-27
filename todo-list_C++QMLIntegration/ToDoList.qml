import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import ToDo 1.0

Frame {

    ColumnLayout {
        ListView {
            implicitHeight: 400
            implicitWidth: 400
            model: ToDoModel {
                list: toDoList
            }

            clip: true
            delegate: RowLayout {
                CheckBox {
                    checked:model.done
                    onClicked: model.done = checked;
                }
                TextField {
                    Layout.fillWidth: true
                    text: model.description
                    onEditingFinished: model.description = text;
                }
            }
        }
        RowLayout {
            Button {
                text: "Add item"
                onClicked: {
                    toDoList.appendItem();
                }
            }
            Button {
                text: "Remove completed item"
                onClicked: {
                    toDoList.removeCompletedItems();
                }
            }
        }
    }
}
