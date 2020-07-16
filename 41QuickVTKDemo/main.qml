import QtQuick 2.10
import VtkQuick 1.0

Rectangle {
    id: root

    width: 800
    height: 600
    color: "yellow"

    Rectangle {
        id : vtkRenderWindowContainer
        anchors.fill: parent
        anchors.margins: 20
        border.width: 4
        border.color: "black"
        color: "blue"

        VtkRenderWindow {
            id: vtkRenderWindow
            anchors.fill: parent
            property real flipAngle: mouseArea.containsMouse ? 0 : 180
            Behavior on flipAngle { NumberAnimation {} }
            transform: Rotation {
                origin { x: vtkRenderWindow.width/2; y: vtkRenderWindow.height/2 }
                axis { x: 0; y: 1; z: 0 }
                angle: vtkRenderWindow.flipAngle
            }
        }
    }

    Rectangle {
        id: reactiveRect
        color: "mintcream"
        opacity: 0.8
        radius: 10
        border.width: 5
        border.color: "mintcream"

        width: 600
        height: 200

        anchors.centerIn: vtkRenderWindowContainer

        rotation: mouseArea.containsMouse ? -4 : 4
        Behavior on rotation { NumberAnimation {} }

        Text {
            id: label
            anchors.fill: parent
            anchors.margins: 20
            color: mouseArea.containsMouse ? "deeppink" : "dodgerblue"
            Behavior on color { ColorAnimation { duration: 200 } }
            wrapMode: Text.WordWrap
            font.pointSize: 16
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            text: "The objects inside the blue rectangle are rendered to an FBO by QVTKFrameBufferObject. Everything else is a standard Qt Quick component."
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
