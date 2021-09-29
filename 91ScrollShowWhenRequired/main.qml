import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property int countRect: 1
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
                id: s1
                anchors.fill: parent
                clip: true
                property bool showScroll: false

                ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                Component.onCompleted:  {
                    s1.showScroll = false;
                    setPolicy();
                }

                function setPolicy() {
                    if(s1.showScroll) {
                        ScrollBar.vertical.policy = ScrollBar.AlwaysOn;
                        console.log("Going True")
                    } else {
                        ScrollBar.vertical.policy = ScrollBar.AlwaysOff;
                        console.log("Going false")
                    }
                }

                Column {
                    id: c1
                    onHeightChanged: {
                        console.log("Column height:" + height + " scroll height:" + root.height * .8)
                        if (c1.height>backRect.height) {
                            s1.showScroll = true;
                        } else {
                            s1.showScroll = false;
                        }
                        s1.setPolicy();
                    }

                    spacing: 20
                    Repeater {
                        model: root.countRect
                        delegate: Rectangle {
                            width: 400
                            height: 100
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

    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "Click to add"
        onClicked: {
            root.countRect++;
        }
    }

}
