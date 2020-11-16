import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Grid {
        rows: 2
        spacing: 20

        ProfilePicture {
            source: "qrc:/images/dada1.png"
        }
        ProfilePicture {
            source: "qrc:/images/sanu1.png"
        }
        ProfilePicture {
            source: "qrc:/images/sanu2.png"
        }
        ProfilePicture {
            source: "qrc:/images/sanu3.png"
        }
        ProfilePicture {
            source: "qrc:/images/1.png"
        }
    }

}
