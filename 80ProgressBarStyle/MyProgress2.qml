import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ProgressBar {
    id: p1

    property var primaryColor: "orange"
    property var secondaryColor: "darkgray"

    maximumValue: 1
    minimumValue: 0
    width: parent.width
    height: 50
    style: ProgressStyle1{
        id: progressstyle
        primaryColor: p1.primaryColor
        secondaryColor: p1.secondaryColor
    }
}
