import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Login Demo")


    LoginPrompt {
        id:loginPrompt
    }

    Popup {
        id: popup
        width: 300
        height: 150

        anchors.centerIn: parent

        property bool flag: true
        Text {
            text: popup.flag ? qsTr("LOGIN SUCCESS!!") : qsTr("LOGIN FAILURE!!")
            font.pointSize: 20
            anchors.centerIn: parent
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            anchors.fill: parent
            color: popup.flag ? "green" : "red"
        }
    }

}
