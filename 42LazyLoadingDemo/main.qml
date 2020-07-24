import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Row {
            id: controlRow
            spacing: 10
            Button {
                text: "Fruits"
                onClicked: {
                    myloader.source = "qrc:/Fruits.qml"
                }
            }
            Button {
                text: "Vegetables"
                onClicked: {
                    myloader.source = "qrc:/Vegetables.qml"
                }
            }
            Button {
                text: "Drinks"
                onClicked: {
                    myloader.source = "qrc:/Drinks.qml"
                }
            }
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "red"
            radius: 10

            Loader {
                id:myloader
                anchors.fill: parent
            }
        }
    }



}
