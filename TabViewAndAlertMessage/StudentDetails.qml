import QtQuick 2.0
import QtQuick 2.13

Column {
    padding: 20
    spacing: 40
    Text {
        id: headerText
        text: qsTr("Student Details")
        font.pixelSize: 24
        font.bold: true
    }

    ListView {
        id: studentListView
        width: parent.width - x
        height: 300
        model:studentmodel
        delegate: Rectangle {
            color: index%2==0 ? "yellow" : "green"
            width: studentListView.width
            height: 40
            Text {
                padding: 20
                anchors.fill: parent
                text: model.roll + "  " + model.name
                font.pointSize: 16
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
