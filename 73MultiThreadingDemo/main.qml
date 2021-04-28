import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4

import PointGenerator 1.0

Item {
    id: root
    width: Screen.width/2
    height: Screen.height/2

    property int modelSize: 4

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"
        Button {
            text: "Add Rectangle"
            onClicked: root.modelSize++
        }

        Rectangle {
            id: backRect
            anchors.right: backgroundRect.right
            width: parent.width*.85
            height: parent.height
            color: "black"
            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                Column {
                    spacing: 10
                    Repeater {
                        model: root.modelSize
                        delegate: Rectangle {
                            width: backRect.width
                            height: 30
                            radius: 5
                            color: index%2==0?"orange":"green"

                            Text {
                                id: name
                                text: pg.ivalue
                                font.pointSize: 20
                                anchors.centerIn: parent
                            }
                            PointGenerator {
                                id:pg
                                pid: index + 2
                                Component.onCompleted: {
                                    pg.init();
                                }
                            }
                        }
                    }

                }
            }
        }
    }

}
