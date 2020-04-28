import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var names: ["Girish","Ajit","Sachin"];

    ListModel {
        id:l1
        ListElement {name:"GIrish Lande"}
        ListElement {name:"Ajit Lande"}
        ListElement {name:"Suhas Lande"}
    }

    Button {
        id:b1
        text: "click me"
        onClicked: {
            console.log("Button is clicked")
            for(var i=0;i<names.length;i++) {
                console.log(names[i]);
            }
        }
    }

    ListView {
        anchors.top: b1.bottom
        width: 300
        height: 400
        model: names
        delegate: Text {
            width: 200
            height: 100
            text: model.modelData
            font.pointSize: 20
        }
    }

}
