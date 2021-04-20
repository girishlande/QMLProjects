import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Item {
    Column {
        x:100
        spacing: 50
        DropDown {
            width: 300
            placeholderText: qsTr("Select Radiologist")
            model: ListModel {
                ListElement{
                    name:"Girish Lande"
                    group:"Radiologist"
                }
                ListElement{
                    name:"Ajit Lande"
                    group:"Radiologist"
                }
                ListElement{
                    name:"Suhas Walase"
                    group:"Radiologist"
                }
            }

            textRole: "name"
            text: ""
            onCurrentIndexChanged: {

            }
        }

        ComboBox {
            width: 300
            model: [ "Banana", "Apple", "Coconut" ]
        }

        ComboBox {
            width: 300
            model: myModel
        }


        ComboBox {
            width: 300
            model: userModel
            textRole: "col"
        }

        ListView {
            width: 100; height: 100

            model: userModel
            delegate: Rectangle {
                height: 25
                width: 100
                color: col
                Text { text: col }
            }
        }

        Text {
            id: name
            text: qsTr("-----------------------------------------")
        }
        ListView {
            width: 100; height: 100

            model: userListModel
            delegate: Rectangle {
                height: 25
                width: 100
                color: col
                Text { text: name }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        userListModel.addItem();
                    }
                }
            }
        }
    }
}
