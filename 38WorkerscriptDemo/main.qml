import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Rectangle {
        width: 300
        height: 300
        color: "red"


        Text {
            id: myText
            text: 'Click anywhere'
            font.pointSize: 20
        }

        WorkerScript {
            id: myWorker
            source: "script.mjs"

            onMessage: myText.text = messageObject.reply
        }

        MouseArea {
            anchors.fill: parent
            onClicked: myWorker.sendMessage({ 'x': mouse.x, 'y': mouse.y })
        }
    }
}
