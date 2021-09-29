import QtQuick 2.5
//import AnalogicUiControls.Style 1.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.5
import "."

Item {
    id: radioButton
    Layout.minimumHeight: 30
    implicitHeight: 30 //Style.preferredSize
    implicitWidth: indicator.width + title.paintedWidth + rowLayout.spacing
    Layout.maximumHeight: 30
    property alias text: title.text
    property bool active: false
    property bool enabled: true
    property bool bigFont: false

    signal clicked();

    property alias color: indicator.color
    property alias labelColor: title.color

    RowLayout{
        id: rowLayout
        anchors.fill: parent
        Indicator{
            id: indicator
            color: "cyan"
            Layout.alignment: Qt.AlignVCenter
            height: parent.height
            width: height
            power: 2.0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (radioButton.enabled)
                    {
                        radioButton.clicked()
                        //SoundManager.playToggle()
                    }
                }
            }
        }
        Text{
            id: title
            color: "cyan"
            font{
                //family: Style.fontFamily
                //pixelSize: Style.stdFontSize
                pointSize: radioButton.bigFont ? 15 : 10
                weight: Font.Normal
                capitalization: Font.MixedCase
            }
        }
        Item{
            Layout.fillWidth: true
        }
    }

    states: [
        State{
            name: "ACTIVE"
            when: radioButton.active
            PropertyChanges{
                target: indicator
                color: "cyan"
            }
        }

    ]
}

