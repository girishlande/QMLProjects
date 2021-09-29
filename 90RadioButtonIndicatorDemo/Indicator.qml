import QtQuick 2.5

Item {
    id: indicator
    property alias color: center.color
    property real power: 1.0
    property real radiusFactor: 0.5
    Rectangle{
        id: outRing
        color: Qt.rgba(midRing.color.r, midRing.color.g, midRing.color.b, Math.pow(0.5, indicator.power))
        radius: height/2
        width: parent.width
        height: parent.height

        Rectangle{
            id: midRing
            color: Qt.rgba(center.color.r, center.color.g, center.color.b, Math.pow(0.5, indicator.power))//Qt.darker(center.color, Math.pow(2, indicator.power))
            height: parent.height*indicator.radiusFactor
            width: height
            radius: height/2
            x:width/2
            y:height/2
            Rectangle{
                id: center
                height: parent.height*indicator.radiusFactor
                width: height
                x:width/2
                y:height/2
                radius: height/2
            }
        }
    }
}
