import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    id:root
    width: 200
    height: 40
    border.color: "black"
    border.width: 1

    property alias placeHolder: placeHolderText.text
    property alias model: listViewId.model

    TextEdit {
        id: textEdit
        width: parent.width
        height: parent.height
        font.pixelSize: 20
        verticalAlignment: TextEdit.AlignVCenter
        textMargin: 10

        Text {
            id:placeHolderText
            color: "#aaa"
            visible: !textEdit.text
            font.pixelSize: 16
            anchors.fill: parent
            font.italic: true
            verticalAlignment: Text.AlignVCenter
        }

        Menu {
            id: contextMenu
            y: textEdit.height
            width: root.width

            ScrollView {
                width: root.width
                height: 200
                clip: true
                hoverEnabled: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                ListView {
                    id:listViewId
                    boundsBehavior: ListView.StopAtBounds
                    delegate: MenuItem {
                        text: model.name
                        onClicked: {
                            textEdit.text = text;
                            contextMenu.close()
                        }
                        hoverEnabled: true
                    }
                }
            }
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                contextMenu.open();
            }
        }
    }
}
