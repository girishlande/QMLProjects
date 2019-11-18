import QtQuick 2.0
import QtQuick.Controls 2.4

Item {
    id: root
    anchors.fill: parent

    property var names

    ScrollView {
        id:myView
        width: parent.width
        height: parent.height/2
        clip: true
        Column {
            id:col
            width: parent.width
            spacing: 4
            Repeater {
                model: names
                delegate: Rectangle {
                    width:col.width
                    height: 40
                    color: index%2===0?"orange":"green"
                    Text {
                        text: modelData
                        font.pointSize: 14
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

}
