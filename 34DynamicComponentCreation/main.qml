import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Row {
        spacing: 10
        Button{
            id: item1
            text: "createQmlObject()"
            onClicked: {
                var popup1 = Qt.createQmlObject('import QtQuick 2.8; import QtQuick.Controls 2.1; Popup { id: popup; x: 100; y: 100; width: 400; height: 400; modal: true; focus: true; closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent; visible: false ; Rectangle {
        anchors.fill: parent
        color: "blue"
    }}',
                                                item1,
                                                "DynamicPopup");
                popup1.open()

            }
        }

        Button {
            id: item2
            text: "createComponent()"
            onClicked: {
                var popupComponent = Qt.createComponent("qrc:/TestPopup.qml")
                var popup2 = popupComponent.createObject(item2);
                popup2.open()
            }

        }

    }


    Text {
        id: name
        text: qsTr("Creating component dynamically(createComponent()) is better choice")
        font.pointSize: 30
        anchors.centerIn: parent
    }
}
