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
                text: "Export"
            }
            MenuItem {
                text: "Assign"
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
        y:parent.height/2 - height/2

        onSelectionMade: {
            msgPopup.text="Topper is selected:"
            msgPopup.open();
            console.log("Dialog closed")
        }
    }


}
