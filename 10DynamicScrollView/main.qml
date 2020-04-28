import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4

Window {

    id:root
    visible: true
    width: 700
    height: 700
    title: qsTr("Hello World")

    //ListPickerDemo{}

    property int counter: 5
    property var names:[]
    property var scrollView
    property string scrollFile

    Component.onCompleted: {
        createDummyNames();
        readComponentFile();
    }

    Timer {
        interval: 100; running: true; repeat: false
        onTriggered: {
            buildUI();
        }
    }

    function createDummyNames() {
        for(var i=0;i<counter;i++) {
            root.names.push("Name : " + i)
        }
    }

    function displayNames() {
        console.log("\nList of names:");
        for(var i=0;i<names.length;i++) {
            console.log(names[i]);
        }
    }

    function buildUI() {
        if (scrollView) {
            console.log("Destroying scrollview")
            scrollView.destroy();
        }
        console.log("Creating scrollView")
        scrollView = Qt.createQmlObject(scrollFile,root,"scroll");
        scrollView.names = names;
        return scrollView;
    }


    function readComponentFile() {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "./ScrollDemo.qml");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var response = xhr.responseText;
                scrollFile = response;
            }
        };
        xhr.send();
    }

    Button {
        anchors.bottom: parent.bottom
        text: "Add element"
        onClicked: {
            console.log("Button clicked")
            root.names.push("Name:"+root.counter++);
            buildUI();
        }
    }


}
