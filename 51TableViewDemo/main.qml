import QtQuick 2.12
import QtQuick.Window 2.12
import tablemodel 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Table View Demo")

    TabView {
        anchors.fill: parent
        Tab {
            title: "Custom Table "
            CustomTable{
            }
        }
        Tab {
            title: "G Table"
            GTableView{}
        }
        Tab {
            title: "Table Model"
            TableModeldemo {}
        }
        Tab {
            title: "Table View with Animation"
            TableViewWithAnimation {}
        }

        style: TabViewStyle {
               frameOverlap: 1
               tab: Rectangle {
                   color: styleData.selected ? "steelblue" :"lightsteelblue"
                   border.color:  "steelblue"
                   implicitWidth: Math.max(text.width + 4, 180)
                   implicitHeight: 50
                   radius: 2
                   Text {
                       id: text
                       anchors.centerIn: parent
                       text: styleData.title
                       color: styleData.selected ? "white" : "black"
                       font.pointSize: 16
                   }
               }
               frame: Rectangle { color: "steelblue" }
           }
    }
}
