import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Dialog {
    id: aboutPopup

    function scaled(size) { return size * 1; }
    function scaledInt(size) { return Math.round(scaled(size)); }

    property var colors: ["red","green","yellow","blue","purple","pink","magenta","brown","cyan","orange","steelblue"]

    x: scaledInt(50)
    y: scaledInt(100)
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    width: scaledInt(800)
    height: scaledInt(960)

    header: Item {
        id: aboutPageHeader
        height: backIcon.height
        Button {
            id: backIcon
            anchors.left: parent.left
            anchors.top: parent.top
            flat: true
            font.letterSpacing: scaled(1)
            font.bold: false
            font.pixelSize: scaledInt(20)
            text: qsTr("Back")
            onClicked: {
                stack.indexChange()
            }
        }
        Text {
            id: name
            text: qsTr("Stack Layout Demo")
            font.pointSize: 20
            anchors.centerIn: parent
        }

    }

    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: 0

        function indexChange() {
            stack.currentIndex = (stack.currentIndex + 1) % stack.count
        }

        Repeater {
            model: colors.length

            MyPage {
                Layout.fillHeight: true
                Layout.fillWidth: true
                scolor: colors[index]
                stext: "Page " + (index + 1)
                onPageClicked: stack.indexChange();
            }
        }

    }
}
