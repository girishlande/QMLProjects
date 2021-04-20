import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Demo of plain text vs Style text")

    Rectangle {
        id: main
        width: 400
        height: 400
        focus: true

        property real offset: 0
        property real margin: 8

        Text {
            id: myText
            anchors.fill: parent
            anchors.margins: 10
            wrapMode: Text.WordWrap
            font.family: "Times New Roman"
            font.pixelSize: 14
            textFormat: Text.StyledText
            horizontalAlignment: Text.AlignJustify

            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer at ante dui <a href=\"http://www.digia.com\">www.digia.com</a>.<br/>Curabitur ante est, pulvinar quis adipiscing a, iaculis id ipsum. Nunc blandit condimentum odio vel egestas.<br><ul type=\"bullet\"><li>Coffee<ol type=\"a\"><li>Espresso<li>Cappuccino<li>Latte</ol><li>Juice<ol type=\"1\"><li>Orange</li><li>Apple</li><li>Pineapple</li><li>Tomato</li></ol></li></ul><p><font color=\"#434343\"><i>Proin consectetur <b>sapien</b> in ipsum lacinia sit amet mattis orci interdum. Quisque vitae accumsan lectus. Ut nisi turpis, sollicitudin ut dignissim id, fermentum ac est. Maecenas nec libero leo. Sed ac leo eget ipsum ultricies viverra sit amet eu orci. Praesent et tortor risus, viverra accumsan sapien. Sed faucibus eleifend lectus, sed euismod urna porta eu. Quisque vitae accumsan lectus. Ut nisi turpis, sollicitudin ut dignissim id, fermentum ac est. Maecenas nec libero leo. Sed ac leo eget ipsum ultricies viverra sit amet eu orci."

            onLineLaidOut: {
                line.width = width / 2  - (margin)

                if (line.y + line.height >= height) {
                    line.y -= height - margin
                    line.x = width / 2 + margin
                }
            }
        }
    }

    Column {
        spacing: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Button {
            text:"PlainText"
            width: 100
            height: 50
            onClicked: {
                myText.textFormat = Text.PlainText
            }
        }
        Button {
            text:"StyleText"
            width: 100
            height: 50
            onClicked: {
                myText.textFormat = Text.StyledText
            }
        }
    }

}
