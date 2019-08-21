import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    TabView {
        anchors.fill: parent
        Tab {
            title: "All Students"
            StudentDetails{
                anchors.fill: parent
            }
        }
        Tab {
            title: "Add Student"

            AddStudent {
                anchors.fill: parent

            }
        }
    }

}
