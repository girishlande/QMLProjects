import QtQuick 2.0

Item {
    property var pcolors: ["red","green","blue","yellow","orange","red","green","blue"]
    DropArea {
        id: droparea
        property alias color: bRect.color
        width: parent.width
        height: parent.height*.8

        onDropped: {
            console.log("Item dropped")
        }

        Rectangle {
            id:bRect
            anchors.fill: parent
            color: "gray"
        }
    }

    Row {
        id:row
        spacing: 1
        anchors.top: droparea.bottom
        anchors.bottom: parent.bottom

        Repeater {
            model: pcolors
            delegate: Rectangle {
                width: root.width / pcolors.length
                height: row.height
                radius: width*0.1
                color:modelData

                Drag.active: mouseArea.drag.active

                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    drag.target: parent
                    onReleased: {
                        parent.Drag.drop()
                        bRect.color = modelData
                    }
                }
            }
        }
    }
}
