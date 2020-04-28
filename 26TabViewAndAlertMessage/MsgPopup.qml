import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

Popup {
    id: root
    property QtObject model
    property bool animatedExit: false
    property bool slideFromLeft: true
    readonly property int maxWidth: scaled(410)
    property real animationSpeed: maxWidth / 300
    readonly property int desiredWidth: textMetrics.advanceWidth +
                                        layout.spacing + layout.anchors.margins * 2
    width: background.width
    height: background.height

    function scaled(size) { return size * 1; }
    function scaledInt(size) { return Math.round(scaled(size)); }


    signal closeAction();
    signal undoAction();

    background: Item {
        clip: true
        height: layout.implicitHeight + layout.anchors.margins * 2
        width: desiredWidth > maxWidth ? maxWidth : desiredWidth

        TextMetrics {
            id: textMetrics
            font: label.font
            text: label.text
        }

        Rectangle {
            id: background
            
            color: "lightblue"
            border.width: scaledInt(1)
            border.color: "black"
            radius: scaledInt(4)
            height: parent.height
            width: parent.width
            x: root.slideFromLeft ? -maxWidth : maxWidth

            RowLayout {
                id: layout

                spacing: scaledInt(12)
                anchors.margins: scaledInt(8)
                anchors.fill: parent

                Label {
                    id: label
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    text: model ? model.text : ""
                    wrapMode: Text.WrapAnywhere
                    maximumLineCount: 1
                    font.pixelSize: scaledInt(20)
                    font.letterSpacing: scaledInt(1)
                    elide: Text.ElideRight
                }
                
            }
        }
    }

    closePolicy: Popup.NoAutoClose

    enter: Transition {
        NumberAnimation {
            id: slideIn
            target: background
            properties: "x"
            from: root.slideFromLeft ? -background.width : background.width
            to: 0
            duration: background.width / animationSpeed
        }
    }

    exit: Transition {
        id: transition
        NumberAnimation {
            id: slideOut
            target: background
            properties: "x"
            from: 0
            to: root.slideFromLeft ? -background.width : background.width
            duration: animatedExit ? background.width / animationSpeed : 0
        }
        onRunningChanged: {
            if(!running && model) {
                model.alertClosed(model);
            }
        }
    }

    onOpened: {
        timeout.start();
        animatedExit = true;
    }

    function forceClose() {
        stopAnimation();
        timeout.stop();
        animatedExit = false;
        close();
    }

    function stopAnimation() {
        // no need to check if it's running since complete() does nothing when it's not running according to Qt docs
        slideIn.complete();
        slideOut.complete();
    }

    Timer {
        id: timeout
        interval: 2000
        onTriggered: root.close()
    }
}
