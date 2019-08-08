import QtQuick 2.0

Item {
    id: root
    property color bracketColor: "white"
    property color slotColor: "white"
    property int bracketHeight: 10
    property int bracketWidth: 10
    property int bracketMaxPosition: 100
    property int bracketPosition: 0
    property alias leftBracketPosition: leftBracket.x
    property alias rightBracketPosition: rightbracket.x

    Bracket {
        id: leftBracket
        width: bracketWidth
        height: bracketHeight
        color: bracketColor
        slotColor: root.slotColor
        x: bracketPosition
        minPosition: 0
        maxPosition: rightbracket.x - leftBracket.width
        leftPosition: true
    }

    Bracket {
        id: rightbracket
        width: bracketWidth
        height: bracketHeight
        color: bracketColor
        slotColor: root.slotColor
        x: bracketPosition + rightbracket.width + 10
        minPosition: leftBracket.x + rightbracket.width
        maxPosition: root.bracketMaxPosition - rightbracket.width
        leftPosition: false
    }
}
