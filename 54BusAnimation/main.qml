import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Bus Animation")

    BusDemo{
        width: parent.width
        height: 300
    }

}
