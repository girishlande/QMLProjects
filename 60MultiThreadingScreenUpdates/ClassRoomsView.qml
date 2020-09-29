import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent
    property alias model: classRepeater.model
    property int activeIndex: 0
    signal activateClass(var index);

    ListModel {
        id: classroomModel
        ListElement { cid: 1; cname:"ClassRoom-1" }
        ListElement { cid: 2; cname:"ClassRoom-2" }
        ListElement { cid: 3; cname:"ClassRoom-3" }
    }

    Text {
        id: classViewModel
        text: qsTr("ClassRooms")
        font.pointSize: 20
        anchors.top: classView.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: classView.horizontalCenter
    }
    Column {
        id: classView
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        width: 300
        spacing: 10
        Repeater {
            id: classRepeater
            model: classroomModel
            delegate: Rectangle {
                width: classView.width
                height: 50
                color: index%2==0 ? "orange":"steelblue"
                border.color: "black"
                border.width: index == root.activeIndex ? 4:0
                Text {
                    id: name
                    text: model.cname
                    anchors.centerIn: parent
                    font.pointSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        root.activateClass(index);
                        root.activeIndex = index;
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.fill:classView
        border.width: 2
        border.color: "black"
        color: "transparent"
    }

}
