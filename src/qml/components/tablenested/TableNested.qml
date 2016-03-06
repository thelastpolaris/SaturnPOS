import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

RowLayout {
    property ListModel tableModel
    property Component delegate
    property bool changedHeight: false
    spacing: 0

    signal cellHeightChanged(var newHeight, var elemIndex)
    signal selectedChanged(var elemIndex)
    signal updateModel()

    //property Component headerDelegate:
}

/*TableView {
    model: 50

    SystemPalette {id: sysPalette; colorGroup: SystemPalette.Active }

    TableViewColumn {
        role: "title"
        title: qsTr("Название")

        delegate: Item {
            Component.onCompleted: {
                if (model.author) {
                    arrow.visible = true
                }
            }

            Image {
                id: arrow

                visible: true
                width: 18
                height: 18
                source: "qrc:/images/components/arrow_48x48.png"
            }

            Text {
                anchors {
                    left: arrow.right
                    leftMargin: 5
                }
                text: styleData.value
                color: sysPalette.windowText
                wrapMode: Text.WrapAnywhere
            }
        }
    }

    TableViewColumn {
        role: "author"
        title: "Author"
        width: 200
    }
}*/


