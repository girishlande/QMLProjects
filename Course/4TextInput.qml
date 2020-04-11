import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    RowLayout {
        spacing: 10
        Text {
            width: 50
            height: 30
            font.pointSize: 20
            text: qsTr("Enter your name::")
        }
        TextField {
            id: t1
            width: 100
            height: 30
            font.pointSize: 20
        }
    }
    Text {
        id: name
        anchors.centerIn: parent
        text: qsTr("Hello ") + t1.text + "!!"
        font.pointSize: 40
    }
}
