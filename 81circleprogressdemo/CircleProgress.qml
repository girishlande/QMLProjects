//CircleProgress
import QtQuick 2.12
import QtGraphicalEffects 1.0

ConicalGradient {
    id: control
    width: 200
    height: 200

    property int barWidth: 20
    property color foregroundColor: Qt.rgba(0,0.5,0,1)
    property color backgroundColor: Qt.rgba(0.7,0.7,0.7,1)
    property color textColor: Qt.rgba(0,0.5,0,1)
    property double minValue: 0
    property double maxValue: 100
    property double value: 0
    property double __progress: value/(maxValue-minValue)

    smooth: true
    antialiasing: true
    source: Rectangle {
        width: control.width
        height: control.height
        color: "transparent"
        border.color: control.backgroundColor
        border.width: control.barWidth
        radius: width / 2
    }

    gradient: Gradient {
        GradientStop { position: 0.0; color: control.foregroundColor }
        GradientStop { position: control.__progress; color: control.foregroundColor }
        GradientStop { position: control.__progress + 0.00001; color: control.backgroundColor }
        GradientStop { position: 1.0; color: control.backgroundColor }
    }

    //The specific settings can be introduced separately
    Text{
        anchors.centerIn: parent
        text: (control.__progress*100).toFixed(2)+" %"
        font.pixelSize: 20
        color: control.textColor
    }
}
