import QtQuick.Controls 2.4

Popup {
    id: popup

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    property alias startindex: inspectedWave.startindex
    property alias endindex: inspectedWave.endindex
    property alias points: inspectedWave.points

    WaveRectangle {
        id: inspectedWave
        width: parent.width
        height: waveRect.height
        color: "darkgray"
    }
}
