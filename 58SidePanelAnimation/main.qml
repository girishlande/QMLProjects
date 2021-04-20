import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    DrawerPanel{
        id: drawer
    }

    Button {
        id: panelDrawer
        text: "Show Hide Panel"
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        onClicked: {
            if (drawer.orientation==Qt.Vertical)
                drawer.orientation=Qt.Horizontal;
            else
                drawer.orientation=Qt.Vertical;
        }
    }
}
