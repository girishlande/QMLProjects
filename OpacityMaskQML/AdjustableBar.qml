import QtQuick 2.0

Rectangle {
    id: root
    width: 800
    height: 50
    color: "transparent"
    border.color: "darkgray"

    Rectangle {
        x: bracketPairLimits.leftBracketPosition
        width: bracketPairLimits.rightBracketPosition - bracketPairLimits.leftBracketPosition
        height: parent.height
        color: "gray"
    }

    BracketPair {
        id: bracketPairLimits
        bracketWidth: 10
        bracketHeight: root.height-2
        bracketPosition: 100
        bracketMaxPosition: root.width
        slotColor: "gray"
        bracketColor: "black"
    }
}

