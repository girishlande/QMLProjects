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


    function recomputeMenuPosition() {
        if (root.mapToGlobal(0, 0).y + buttonMenu.height > root.Window.height) {
            buttonMenu.y = -buttonMenu.height;
        }
        else {
            buttonMenu.y = root.height;
        }
    }

    text: qsTr("Select your friend")
    font.bold: false
    font.letterSpacing: scaled(1.4)
    font.pixelSize: scaled(20)
    flat: true
    clip: true

    onClicked: {
        if(buttonMenu.visible) {
            buttonMenu.close();

        }
        else {
            buttonMenu.open();
        }

        recomputeMenuPosition();
    }

    Component.onCompleted: root.recomputeMenuPosition()

    Menu {
        id: buttonMenu
        y: root.height
        closePolicy: Popup.CloseOnPressOutsideParent
        clip: true


        onHeightChanged: root.recomputeMenuPosition()

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
                ListElement { translatedText: qsTr("Girish Parshuram lande") }
                ListElement { translatedText: qsTr("Suhas Sayaji Walase") }
                ListElement { translatedText: qsTr("Ajit Parshuram Lande") }
                ListElement { translatedText: qsTr("Kiran Pandurang Phatangade") }
                ListElement { translatedText: qsTr("Sameer Dattatray Pawar") }
            }
            delegate: MenuItem {
                id: buttonMenuItem

                leftPadding: 0
                rightPadding: 0
                implicitHeight: contentItem.implicitHeight + scaledInt(7)
                width: buttonMenu.width
                text: translatedText
                font.pointSize: 20
                clip: true


                onTriggered: {
                    buttonMenu.close();
                    root.cannedAnnotationSelected(buttonMenuItem.text);
                }
            }
        }
    }
}
