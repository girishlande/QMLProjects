import QtQuick 2.12
import QtQuick.Window 2.12
import Student 1.0
import QtQuick.Controls 2.4

Window {
    visible: true
    width: Screen.width
    height: 480
    title: qsTr("Hello World")


    ProgressBar {
        id: progressBar
        width: parent.width
        height: 100
        from: 0
        to: 100
        Behavior on value {
            NumberAnimation {
                duration: 250
            }
        }
    }

    Button {
        text: "Update progress"
        onClicked: {
            progressBar.value+=10;
        }
    }
}
