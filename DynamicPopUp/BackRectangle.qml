import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {

    anchors.fill: parent
    color: "black"

    Button {
        id: fileButton
        text: "More ..."
        onClicked: menu.open()

        Menu {
            id: menu
            y: fileButton.height

            MenuItem {
                text: "do nothing"
            }
            MenuItem {
                text: "select topper"
                onClicked: {
                    assignDialog.open()
                }
            }
        }
    }

    MessagePopup {
        id:msgPopup
        y:300
    }

    TopperDialog {
        id: assignDialog
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2

        onSelectionMade: {
            console.log("topper selected:"+name);
            msgPopup.text="Topper is selected:"+name
            msgPopup.open();
        }
    }


}
