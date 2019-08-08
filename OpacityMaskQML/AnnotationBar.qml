import QtQuick 2.0

Rectangle {
    id: root
    width: 800
    height: 50
    color: "gray"
    border.color: "darkgray"

    BracketPair {
        bracketWidth: 10
        bracketHeight: root.height
        bracketPosition: 100
        bracketMaxPosition: root.width
        slotColor: root.color
        bracketColor: "white"
    }

    BracketPair {
        bracketWidth: 10
        bracketHeight: root.height
        bracketPosition: 200
        bracketMaxPosition: root.width
        slotColor: root.color
        bracketColor: "white"
    }

    BracketPair {
        bracketWidth: 10
        bracketHeight: root.height
        bracketPosition: 300
        bracketMaxPosition: root.width
        slotColor: root.color
        bracketColor: "white"
    }
}

