import QtQuick 2.12
import QtQuick.Window 2.12
import MyConfig 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    LayoutView{
        anchors.fill: parent
    }


}
