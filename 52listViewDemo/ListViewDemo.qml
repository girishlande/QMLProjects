import QtQuick 2.0

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "orange"

        Component {
            id: listdelegate
            Item {
                id: listitem
                width: 300
                height: mytext.height + (description.visible ? description.height : 0)
                Text {
                    anchors.top: parent.top
                    id: mytext
                    height: 50
                    font.pointSize: 16
                    text: "Roll:" + roll + " Name:" + name
                }
                Text {
                    anchors.top: mytext.bottom
                    id: description
                    visible: false
                    height: 50
                    text: "Roll:" + roll + " \nName:" + name
                    font.pointSize: 16
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        listview.currentIndex = index;
                    }
                    onDoubleClicked: {
                        description.visible = !description.visible
                    }
                }
            }
        }

        ListModel {
            id: studModel
            ListElement {    roll: 11;   name: "Girish Lande" }
            ListElement {    roll: 12;   name: "Ajit Lande" }
            ListElement {    roll: 13;   name: "Suhas Walase" }
            ListElement {    roll: 14;   name: "Sameer Pawar" }
        }

        ListView {
            id: listview
            spacing: 2
            width: 400
            height: 400
            anchors.centerIn: parent
            model: studModel
            delegate: listdelegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
        }
    }
}
