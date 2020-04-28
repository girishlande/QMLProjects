import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 700
    height: 700
    title: qsTr("Hello World")

    //ListPickerDemo{}

    property var names: ["Girish","Ajit","Sachin","Suhas","Sameer","Sandesh","Prabhu","Ramesh","Suresh"];
    property var count: 0

    function getName(name) {
        return name
    }

    function getSelected(name) {
        count++;
        return (count%2===0);
    }

    Button {
        id:b1
        text: "load data"
        onClicked: {
            picker.buildModel(names,getName,getSelected);
        }
    }

    Picker {
        id:picker
        anchors.fill: parent
        anchors.margins: 40
    }

}
