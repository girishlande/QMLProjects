import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: r1
        width: 200
        height: 200
        color: "red"
        anchors.centerIn: parent
        Smallrect {
            anchors.left: r1.right
            anchors.bottom: r1.top
        }

        Smallrect {
            anchors.left: r1.right
            anchors.top: r1.bottom
        }

        Smallrect {
            anchors.right: r1.left
            anchors.bottom: r1.top
        }

        Smallrect {
            anchors.right: r1.left
            anchors.top: r1.bottom
        }
        Smallrect {
            anchors.verticalCenter: r1.verticalCenter
            anchors.right: r1.left
        }
        Smallrect {
            anchors.verticalCenter: r1.verticalCenter
            anchors.left: r1.right
        }
        Smallrect {
            anchors.horizontalCenter: r1.horizontalCenter
            anchors.top: r1.bottom
        }
        Smallrect {
            anchors.horizontalCenter: r1.horizontalCenter
           anchors.bottom: r1.top
        }
        Smallrect {
            anchors.centerIn: parent
        }
    }



    Button {
        text:"Rotate"
        onClicked: {
            r1.rotation+=20
        }
    }
}


//////////////// Smallrect.qml

    import QtQuick 2.0
    
    Rectangle {
        width: 50
        height: 50
        color: "green"
    }
