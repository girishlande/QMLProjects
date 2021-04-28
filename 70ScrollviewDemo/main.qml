import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    id: root
    visible: true
    width: 600
    height: 400
    title: "scrollView Demo"

    property var colors: ["red","blue","orange","yellow"]

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "gray"

        Rectangle {
            id: backRect
            width: parent.width *.8
            height: parent.height * .8
            color: "green"
            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                Column {
                    spacing: 20
                    Repeater {
                        model: 10
                        delegate: Rectangle {
                            width: 400
                            height: 200
                            color: root.colors[index%4]
                            Text {
                                text: qsTr("Rectangle:") + (index+1)
                                anchors.centerIn: parent
                                font.pointSize: 20
                            }
                        }
                    }

                }
            }
        }
    }
}
