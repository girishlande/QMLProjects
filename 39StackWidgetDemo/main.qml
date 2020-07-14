import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack lauout demo")

    Button {
        text: qsTr("Raise Dialog")
        onClicked: {
            popup.open();
        }
    }

   AboutPopup {
       id: popup
       width: 400
       height: 400
   }
}
