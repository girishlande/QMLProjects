import QtQuick 2.0

Item {

    anchors.fill: parent

    property int fromIndex: -1
    property int toIndex: -1

    Component.onCompleted: {
        gridView.model.append({"rectcolor":"black","textcolor":"white"});
        gridView.model.append({"rectcolor":"blue","textcolor":"white"});
        gridView.model.append({"rectcolor":"brown","textcolor":"white"});
        gridView.model.append({"rectcolor":"gray","textcolor":"white"});
        gridView.model.append({"rectcolor":"green","textcolor":"white"});
        gridView.model.append({"rectcolor":"yellow","textcolor":"white"});
        gridView.model.append({"rectcolor":"cyan","textcolor":"black"});
        gridView.model.append({"rectcolor":"lightgray","textcolor":"white"});
        gridView.model.append({"rectcolor":"orange","textcolor":"black"});
    }

    Rectangle {
        id: headerRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        height: 50
        color: "white"
        Text {
            id: resultText
            anchors.centerIn: parent
            font.pointSize: 30
            text: qsTr("text")
        }
    }

    Item {
        id:containerItem
        anchors.top: headerRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        GridView {
            id:gridView
            anchors.fill: parent
            model: ListModel{}
            cellWidth: gridView.width/4
            cellHeight: 100
            DropArea {
                id: dropArea
                anchors.fill: parent
                onDropped: {
                    toIndex = gridView.indexAt(dropArea.drag.x,dropArea.drag.y);
                    var result = "Moved " + gridView.model.get(fromIndex).rectcolor + " to "+ gridView.model.get(toIndex).rectcolor;
                    resultText.text = result;
                }
            }

            delegate: Rectangle {
                id:rect
                width: gridView.width/4
                height: 100
                Drag.active: rectMouseArea.drag.active
                Drag.hotSpot.x: rect.width/2
                Drag.hotSpot.y: rect.height/2
                color: rectcolor
                radius: 5
                MouseArea{
                    id: rectMouseArea
                    anchors.fill: parent
                    drag.target: rect
                    drag.onActiveChanged: {
                        if(rectMouseArea.drag.active) {
                            gridView.model.move(index,gridView.model.count-1,1);
                            fromIndex = index;
                        }
                        rect.Drag.drop();
                    }
                }
            }
        }

    }
}
