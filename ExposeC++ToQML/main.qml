import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.5

import Greeter 1.0

Window {
    visible: true
    width: Screen.width / 2
    height: Screen.height / 2
    GreeterComponent {
        id: myGreeter

// React on signal/event
        onGreetingsChanged: {
// Getter
            textGreetingsOut.text = myGreeter.greetings;
        }
    }

    Text {
        id: textGreetingsOut
// Getter
        text: myGreeter.greetings
        font.pointSize: 16
        anchors.verticalCenterOffset: 70
        anchors.horizontalCenterOffset: -16 //myGreeter.greetings
        anchors.centerIn: parent
    }

    Button {
        id: buttonGreet
        x: 359
        y: 206

        onClicked: {
// Setter
// (this will emit the onGreetingsChanged event)
            myGreeter.greetings = fieldGreetingsInputText.text;
        }

        text: qsTr("Greet")
    }

    Button {
        id: resetGreetings
        x: 469
        y: 206
        text: qsTr("Reset greeting")
        onClicked: {
// Invoke Method
            myGreeter.resetToDefaultGreeting();
            fieldGreetingsInputText.text = "" //fieldGreetingsInputText.enter_a_phrase;
        }
    }

    TextField {
        property string enter_a_phrase: "Please enter a greeting phrase"

        id: fieldGreetingsInputText
        x: 359
        y: 279
        width: 203
        height: 20
        text: "";
        placeholderText: enter_a_phrase
    }
}
