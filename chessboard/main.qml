import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 880
    height: 880
    title: qsTr("Chessboard")

    function isDark(index) {
        var row = Math.floor(index / 8);
        var ans = row%2===index%2;
        return ans;
    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: 40
        Repeater {
            model: 8
            Rectangle {
                width: 40
                height: board.height/8
                Text {
                    anchors.centerIn: parent
                    id: name
                    text: 8 - index
                    font.pointSize: 30
                }
            }
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 40
        Repeater {
            model: 8
            Rectangle {
                width: board.width/8
                height: 40
                Text {
                    anchors.centerIn: parent
                    text: String.fromCharCode(65+index);
                    font.pointSize: 30
                }
            }
        }
    }

    function getPiece(col,white) {
        var colorchar = white ? "w" : "b";
        col = col+1;
        if(col===1 || col===8 )
            return "qrc:/icons/" + colorchar + "rook.svg";
        if(col===2 || col===7)
            return "qrc:/icons/" + colorchar + "knight.svg";
        if(col===3 || col===6)
            return "qrc:/icons/" + colorchar + "bishop.svg";
        if(col===4)
            return "qrc:/icons/" + colorchar + "queen.svg";
        if(col===5)
            return "qrc:/icons/" + colorchar + "king.svg";
    }

    function getPieceImage(index) {
        let row = Math.floor(index / 8);
        let col = (index - row*8)%8;
        if (row===1)
            return "qrc:/icons/bpawn.svg";
        if(row===6)
            return "qrc:/icons/wpawn.svg";
        if (row===0)
            return getPiece(col,false);
         if (row===7)
            return getPiece(col,true);
    }

    Grid {
        id: board
        anchors.fill: parent
        anchors.margins: 40
        rows: 8
        columns: 8

        Repeater {
            model:64
            Rectangle {
                width: board.width/8
                height: board.height/8
                color: isDark(index)?"lightblue":"white"

                Text {
                    id: name
                    anchors.centerIn: parent
                }
                Image {
                    source: getPieceImage(index);
                    anchors.fill: parent
                    anchors.margins: 5
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked:  {
                        console.log("Clicked:"+name.text + " index:"+index)

                        //name.text = (8-row)+String.fromCharCode(65+col);
                        //name.font.pointSize = 30;
                    }
                }
            }
        }
    }
}
