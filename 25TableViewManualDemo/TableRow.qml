import QtQuick 2.0
import QtQuick.Layouts 1.12

RowLayout {

    anchors.fill: parent
    spacing: 80
    MyCell {
        text: model.title
    }
    MyCell {
        text: model.thickness
    }
    MyCell {
        text: model.increment
    }
    MyCell {
        text: model.plane
    }
    MyCell {
        text: model.type
    }
    MyCell {
        text: model.imgcount
    }
    MyCell {
        text: model.planningvp
    }
    MyCell {
        text: model.arcdes
    }
}
