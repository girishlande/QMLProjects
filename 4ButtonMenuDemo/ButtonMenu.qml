import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQml 2.13

Button {
    id: root

    function scaled(size) { return size * 1; }
    function scaledInt(size) { return Math.round(scaled(size)); }

    signal cannedAnnotationSelected(string text);
    property alias menuHeight: buttonMenu.height
    property alias menuWidth: buttonMenu.width
    property alias isMenuVisible: buttonMenu.visible


    text: qsTr("Select your friend")
    font.bold: false
    font.letterSpacing: scaled(1.4)
    font.pixelSize: scaled(20)
    flat: true
    clip: true
    background: Rectangle {
        color: "steelblue"
    }

    onClicked: {
        if(buttonMenu.visible) {
            buttonMenu.close();

        }
        else {
            buttonMenu.open();
        }
    }

    Menu {
        id: buttonMenu
        y: root.height
        closePolicy: Popup.CloseOnPressOutsideParent
        clip: true

        background: Rectangle {
            width: buttonMenu.width
            color: "lightblue"
            border.color: "transparent"
            clip: true
        }

        Instantiator {
            id: buttonMenuInstantiator

            onObjectAdded: buttonMenu.insertItem(index, object)
            onObjectRemoved: buttonMenu.removeItem(index)

            model: ListModel {
                ListElement { translatedText: qsTr("sachin Tendulkar") }
                ListElement { translatedText: qsTr("Rahul dravid") }
                ListElement { translatedText: qsTr("Virat Kohli") }
                ListElement { translatedText: qsTr("Virendra sehwagh") }
                ListElement { translatedText: qsTr("anil kumble") }
            }
            delegate: MenuItem {
                id: buttonMenuItem

                leftPadding: 30
                implicitHeight: contentItem.implicitHeight + scaledInt(7)
                width: buttonMenu.width
                text: translatedText
                font.pointSize: 16
                clip: true

                onTriggered: {
                    buttonMenu.close();
                    root.cannedAnnotationSelected(buttonMenuItem.text);
                }
            }
        }
    }
}
