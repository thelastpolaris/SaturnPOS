import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("Файл")
            MenuItem {
                text: qsTr("&Открыть")
                onTriggered: console.log("Открыть экшн");
            }
            MenuItem {
                text: qsTr("Выход")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("Помощь")
            MenuItem {
                text: qsTr("О программе")
                onTriggered: {
                    var component = Qt.createComponent("about.qml")
                    var win = component.createObject(window)
                    win.show()
                }
            }
        }
    }

    signal handlerLoader(string pageName)

    Loader {
        id: pageLoader
        anchors{
            fill: parent
            margins: 5
        }
        source: "mainButtons.qml"
    }

    Connections {
        target: window
        onHandlerLoader: {
            pageLoader.source = pageName
        }
    }

}
