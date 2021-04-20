import QtQuick 2.0

Item {
    id: root
    width: 400
    height: 400

    property alias scolor : myrect.color
    property alias stext: rectText.text
    signal pageClicked

    Rectangle {
        id: myrect
        anchors.fill: parent

        Text {
            id: rectText
            font.pointSize: 20
            anchors.centerIn: parent
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                root.pageClicked();
            }
        }
    }

}
