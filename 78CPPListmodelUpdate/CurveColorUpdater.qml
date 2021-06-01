import QtQuick 2.0
import QtQuick.Controls 2.12
import "./"

Rectangle {
    color: "black"
    width: col.implicitWidth * 1.2
    height: col.implicitHeight * 1.2
    border.color: "cyan"
    border.width: 5
    radius: 20

    Column {
        id: col
        spacing: 5
        anchors.centerIn: parent

        CurveColorModel {
            id: curvecolormodel
        }

        Repeater {
            id: curverepeatermodel
            model: ECGCurvemodel

            Row {
                id: modelRow
                spacing: 10

                Rectangle {
                    height: 40
                    width: 40
                    color: model.curvecolor
                    border.color: "cyan"
                    border.width: 2
                }

                CheckBox {
                    indicator.width: 40
                    indicator.height: 40
                    checked: model.curvevisible
                    onCheckedChanged: model.curvevisible = checked
                    visible: false
                }

                Rectangle {
                    width: 100
                    height: 40
                    color: "black"
                    border.color: "cyan"
                    border.width: 2
                    Text {
                        text: model.name
                        anchors.centerIn: parent
                        anchors.fill: parent
                        font.pixelSize: 14
                        color: "white"
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                }
                Item {
                    id: curvecolorparent
                    width: curvecolorcombo.width
                    height: curvecolorcombo.implicitHeight

                    property string colorvalue: model.curvecolor
                    signal updateCurveColor(var newcolor);
                    onUpdateCurveColor: {
                        model.curvecolor = newcolor;
                    }

                    function findColorIndex() {
                        for(var i = 0;i<curvecolormodel.count;i++) {
                            var col = curvecolormodel.get(i).value;
                            if (col===curvecolorparent.colorvalue)
                                return i;
                        }
                        return -1;
                    }

                    ComboBox {
                        id: curvecolorcombo
                        width: 80
                        model: curvecolormodel
                        textRole: "localeValue"
                        currentIndex: curvecolorparent.findColorIndex()
                        onCurrentIndexChanged: {
                            curvecolorparent.updateCurveColor(curvecolormodel.get(currentIndex).value);
                        }
                    }
                }

            }
        } // repeater

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Button {
                text: "CANCEL"
            }
            Button {
                text: "SAVE"
                onClicked: ECGCurvemodel.printECGCurves()
            }
        }
    }
}
