import QtQuick 2.9
import QtQuick.Window 2.2

import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id:nameModel
        ListElement{
            name:'Girish'
        }
        ListElement{
            name:'Ajit'
        }
    }

    ColumnLayout{
        spacing: 20
        RowLayout {
            Text {
                id: labelName
                text: qsTr("Enter Name:")
                font.pixelSize: 20
            }

            TextField {
                id:nameText
                font.pixelSize: 20
                focus: true
                onAcceptableInputChanged: {
                    nameModel.append({"name":nameText.text});
                }
                onAccepted: {
                    nameModel.append({"name":nameText.text});
                }
            }
        }
        Button {
            text: "Add"
            onClicked: {
                if(nameText.text!=="")
                nameModel.append({"name":nameText.text});
            }
        }

        ListView{
            model: nameModel
            width: 200
            height: 200
            delegate: Row {
                spacing: 10
                Rectangle {
                    y: parent.height/2 - height/2
                    width: 10
                    height: 10
                    radius: 4
                    color: "black"
                }

                Text {
                    text: name
                    font.pointSize: 20
                }
            }
        }
    }

}
