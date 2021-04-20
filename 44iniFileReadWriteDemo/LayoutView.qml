import QtQuick 2.0
import MyConfig 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

Item {

    LayoutConfig {
        id: layoutdata
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 20
        ListView {
            anchors.fill: parent
            model: layoutdata
            delegate: Rectangle {
                width: parent.width
                height: 50
                border.color: "black"
                border.width: 1
                RowLayout {
                    spacing: 0
                    anchors.fill: parent
                    SText{
                        text: stitle
                        onDatamodified: {
                            model.stitle = stext.text;
                        }
                    }

                    SText{
                        text: srow
                        stext.validator: IntValidator {bottom: 1; top: 20;}
                        onDatamodified: {
                            srow = stext.text;
                        }
                    }

                    SText{
                        text: scolumn
                        stext.validator: IntValidator {bottom: 1; top: 20;}
                        onDatamodified: {
                            scolumn = stext.text;
                        }
                    }
                    SText {
                        text: sreadonly
                    }
                    SText{
                        text: " " + sshortcut
                    }
                }
            }
        }
    }

    Row {
        id: myrow
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        spacing: 10

        Button {
            id: importButton
            text: "Import"
            onClicked: {
                importfileDialog.open();
            }
        }

        Button {
            id: exportButton
            text: "Export"
            onClicked: {
                exportfileDialog.open();
            }
        }
    }

    FileDialog {
        id: importfileDialog
        title: "Please choose a file"
        folder: shortcuts.desktop
        nameFilters: [ "config files (*.ini)" ]
        onAccepted: {
            layoutdata.readConfigFile(importfileDialog.fileUrl);
        }
    }

    FileDialog {
        id: exportfileDialog
        title: "Please choose a file"
        folder: shortcuts.desktop
        selectExisting: false
        nameFilters: [ "config files (*.ini)" ]
        onAccepted: {
            layoutdata.writeConfigFile(exportfileDialog.fileUrl);
        }
    }
}
