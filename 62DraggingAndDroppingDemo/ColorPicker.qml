import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    width: parent.width
    height: parent.height

    property int rwidth: 640
    property var pcolors: ["red","green","blue","yellow","orange","pink","lightgray","cyan"]

    function updateWidth() {
        if (root.width==640)
            root.width = 641
        else
            root.width = 640
    }

    DropArea {
        id: droparea
        property alias color: bRect.color
        width: parent.width * .8
        height: parent.height*.8
        x: parent.width * .1

        onDropped: {
            console.log("Item dropped")
            root.updateWidth();
        }

        Rectangle {
            id:bRect
            anchors.fill: parent
            color: "gray"
        }
    }

    RowLayout {
        id:row
        spacing: 1
        anchors.topMargin: 10
        anchors.top: droparea.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Repeater {
            model: pcolors
            delegate: Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumHeight: 50
                Layout.minimumWidth: 50
                radius: 10
                color:modelData

                border.color: "black"
                border.width: 2
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
