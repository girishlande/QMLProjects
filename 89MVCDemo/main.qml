import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Button {
        text: "Load Student"
        onClicked: loader1.source="StudentDemo.qml"
    }

    Loader {
        id: loader1
        width: 400
        height: 400
        anchors.centerIn: parent
        source: ""
    }




}
