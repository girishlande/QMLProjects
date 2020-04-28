import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

Window {
    id:root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")

    property int ballRadius: 60
    property int count: 0
    property int delayCount: 10
    property int inc: 40
    property int snakeIndex: 8
    property var snakes: [8,18,26,39,51,54,56,60,75,83,90,92,97,99];
    property int snakeIt: 0

    function testSnake() {
        console.log("snake index:"+snumber.text)
        root.snakeIndex = parseInt(snumber.text);
        fileReader.readFile(root.snakeIndex);
        root.count=0;
        mtimer.start();
    }

    function testSnakeIndex(index) {
        fileReader.readFile(index);
        root.count=0;
        mtimer.start();
    }

    Board {
        id: board
    }

    Rectangle {
        id: ball
        x:0
        y:0
        width: ballRadius
        height: ballRadius
        radius: ballRadius
        color: "red"
    }


    NumberAnimation {
        id: xmovement
        target: ball
        property: "x"
        duration: root.delayCount
        easing.type: Easing.Linear
    }

    NumberAnimation {
        id: ymovement
        target: ball
        property: "y"
        duration: root.delayCount
        easing.type: Easing.Linear
    }

    Row {
        anchors.right: parent.right
        TextField {
            id: snumber
            onAccepted: {
                testSnake();
            }
        }

        Button {
            text: "Auto Play"
            onClicked: {
                snakeTimer.start();
            }
        }
    }

    Timer {
        id: mtimer
        running: false
        interval: root.delayCount
        repeat: true
        onTriggered: {
            if (count<fileReader.getPoints()) {

                xmovement.from = ball.x
                xmovement.to = fileReader.getX(count++) - ball.width/2;
                ymovement.from = ball.y
                ymovement.to = fileReader.getY(count++) - ball.height/2;
                count+=root.inc;
                xmovement.start();
                ymovement.start();
            } else {
                mtimer.stop();
            }
        }
    }

    Timer {
        id: snakeTimer
        running: false
        interval: 1500
        repeat: true
        onTriggered: {
            if (snakeIt<snakes.length) {
                testSnakeIndex(snakes[snakeIt++]);

            } else {
                snakeTimer.stop();
            }
        }
    }

}
