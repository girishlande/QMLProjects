import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")



    Rectangle {
        anchors.fill: parent
        color: "black"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onMouseXChanged: {
                smallrect.x = mouseX
            }
            onMouseYChanged: {
                smallrect.y = mouseY
            }
        }
    }

    ProfilePicture {
        source: "qrc:/images/dada1.png"
        width: 100
        height: 100
        color: "red"
        radius: width
        x: smallrect.x -5
        y: smallrect.y - 5
        Behavior on x { SmoothedAnimation {velocity: 200}}
        Behavior on y { SmoothedAnimation {velocity: 200}}
    }

    ProfilePicture {
        id:smallrect
        source: "qrc:/images/sanu2.png"
        width: 75
        height: 75
        radius: 75
        color: "pink"
        x: parent.width/2
        y: parent.height/2

        focus: true
        Keys.onRightPressed: {
            if (smallrect.x+smallrect.width*2 < parent.width)
            smallrect.x += 100
        }
        Keys.onLeftPressed:  {
         if (smallrect.x - 100 > 0)
            smallrect.x -= 100
        }
        Keys.onUpPressed: {
            if ((smallrect.y - 100) > 0)
            smallrect.y -= 100
        }
        Keys.onDownPressed: {
            if (smallrect.y+smallrect.height*4 < parent.height)
            smallrect.y += 100
        }
    }


}
