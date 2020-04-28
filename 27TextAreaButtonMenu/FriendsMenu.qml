import QtQuick 2.12
import QtQml 2.2
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

Button {
    id: root

    property real menuHeight: friendsMenu.visible ? friendsMenu.height : 0
    property real menuWidth: friendsMenu.visible ? friendsMenu.width : 0
    property alias isMenuVisible: friendsMenu.visible
    property alias menuImplicitHeight: friendsMenu.implicitHeight

    signal cannedAnnotationSelected(string text);
    signal positionChanged();
    
    function scaled(size) { return size * 1 }
    function scaledInt(size) { return Math.round(size * 1) }

    function toggleMenuVisibility() {
        if (friendsMenu.visible)
            friendsMenu.close();
        else
            friendsMenu.open();
    }

    text: qsTr("Choose your friend")
    font.bold: false
    font.letterSpacing: scaled(1.4)
    font.pixelSize: scaled(20)
    flat: true
    onClicked: root.toggleMenuVisibility()

    Menu {
        id: friendsMenu

        y: root.height
        width: scaledInt(412)
        closePolicy: Popup.CloseOnPressOutsideParent
        onHeightChanged: root.toggleMenuVisibility()

        background: Rectangle {
            width: friendsMenu.width
            color: "transparent"
            border.color: "transparent"
        }

        Instantiator {
            id: cannedAnnotationsInstantiator

            onObjectAdded: friendsMenu.insertItem(index, object)
            onObjectRemoved: friendsMenu.removeItem(index)

            model: ListModel {
                ListElement { translatedText: qsTr("Girish Lande") }
                ListElement { translatedText: qsTr("Ajit Lande") }
                ListElement { translatedText: qsTr("Suhas Walase") }
                ListElement { translatedText: qsTr("Sameer Pawar") }
                ListElement { translatedText: qsTr("Kunal Pawar") }
            }

            delegate: MenuItem {
                id: friendsMenuItem

                leftPadding: 0
                rightPadding: 0
                implicitHeight: contentItem.implicitHeight + scaledInt(7)
                width: friendsMenu.width
                text: translatedText
                font.pointSize: 14

                onTriggered: {
                    friendsMenu.close();
                    root.cannedAnnotationSelected(friendsMenuItem.text);
                }
            }
        }
    }
}
