import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("createComponent() is always better to create components dynamically")


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
                //var popup2 = popupComponent.createObject(item2);
                var options = {
                    "width": Qt.binding(function() { return mainWindow.width/2 }),
                    "height": Qt.binding(function() { return mainWindow.height/2 }),
                };
                var popup2 = popupComponent.createObject(parent, options);
                popup2.open()
            }

        }

    }

}
