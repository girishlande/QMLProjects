import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

Window {
    id: root
    visible: true
    width: 1080
    height: 480
    title: qsTr("Hello World")

    property bool hideMerge: false
    property bool hideDelete: false
    property int controlSize: 0

    function scaled(size) { return size * 1; }
    function scaledInt(size) { return Math.round(scaled(size)); }

    function calculateSize() {
        var mergeSize = Math.max(mergeMetrics.width,unmergeMetrics.width);
        var protectSize = Math.max(protectMetrics.width,unprotectMetrics.width);
        var lockSize = Math.max(lockMetrics.width,unlockMetrics.width);
        var deleteSize = deleteMetrics.width;
        var moreSize = moreMetrics.width;
        var reviewSize = reviewMetrics.width;
        var totalBtnSize = mergeSize +  protectSize + lockSize + deleteSize + moreSize + reviewSize;
        console.log("total button size:"+totalBtnSize)

        var totalLabelSize = patientMetrics.width+selectionMetrics.width;
        console.log("total label size:"+totalLabelSize)

        var totalSpacing = 7 * patientListActionBarBackground.spacing
        console.log("total spacing:"+totalSpacing)

        var total = totalBtnSize + totalLabelSize+totalSpacing + 30;
        console.log("total:"+total)
        return total;
    }

    function hideButtons() {
        var x = root.width;
        var mergeSize = Math.max(mergeMetrics.width,unmergeMetrics.width);
        var y = root.controlSize;
        if (y>x) {
            hideMerge = true;
            y = y - mergeSize;
        } else {
            hideMerge = false;
        }

        if (y>x) {
            hideDelete = true;
        } else {
            hideDelete = false;
        }
    }

    Component.onCompleted:  {
        root.controlSize = calculateSize();
    }
    onWidthChanged: {
        hideButtons();
    }

    TextMetrics {
        id: mergeMetrics
        text: qsTr("Merge")
        font: mergeButton.font
    }
    TextMetrics {
        id: unmergeMetrics
        text: qsTr("Unmerge")
        font: mergeButton.font
    }
    TextMetrics {
        id: deleteMetrics
        text: qsTr("Delete")
        font: mergeButton.font
    }
    TextMetrics {
        id: protectMetrics
        text: qsTr("Protect")
        font: mergeButton.font
    }
    TextMetrics {
        id: unprotectMetrics
        text: qsTr("Unprotect")
        font: mergeButton.font
    }
    TextMetrics {
        id:lockMetrics
        text: qsTr("Lock")
        font: mergeButton.font
    }
    TextMetrics {
        id:unlockMetrics
        text: qsTr("Unlock")
        font: mergeButton.font
    }
    TextMetrics {
        id:reviewMetrics
        text: qsTr("Review")
        font: mergeButton.font
    }
    TextMetrics {
        id:moreMetrics
        text: qsTr("More")
        font: mergeButton.font
    }
    TextMetrics {
        id:patientMetrics
        text: qsTr("All Patients")
        font: patientsLabel.font
    }
    TextMetrics {
        id:selectionMetrics
        text: qsTr("selected 1 of 10")
        font: patientsSelectedLabel.font
    }


    Rectangle {
        id: backRect
        anchors.fill: parent

        RowLayout {
            id: patientListActionBarBackground
            anchors.topMargin: scaledInt(64)
            anchors.rightMargin: scaledInt(34)
            anchors.leftMargin: scaledInt(34)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: scaledInt(47)
            clip: true
            spacing: scaledInt(10)

            Text {
                id: patientsLabel
                text: "All Patients"
                elide: Text.ElideRight
                font.pixelSize: scaledInt(17)
            }

            Text {
                id: patientsSelectedLabel
                Layout.alignment: Qt.AlignBaseline
                Layout.leftMargin: scaledInt(8)
                //: Header text for the patient list
                text: "selected 1 of 10"
                font.letterSpacing: scaled(1)
                font.bold: false
                font.pixelSize: scaledInt(12)
            }

            Item {
                Layout.fillWidth: true
            }

            RowLayout {
                id: patientListActionBar
                Layout.leftMargin: scaledInt(42)
                spacing: scaledInt(10)

                MButton {
                    id: unmergeButton
                    text: qsTr("Unmerge")
                    visible: !mergeButton.visible && !hideMerge
                    width: unmergeMetrics.advanceWidth
                }

                MButton {
                    id: mergeButton
                    text: qsTr("Merge")
                    width: mergeMetrics.advanceWidth
                    visible: !hideMerge
                    onClicked: {
                        calculateSize();
                        console.log("backrect:" + backRect.width)
                        console.log("backrect action bar back" + patientListActionBarBackground.width)
                        console.log("backrect action bar:" + patientListActionBar.width)
                        console.log("merge width:"+mergeButton.width)
                        console.log("unmerge width:"+unmergeButton.width)
                    }
                }

                MButton {
                    id: deleteButton
                    text: qsTr("Delete")
                    width: deleteMetrics.advanceWidth
                    visible: !hideDelete
                }

                MButton {
                    id: protectButton
                    text: qsTr("Protect")
                    width: protectMetrics.advanceWidth
                }

                MButton {
                    id: unprotectButton
                    text: qsTr("Unprotect")
                    visible: !protectButton.visible
                    width: unprotectMetrics.advanceWidth
                }

                MButton {
                    id: unlockButton
                    text: qsTr("Unlock")
                    visible: !lockButton.visible
                    width: unlockMetrics.advanceWidth
                }

                MButton {
                    id: lockButton
                    text: qsTr("Lock")
                    width: lockMetrics.advanceWidth
                }

                MButton {
                    id: reviewButton
                    text: qsTr("Review")
                    width: reviewMetrics.advanceWidth
                }

                MButton {
                    id: moreButton
                    text: qsTr("More")
                    onClicked: moreMenu.open()
                    width: moreMetrics.advanceWidth

                    Menu {
                        id: moreMenu
                        width: scaledInt(188)
                        x: -(width - moreButton.width - patientListActionBar.spacing)
                        y: parent.height

                        background: Rectangle {
                            implicitWidth: scaledInt(142)
                            color: "lightblue"
                            radius: scaled(4)
                            border.width: scaledInt(1);
                            border.color: "black"
                        }

                        MenuItem {
                            text: qsTr("Export...")
                        }

                        MenuItem {
                            id: assignButton
                            text: qsTr("Assign...")
                            hoverEnabled: true
                        }


                        MenuItem {
                            id: mergeMenuItem
                            text: qsTr("Merge")
                            height: visible? implicitHeight : 0
                        }

                        MenuItem {
                            id: unmergeMenuItem
                            text: qsTr("Unmerge")
                            visible: !mergeMenuItem.visible
                            height: visible? implicitHeight : 0
                        }


                        MenuItem {
                            id: deleteMenuItem
                            text: qsTr("Delete")
                            height: visible? implicitHeight : 0
                        }
                    }
                }

            }
        }
    }
}
