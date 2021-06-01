import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Window {
        id: w1
        width: 200
        height: 200

        Rectangle {
            id:r3
            anchors.fill: parent
        }

        onVisibilityChanged: {
            ball.parent = r1
        }
    }

    Row {
        Rectangle {
            id: r1
            width: root.width/2
            height: root.height/2
            color: "green"
            Rectangle {
                id: ball
                width: 100
                height: 100
                color: "pink"
            }
        }
        Rectangle {
            id: r2
            width: root.width/2
            height: root.height/2
            color: "orange"
        }
    }

    Button {
        text: "Change parent"
        y:root.height - 100
        onClicked: {
            w1.show();
            ball.parent = r3
        }
    }


}
