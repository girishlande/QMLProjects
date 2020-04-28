import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Image {
        id: marioImg
        source: "qrc:/images/mario.png"
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                marioImg.rotation-=20
                marioImg.scale-=0.1
            }
        }
    }

    Button {
        text: "Click me"
        onClicked: {
            marioImg.rotation+=20;
            marioImg.scale+=0.1
        }
    }

}
