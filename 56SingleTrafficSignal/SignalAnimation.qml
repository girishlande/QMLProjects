import QtQuick 2.0

ParallelAnimation {
    SequentialAnimation {

        NumberAnimation {
            target: trafficsignal
            property: "opacity"
            duration: 1000
            from: 1
            to: 0.5
            easing.type: Easing.Linear
        }
        NumberAnimation {
            target: trafficsignal
            property: "opacity"
            duration: 1000
            from: 0.5
            to: 1
            easing.type: Easing.Linear
        }
    }

    ColorAnimation {
        duration: 2000
    }
}
