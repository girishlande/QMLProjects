import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 640
    height: 640
    title: qsTr("Chessboard")

    function isDark(index) {
        var row = Math.floor(index / 8);
        var ans = row%2===index%2;
        return ans;
    }

    Grid {
        id: board
        anchors.fill: parent
        rows: 8
        columns: 8

        Repeater {
            model:64
            Rectangle {
                width: board.width/8
                height: board.height/8
                color: isDark(index)?"orange":"green"

                Text {
                    id: name
                    text: index+1
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked:  {
                        console.log("Clicked:"+name.text)
                    }
                }
            }
        }
    }
}
