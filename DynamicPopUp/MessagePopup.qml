import QtQuick 2.0
import QtQuick.Controls 2.2

Popup {

    id:root

    property alias text: msgText.text
    property int type: 1

    background: Item {
        height: 40
        width: 200
        clip: true
        Rectangle {
            id: backRect
            anchors.fill: parent
            radius: 10
            color: {
                if (root.type==1) return "green";
                if (root.type==2) return "yellow";
                if (root.type==3) return "red";
            }
            Text {
                id: msgText
                anchors.centerIn: parent
                text: "This is message for you"
            }

        }
    }

    enter: Transition {
        //NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 ;duration: 1000}
        NumberAnimation {
            properties: "x"
            from: -backRect.width
            to:0
            duration: 500
        }
    }

    exit: Transition {
        //NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 ;duration: 1000}
        NumberAnimation {
            properties: "x"
            from: 0
            to:-backRect.width
            duration: 500
        }
    }

    onOpened: {
        timeOut.start();
    }

    Timer {
        id:timeOut
        interval: 1000
        onTriggered: {
            root.close();
        }
    }
}
