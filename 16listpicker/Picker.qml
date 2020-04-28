import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

Item {
    id:root

    property var model
    property string tabButtonFile

    Component.onCompleted: {
        readComponentFile();
    }

    function printModel() {
        console.log("Model elements");
        for(var i=0;i<model.length;i++) {
            console.log(model[i].name + " : " + model[i].selected);
        }
    }

    function readComponentFile() {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "./MyTabButton.qml");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var response = xhr.responseText;
                tabButtonFile = response;
            }
        };
        xhr.send();
    }

    function buildModel(elements,getName,getSelected) {
        model=[];
        for(var i=0;i<elements.length;i++) {
            var item = elements[i];
            console.log(item);
            var name = getName(item);
            var selected = getSelected(item);
            root.model.push({name:name,selected:selected});
        }
        buildUI(-1);
    }

    function buildUI(selectedIndex) {
        destroyButtons(selectedColumn);
        destroyButtons(unselectedColumn);

        for(var index in model) {
            createButton(index);
        }
    }

    function nameSelected(name) {
        console.log("Name selected:" + name);
        for(var i=0;i<model.length;i++) {
            var item = model[i];
            if (item.name===name) {
                model[i].selected=!item.selected;
            }
        }
        printModel();
        buildUI(-1);

    }

    function createButton(index) {
        var item = model[index];
        var targetColumn = item.selected ? selectedColumn : unselectedColumn;
        var obj = Qt.createQmlObject(tabButtonFile,targetColumn,"pickeritem");
        obj.text = item.name;
        obj.width = 200;
        obj.onDoubleClicked.connect(function() {
            nameSelected(item.name);
        }
        );
        return obj;
    }

    function destroyButtons(col) {
        for(var i=0;i<col.children.length;i++) {
            col.children[i].destroy();
        }
        col.children = [];
    }

    Rectangle {
        anchors.fill: parent
        color: "gray"
        border.color: "black"
        border.width: 2

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            ColumnLayout {
                spacing: 10
                Layout.fillHeight: true
                Text {
                    font.pointSize: 20
                    text: qsTr("Available Columns")
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "green"

                    Column {
                        id: unselectedColumn
                        anchors.fill: parent
                        spacing: 10
                    }
                }
            }
            ColumnLayout {
                id:moveButtons
                Button {
                    text: "LEFT"
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                }
                Button {
                    text: "RIGHT"
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                }
            }
            ColumnLayout {
                spacing: 10
                Layout.fillHeight: true
                Text {
                    text: qsTr("Selected Columns")
                    font.pointSize: 20
                }
                Rectangle {
                    color: "orange"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Column {
                        id: selectedColumn
                        anchors.fill: parent
                        spacing: 10
                    }
                }
            }
            ColumnLayout {
                Button {
                    text: "UP"
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                }
                Button {
                    text: "DOWN"
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                }
            }
        }
    }
}
