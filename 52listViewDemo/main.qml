import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    TabView {
        anchors.fill: parent
        Tab {
            title: "List View Selection"
            ListViewSelection {}
        }
        Tab {
            title: "Custom List View"
            ListViewDemo{}
        }
    }


}
