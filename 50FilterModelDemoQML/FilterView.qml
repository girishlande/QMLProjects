import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.12

Item {
    id: root
    RowLayout {
        width: parent.width
        height: parent.height * .8
        spacing: 10
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView {
                id: displayView
                anchors.fill: parent
                spacing: 5
                model: myModel             // 6
                delegate: Rectangle {
                    width: parent.width
                    height: 25
                    color: "lightgreen"
                    Text {
                        anchors.centerIn: parent
                        text: vis
                        font.bold: true
                        font.pixelSize: 20
                    }
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView {
                id: displayFilterListView
                anchors.fill: parent
                spacing: 5
                model: displayDelegateModel             // 6
            }
        }
    }

    ListModel {                                 // 1
        id: myModel
        ListElement { vis: "One"; key: 0; }
        ListElement { vis: "two"; key: 1; }
        ListElement { vis: "Three"; key: 0; }
        ListElement { vis: "Four"; key: 0; }
        ListElement { vis: "Five"; key: 1; }
        ListElement { vis: "Six"; key: 1; }
        ListElement { vis: "Seven"; key: 0; }
        ListElement { vis: "Eight"; key: 1; }
        ListElement { vis: "Nine"; key: 0; }
        ListElement { vis: "Ten"; key: 1; }
    }

    VisualDataModel {
        id: displayDelegateModel

        delegate:  Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 25
            color: "steelblue"

            Text {
                text: vis
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 20
            }
        }

        model: myModel                          // 2

        groups: [
            VisualDataGroup {                   // 3
                includeByDefault: false         // NECESSARY TO AVOID AUTOADDITION
                name: "key0"
            },
            VisualDataGroup {                   // 3
                includeByDefault: false         // NECESSARY TO AVOID AUTOADDITION
                name: "key1"
            }
        ]

        filterOnGroup: "key1"                   // 5

        Component.onCompleted: {                // 4
            var rowCount = myModel.count;
            items.remove(0,rowCount);
            for( var i = 0;i < rowCount;i++ ) {
                var entry = myModel.get(i);
                if(entry.key === 0) {
                    items.insert(entry, "key0");
                } else if (entry.key===1) {
                    items.insert(entry, "key1");
                }
            }
        }
    }


    Button {
        x:parent.width-width
        y:parent.height-height
        text:"Change Filter"
        onClicked: {
            if (displayDelegateModel.filterOnGroup == "key0")
                displayDelegateModel.filterOnGroup = "key1";
            else
                displayDelegateModel.filterOnGroup = "key0";
        }
    }
}
