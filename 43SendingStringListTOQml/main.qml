import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import student 1.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Student {
        id: student

    }

    Column {
        spacing: 10
        ListView {
            spacing: 10
            width: 200
            height: 200
            model: student.slist
            delegate: Rectangle {
                width: parent.width
                height: 50
                color: "pink"
                Text {
                    text: model.modelData
                    anchors.centerIn: parent
                }
            }
        }

        ComboBox {
            id: mycombo
            property int activeIndex: 0
            width: 200
            height: 50
            model: student.slist
            onCurrentIndexChanged: {

                if (currentIndex==activeIndex)
                    return;
                console.log("Girish:" + student.slist + " size:" + student.slistSize())
                console.log(model[mycombo.currentIndex])

                if (currentIndex !== (student.slist.count-1))
                    activeIndex = currentIndex;
                else
                    currentIndex = activeIndex;
            }
        }

        Text {
            id: name
            width: 200
            height: 50
            text: student.slist[mycombo.currentIndex]
        }

        Button {
            text:"Add string in list"
            onClicked: {
                student.addStringInList();
                mycombo.model = student.slist
                console.log("Girish model size:" + student.slist.count())
            }
        }
    }

}
