import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    id: listButtons
    visible: true
    Row {
        spacing: 10
        Button {
            width: 150
            height: 150
            text: qsTr("Товары")
            onClicked: {
                handlerLoader("Products.qml")
            }
        }
        Button {
            width: 150
            height: 150
            text: qsTr("Клиенты")
            onClicked: {
                handlerLoader("Clients.qml")
            }
        }
        Button {
            width: 150
            height: 150
            text: qsTr("Продажи")
            onClicked: {
                handlerLoader("Sales.qml")
            }
        }
    }
}

