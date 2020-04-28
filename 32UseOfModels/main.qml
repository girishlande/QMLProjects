import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    function scaled(size) { return size * 1 }
    function scaledInt(size) { return Math.round(scaled(size)) }

    DropDown {
        anchors.centerIn: parent
        width: 300
        placeholderText: qsTr("Select Radiologist")
        model:userListModel
        textRole: "name"
    }
}
