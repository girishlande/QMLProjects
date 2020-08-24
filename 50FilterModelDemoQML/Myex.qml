import QtQuick 2.0
import QtQml.Models 2.2

Rectangle {
    width: 200; height: 100

    DelegateModel {
        id: visualModel
        model: ListModel {
            ListElement { name: "Apple" }
            ListElement { name: "Orange" }
        }

        groups: [
            DelegateModelGroup { name: "selected" }
        ]

        delegate: Rectangle {
            id: item
            height: 25
            width: 200
            Text {
                text: {
                    var text = "Name: " + name
                    if (item.DelegateModel.inSelected)
                        text += " (" + item.DelegateModel.selectedIndex + ")"
                    return text;
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: item.DelegateModel.inSelected = !item.DelegateModel.inSelected
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: visualModel
    }
}
