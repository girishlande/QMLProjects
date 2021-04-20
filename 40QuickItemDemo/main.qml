import QtQuick 2.12
import QtQuick.Window 2.12
import stackoverflow.qml 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Rectangle {
          width: 200
          height: 200
          anchors.centerIn: parent
          color: "lightgrey"

          Triangle {
              id: rect
              width: 200
              height: 200
              transformOrigin: Item.Top
              color: "green"
              PropertyAnimation on rotation {
                  from: 0
                  to: 360
                  duration: 5000
                  loops: Animation.Infinite
              }
          }
      }
      Timer {
          interval: 1000
          repeat: true
          running: true
          onTriggered: rect.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
      }
}
