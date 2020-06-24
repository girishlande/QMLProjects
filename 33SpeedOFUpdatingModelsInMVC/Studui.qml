import QtQuick 2.0

Item {
    id:root
    property int rectcount: 500
    property int sindex: 0
    width: 300
    height: 50

    Rectangle {
        anchors.fill: parent
        color: root.sindex%2==0?"red":"green"
        radius: 20
        Text {
            anchors.centerIn: parent
            font.pointSize: 20
            text: sname
        }
    }

    Flow {
        visible: false
        anchors.fill: parent
        spacing: 1
        Repeater {
            model: root.rectcount
            delegate: Rectangle{
                width: 10
                height: 10
                radius: 2
                color: index%2==0 ? "red": "green"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.rectcount+=1000;
                        console.log("clicked")
                    }
                }
            }
        }
    }
}
