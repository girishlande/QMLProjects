import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4


Item {
    id: loginPrompt
    anchors.centerIn: parent
    width: 400
    height: 200

    Rectangle {
        anchors.fill: parent
        color: "steelblue"
        border.width: 2
        border.color: "black"
        radius: 10

        Column {

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            Row {
                spacing: 10
                width: parent.width
                height: 50

                Text {
                    id: name
                    text: qsTr("Enter name:")
                    width: 170
                    height:40
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    width: parent.width/2-10
                    radius: 5
                    height: 40
                    color: userName.focus ? "orange" : "white"
                    TextInput {
                        id: userName
                        focus: true
                        activeFocusOnTab: true
                        font.pointSize: 16
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            Row {
                spacing: 10
                width: parent.width
                height: 50
                Text {
                    text: qsTr("Enter Password:")
                    width: 170
                    height: 40
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    width: parent.width/2-10
                    radius: 5
                    height: 40
                    color: userPass.focus ? "orange" : "white"
                    TextInput {
                        id: userPass
                        echoMode: TextInput.Password
                        font.pointSize: 16
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        activeFocusOnTab: true
                    }
                }
            }

            Row {
                width: parent.width
                leftPadding: 100
                topPadding: 20
                Button {
                    id: btn
                    text: "Submit"

                    activeFocusOnTab: true
                    width: 100
                    height: 40
                    onFocusChanged: {
                        if (focus) {
                            console.log("Got focus")
                            btnBack.border.width = 3
                            btnBack.color = "orange";
                        } else {
                            console.log("Lost focus")
                            btnBack.border.width = 1
                            btnBack.color = "white"
                        }
                    }

                    Keys.enabled: true

                    Keys.onReturnPressed: {
                        if (popup.opened) {
                            popup.close();
                            return;
                        }

                        console.log("Clicked")
                        if (userName.text === "girish" && userPass.text === "girish") {
                            console.log("User Login SUCCESS!!")
                            popup.flag = true;
                         } else {
                            console.log("Login Failed!!")
                            popup.flag = false;
                        }
                        popup.open();
                    }

                    background: Rectangle {
                        id: btnBack
                        color: "white"
                        border.width: 1
                        border.color: "blue"
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: btn.scale = 1.1
                            onExited: btn.scale = 1.0
                            onPressed: btn.scale = 1.0
                            onReleased: btn.scale = 1.1
                            onClicked: {
                                console.log("Clicked")
                                if (userName.text === "girish" && userPass.text === "girish") {
                                    console.log("User Login SUCCESS!!")
                                    popup.flag = true;
                                 } else {
                                    console.log("Login Failed!!")
                                    popup.flag = false;
                                }
                                popup.open();
                            }

                        }
                    }

                }
            }
        }
    }

}
