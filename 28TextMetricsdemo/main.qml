import QtQuick 2.12
import QtQuick.Window 2.12

import QtQuick.Controls 2.4

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property bool overflow: false

    function hideButton() {
        if (labelButton3.visible) {
            labelButton3.visible = false;
            createButton(3);
        } else if (labelButton2.visible) {
            labelButton2.visible = false;
            createButton(2);
        }
    }

    function createButton(index) {
        console.log("Button added")
        var obj = Qt.createQmlObject('import QtQuick 2.12;import QtQuick.Controls 2.4; MenuItem {
                    text: labelButton3.text
                    visible: !labelButton3.visible
                }',zoomMenu,"menuitem");
        if (index===2)
            obj.text = labelButton2.text;
        if (index===3)
            obj.text = labelButton3.text;
        zoomMenu.addItem(obj);
        return obj;
    }

    TextMetrics {
        id: textMetrics
        font.family: "Arial"
        font.pointSize: 10
        elide: Text.ElideNone
        text: name.text
    }

    Row {
        id:btnRow
        spacing: 10
        Button {
            id: labelButton1
            width: textMetrics.advanceWidth + 40
            text: "B1:" + textMetrics.text
            font: textMetrics.font

            onClicked: {
                console.log("thank you clicked:"+text.length)
                console.log(textMetrics.advanceWidth);
            }
        }

        Button {
            id: labelButton2
            width: textMetrics.advanceWidth + 40
            text: "B2:" + textMetrics.text
            font: textMetrics.font

            onClicked: {
                console.log("thank you clicked:"+text.length)
                console.log(textMetrics.advanceWidth);
            }
        }

        Button {
            id: labelButton3
            width: textMetrics.advanceWidth + 40
            text: "B3:" + textMetrics.text
            font: textMetrics.font

            onClicked: {
                console.log("thank you clicked:"+text.length)
                console.log(textMetrics.advanceWidth);
            }
        }

        Button {
            text: "Menu"
            onClicked: {
                zoomMenu.open()
            }

            Menu {
                id:zoomMenu
                MenuItem {
                    text: qsTr("Zoom In")
                }

                MenuItem {
                    text: qsTr("Zoom Out")
                }

            }
        }
    }
    Text {
        id: t1
        text: "dynamic button (font:" + labelButton1.font.pointSize + " width:" + labelButton1.width + ")"
        anchors.top: btnRow.bottom
        anchors.margins: 10
        font.pointSize: 16
    }


    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 40
        color: "lightgreen"
        Row {
            anchors.fill: parent
            Text {
                id: t2
                font.pointSize: 16
                text: "Input text:"
            }
            TextInput {
                id: name
                text: qsTr("Button Text")
                font.pointSize: 16
                width: parent.width - t2.width
                onTextChanged: {
                    console.log(btnRow.width)
                    if (btnRow.width>=root.width) {
                        root.overflow = true;
                        hideButton();
                        console.log("Overflow")
                    } else {
                        root.overflow = false;
                    }
                }
            }
        }
    }

}
