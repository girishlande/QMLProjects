import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2

Dialog {
    id:root
    title: "Select Topper Dialog"
    modal: true
    width: 400
    height: 400

    property string topperName: ""
    signal selectionMade();

    ListModel {
        id:userListModel
        ListElement{name:'Girish Lande'}
        ListElement{name:'Ajit Lande'}
        ListElement{name:'Suhas Walase'}
        ListElement{name:'Girish Lande'}
        ListElement{name:'Ajit Lande'}
        ListElement{name:'Suhas Walase'}
        ListElement{name:'Girish Lande'}
    }

    contentItem: Rectangle {

        Column {
            spacing: 20
            Text {
                text: qsTr("Select topper")
                font.pixelSize: 40
            }

            Text {
                text: qsTr("Topper will be selected from given list of students ")
                font.pixelSize: 20
                wrapMode: Text.WordWrap
                width: root.width
            }

            DropDown1 {
                width: 300
                placeHolder: "Select Topper student"
                model: userListModel
                onItemSelected: {
                    topperName = text;
                    console.log("Topper name:"+topperName)
                }
            }
        }

        Row {
            id:buttons
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            Button {
                text: "Select"
                onClicked: {
                    root.close();
                    root.selectionMade();
                }
            }
            Button {
                text: "Cancel"
                onClicked: {
                    root.close();
                }
            }
        }
    }

}

