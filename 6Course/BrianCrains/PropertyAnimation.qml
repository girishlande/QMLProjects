import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: Screen.width
    height: 480
    title: qsTr("Hello World")

    id: root

    Rectangle {
        id: rect
        y:parent.height/2
        width: 100
        height: 100
        radius: 10
        color: "red"

        PropertyAnimation {
            id: anim1
            target: rect
            property: "x"
            from: rect.x
            to: root.width - rect.width
            duration: 2000
        }


        PropertyAnimation {
            id: anim2
            target: rect
            property: "x"
            from: rect.x
            to: 0
            duration: 2000
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Clicked")
                if(rect.x===0)
                    anim1.start();
                else
                    anim2.start();
            }
        }

    }
}
