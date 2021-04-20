import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.5

Dialog {
    id: root
    width: 300
    height: 300

    Rectangle {
        anchors.fill: parent
        color: "gray"
    }

    Button {
        text: "Ok"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        onClicked: {
            stud.addStudentsOneByOne();
            root.accept();
        }
    }
}
