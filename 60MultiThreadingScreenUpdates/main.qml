import QtQuick 2.12
import QtQuick.Window 2.12
import classroom 1.0

Window {
    visible: true
    width: 1000
    height: 500
    title: qsTr("Demo of Student Sender and Receiver")

    StudentModel {
        id: studentmodel
    }

    ClassRoomModel {
        id: classroommodel
    }

    ClassRoomsView {
        model: myclassrooms
        onActivateClass: {
            console.log("Selected class:"+index);
            myclassrooms.startAddingStudents(index);
            studentview.model = myclassrooms.getModel(index);
        }
    }

    CurrentStudentView {
        id: studentview
    }

}
