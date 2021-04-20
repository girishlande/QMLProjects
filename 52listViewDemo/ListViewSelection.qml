import QtQuick 2.0

Item {
    anchors.fill: parent
    Rectangle {
        width: 180; height: 200

        Component {
            id: contactDelegate
            Item {
                width: 180; height: 40
                Column {
                    anchors.centerIn: parent
                    Text { text: '<b>Name:</b> ' + name }
                    Text { text: '<b>Number:</b> ' + number }
                }
            }
        }

        ListView {
            id: listview
            anchors.fill: parent
            model: ContactModel {}
            delegate: contactDelegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
            clip: true
        }

        MouseArea{
            anchors.fill: parent
            onClicked: listview.currentIndex = (listview.currentIndex + 1) % listview.count
        }
    }
}
