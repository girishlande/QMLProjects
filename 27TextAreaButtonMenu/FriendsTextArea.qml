import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.2

TextArea {
    id: root
    objectName: "EverestAnnotationTextArea"

    function scaled(size) { return size * 1 }
    function scaledInt(size) { return Math.round(size * 1) }

    QtObject {
        id: internal

        property int maxTextAreaWidth: scaledInt(300)
        property int textPadding: scaledInt(5)
        property real focusOpacity: 1.0
        property real baseOpacity: 0.8
    }

    color: "yellow"
    font.letterSpacing: scaled(1.4)
    font.pixelSize: scaled(20)
    opacity: internal.baseOpacity
    topPadding: scaledInt(10)
    bottomPadding: friendsMenu.height + internal.textPadding
    leftPadding: gripperIcon.width + scaledInt(8)
    rightPadding: internal.textPadding
    placeholderText: qsTr("Enter text")

    Grippers {
        id: gripperIcon
        anchors.top: parent.top
        anchors.topMargin: scaledInt(5)
        anchors.bottom: parent.bottom
    }

    FriendsMenu {
        id: friendsMenu

        anchors.left: gripperIcon.right
        anchors.bottom: root.bottom

        onCannedAnnotationSelected: {
            root.text = text;
        }

        onPositionChanged: {
            positionAnnotationItems();
        }
    }

    background: Rectangle {
        id: backgroundRect
        border.color: "green"
        border.width: scaledInt(2)
        color: "steelblue"
        radius: scaledInt(3)
        height: root.height + friendsMenu.menuHeight + internal.textPadding
        width: !friendsMenu.isMenuVisible ? root.width : friendsMenu.menuWidth + leftPadding
    }
}
