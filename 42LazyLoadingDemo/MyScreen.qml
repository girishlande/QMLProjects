import QtQuick 2.0
import QtQuick.Layouts 1.12

Item {

    RowLayout {
        Drinks {
            id: drinks
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Fruits {
            id: fruits
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Vegetables {
            id: veggy
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
