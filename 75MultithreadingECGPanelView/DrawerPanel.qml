import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root

    anchors.fill: parent

    property var panelstates: ["openHorizontal","closeHorizontal","openvertical","closevertical"]
    property int counter: 0
    property int thickness: 400
    property var orientation: Qt.Vertical
    property int stateOffset: orientation == Qt.Vertical ? 0 : 2
    property int globalY: parent.height
    property bool panelOpen: false

    signal clicked();
    signal showPopup();

    function toggleState() {
        root.panelOpen = !root.panelOpen
        updatePanelState();
    }
    function openPanel() {
        root.panelOpen = true;
        updatePanelState();
    }
    function closePanel() {
        root.panelOpen = false;
        updatePanelState();
    }
    function instantClose() {
        root.panelOpen = false;
        panel.state = "closeQuickHorizontal";
    }

    function updatePanelState() {
        if(root.panelOpen)
            panel.state = "openHorizontal";
        else
            panel.state = "closeHorizontal";
    }

    onClicked: {
        root.toggleState();
    }

    Rectangle {
        id:panel

        x: 0
        y: root.globalY - root.thickness * 0.1
        width: orientation == Qt.Horizontal ? parent.width : thickness
        height: orientation == Qt.Horizontal ? thickness : parent.height
        radius: 2
        color: "black"
        state: "closeHorizontal"

        Rectangle {
            id:panelTopStrip
            width: parent.width
            height: 48
            color: "black"

            Row {
                spacing: 10
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 8
                Image {
                    source: "qrc:/images/max1.png"
                    width: 32
                    height: 32
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            root.instantClose();
                            root.showPopup();
                        }
                    }
                }

                Image {
                    source: "qrc:/images/min1.png"
                    width: 32
                    height: 32
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            root.clicked();
                        }
                    }
                }
            }
        }

        Rectangle {
            id: panelGraphArea
            anchors.top: panelTopStrip.bottom
            width: parent.width
            height: parent.height - panelTopStrip.height

            Loader {
                id: charViewLoader
                anchors.fill: parent

                source: "View1.qml"
                asynchronous: true
            }
        }

        states: [
            State {
                name: "openHorizontal"
                PropertyChanges {  target: panel;      y: root.globalY - root.thickness}
            },
            State {
                name: "closeHorizontal"
                PropertyChanges {  target: panel;      y: root.globalY}
            },
            State {
                name: "closeQuickHorizontal"
                PropertyChanges {  target: panel;      y: root.globalY}
            }
        ]

        transitions: [
            Transition {
                from: "openHorizontal"
                to: "closeHorizontal"
                NumberAnimation {
                    properties: "y"
                    duration: 500
                }
            },
            Transition {
                from: "closeHorizontal"
                to: "openHorizontal"
                NumberAnimation {
                    properties: "y"
                    duration: 500
                }
            }
        ]
    }
}
