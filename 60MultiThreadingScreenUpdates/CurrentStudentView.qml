import QtQuick 2.0

Item {
    anchors.fill: parent
    property alias model: studentRepeater.model


    ListModel {
        id: studModel
        ListElement { sroll: 11; name:"Girish" }
        ListElement { sroll: 12; name:"Ajit" }
        ListElement { sroll: 13; name:"Suhas" }
        ListElement { sroll: 11; name:"Girish" }
        ListElement { sroll: 12; name:"Ajit" }
        ListElement { sroll: 13; name:"Suhas" }
        ListElement { sroll: 11; name:"Girish" }
        ListElement { sroll: 12; name:"Ajit" }
        ListElement { sroll: 13; name:"Suhas" }
        ListElement { sroll: 11; name:"Girish" }
        ListElement { sroll: 12; name:"Ajit" }
        ListElement { sroll: 13; name:"Suhas" }
    }

    Text {
        id: studentViewLabel
        text: qsTr("Current Students")
        font.pointSize: 20
        anchors.top: studentView.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: studentView.horizontalCenter
    }
    Flow {
        id: studentView
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        width: 300
        height: 300
        spacing: 10
        Repeater {
            id: studentRepeater
            //model: studModel
            delegate: Rectangle {
                width: 50
                height: 50
                radius: 10
                color: index%2==0 ? "steelblue":"lightgreen"
                Text {
                    id: name
                    text: model.sroll
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
            }
        }
    }

    Rectangle {
        anchors.fill:studentView
        border.width: 2
        border.color: "black"
        color: "transparent"
    }

}
