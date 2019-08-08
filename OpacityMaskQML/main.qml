import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Row {
        id:stepNumberLabel1
        visible: true
        Repeater {
            model:7
            Image{
                source: "qrc:/11.png"
                width: 200
                height: 200
            }
        }
        opacity: .4
    }


    Row {
        id:stepNumberLabel
        visible: false
        Repeater {
            model:7
            Image{
                source: "qrc:/11.png"
                width: 200
                height: 200
            }
        }
    }

    Rectangle {
        id:mask
        width: stepNumberLabel.implicitWidth
        height: stepNumberLabel.implicitHeight
        color: "transparent"
        Rectangle {
            id: visiblePart
            x: b1.leftBracketPosition + b1.width
            width: b1.rightBracketPosition - b1.leftBracketPosition
            height: 200
            color: "black"  // anything but transparent
        }
        visible: false
    }

    Rectangle {
        id:mask2
        width: stepNumberLabel.implicitWidth
        height: stepNumberLabel.implicitHeight
        color: "transparent"
        Rectangle {
            id: visiblePart2
            x: b2.leftBracketPosition + b2.width
            width: b2.rightBracketPosition - b2.leftBracketPosition
            height: 200
            color: "black"  // anything but transparent
        }
        visible: false
    }


    OpacityMask {
        width: stepNumberLabel.implicitWidth
        height: stepNumberLabel.implicitHeight
        source: stepNumberLabel
        maskSource: mask
        invert: false
    }

    OpacityMask {
        width: stepNumberLabel.implicitWidth
        height: stepNumberLabel.implicitHeight
        source: stepNumberLabel
        maskSource: mask2
        invert: false
    }

    BracketPair {
        id:b1
        bracketWidth: 20
        bracketHeight: 200
        bracketPosition: 0
        bracketMaxPosition: parent.width
        slotColor: "red"
        bracketColor: "gray"
    }

    BracketPair {
        id:b2
        bracketWidth: 20
        bracketHeight: 200
        bracketPosition: 100
        bracketMaxPosition: parent.width
        slotColor: "red"
        bracketColor: "gray"
    }



}
