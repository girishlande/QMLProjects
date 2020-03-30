import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Grid {
        rows: 2

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
    }

}
