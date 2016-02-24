import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"

Item {
    id: clients
    anchors{
        fill: parent
    }

    property int comboBoxSize: 102

    ColumnLayout {
        id: clientsColumn
        width: parent.width * 0.7  - 15
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }

        Text {
            text: qsTr("Клиенты")
            renderType: Text.NativeRendering
        }

        TableView {
            id: clientsTable
            model: libraryModel
            Layout.fillHeight: true
            anchors {
                left: parent.left
                right: parent.right
            }

            TableViewColumn {
                role: "title"
                title: "Title"
                width: 100
            }
            TableViewColumn {
                role: "author"
                title: "Author"
                width: 200
            }
        }

        Text {
            text: qsTr("История покупок")
            renderType: Text.NativeRendering
        }

        TableView {
            id: salesHistoryTable
            model: libraryModel
            implicitHeight: parent.height * 0.3
            anchors {
                left: parent.left
                right: parent.right
            }

            TableViewColumn {
                role: "title"
                title: "Title"
                width: 100
            }
            TableViewColumn {
                role: "author"
                title: "Author"
                width: 200
            }
        }
    }

    ScrollView {
        anchors {
            left: clientsColumn.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: 5
        }
        width: clients.width * 0.3 + 15
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        ColumnLayout {
            id: clientsInfoColumn
            width: clients.width * 0.3 - 5

            GroupBox {
                id: addAboutGroupBox
                title: qsTr("Добавить/Изменить клиента")
                anchors {
                    left: parent.left
                    right: parent.right
                }

                RowLayout {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    ColumnLayout {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }

                        ColumnLayout {
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                            Label {
                                text: qsTr("Имя")
                            }
                            TextField {
                                Layout.fillWidth: true
                                id: clientName
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }
                            }
                        }

                        ColumnLayout {
                            Label {
                                text: qsTr("Фамилия")
                            }
                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            TextField {
                                Layout.fillWidth: true
                                id: clientSurname
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }
                            }
                        }

                        ColumnLayout {
                            Label {
                                text: qsTr("Отчество")
                            }
                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            TextField {
                                Layout.fillWidth: true
                                id: fathersNameClient
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }
                            }
                        }
                    }

                    ImageDialog {
                        Layout.preferredHeight: parent.height * 0.6
                        Layout.preferredWidth: parent.height * 0.6
                        imageWidth: Layout.preferredWidth
                        imageHeight: Layout.preferredHeight

                        //imageSrc: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    }
                }
            }

            GroupBox {
                id: addMainAttrGroupBox
                title: qsTr("О клиенте")
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Flow {
                    id: addMainAttrFlow
                    anchors.fill: parent
                    spacing: 10

                    Column {
                        Label {
                            text: qsTr("День Рожд.")
                        }

                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Город")
                        }
                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Вес")
                        }
                        SpinBox {
                            maximumValue: 99
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Рост")
                        }
                        SpinBox {
                            maximumValue: 99
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Категория")
                        }
                        ComboBox {
                            width: comboBoxSize
                        }
                    }
                }
            }

            GroupBox {
                id: infoBox
                title: qsTr("Контактная информация")
                implicitWidth: parent.width

                ColumnLayout {
                    id: telephonesFlow
                    spacing: 5

                    anchors {
                        left: parent.left
                        right: parent.horizontalCenter
                    }

                    ColumnLayout {
                        id: telephoneCol
                        Label {
                            text: qsTr("Телефон ")
                        }
                        TextField {
                            Layout.fillWidth: true
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Label {
                            text: qsTr("Телефон ")
                        }
                        TextField {
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        id: addTelButton
                        implicitWidth: parent.width
                        onWidthChanged: {
                            if(implicitWidth < 135) {
                                text = qsTr("Добавить тел.")
                            }
                            else {
                                text = qsTr("Добавить телефон")
                            }
                        }
                    }
                }

                ColumnLayout {
                    id: emailsFlow
                    spacing: 5

                    anchors {
                        left: parent.horizontalCenter
                        right: parent.right
                        rightMargin: 5
                        leftMargin: 5
                    }

                    ColumnLayout {
                        Label {
                            text: qsTr("E-Mail")
                        }
                        TextField {
                            Layout.fillWidth: true
                        }
                    }

                    ColumnLayout {
                        Label {
                            text: qsTr("E-Mail")
                        }
                        TextField {
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        id: addEmailButton
                        implicitWidth: parent.width
                        onWidthChanged: {
                            if(implicitWidth < 120) {
                                text = qsTr("Добав. E-Mail")
                            }
                            else {
                                text = qsTr("Добавить E-Mail")
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                id:clientsChoice

                Label {
                    text: qsTr("Вкусовые предпочтения")
                }

                TextField {
                    Layout.fillWidth: true
                }
            }
            /*GroupBox {
            title: qsTr("История клиента")
            anchors {
                left: parent.left
                right: parent.right
            }

            Flow {
                anchors.fill: parent
                spacing: 10

                /*Column {
                    spacing: 5
                    Label {
                        text: qsTr("Дата регистр.")
                    }
                    Rectangle {
                        color: "#FDFDFD"
                        border.width: 1
                        border.color: "#999"
                        radius: 3
                        width: childrenRect.width + 20
                        height: childrenRect.height + 5
                        Label {
                            anchors.centerIn: parent
                            text: qsTr("27.12.1993")
                        }
                    }
                }*/



            /*Column {
                    spacing: 5
                    Label {
                        text: qsTr("Покупки")
                    }
                    Rectangle {
                        color: "#FDFDFD"
                        border.width: 1
                        border.color: "#999"
                        radius: 3
                        width: childrenRect.width + 5
                        height: childrenRect.height + 5
                        Label {
                            anchors.centerIn: parent
                            text: qsTr("27")
                        }
                    }
                }


            }
        }*/

            ColumnLayout {
                Layout.fillWidth: true
                Label {
                    text: qsTr("Клубная карта")
                }

                Button {
                    text: qsTr("Управление картами")
                    Layout.fillWidth: true
                }

            }

            ColumnLayout {
                id: addNoteColumn
                Layout.fillWidth: true
                anchors.bottom: addSaveButtonsRow.top

                Label {
                    text: qsTr("Заметка")
                }

                TextArea {
                    id: addNoteTextArea
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: 85
                }
            }

            /*Item {
                id: addStretch
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Layout.preferredHeight: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
            }*/

            RowLayout {
                id: addSaveButtonsRow
                anchors {
                    left: parent.left
                    right: parent.right
                    //bottom: parent.bottom
                }

                Layout.fillWidth: true

                Button {
                    id: saveButton
                    Layout.preferredHeight: 32
                    iconSource: "qrc:/images/images/save_48x48.png"
                    text: qsTr("Сохранить")
                }

                Button {
                    id: cancelButton
                    Layout.preferredHeight: 32
                    iconSource: "qrc:/images/images/save_48x48.png"
                    anchors.right: parent.right
                    text: qsTr("Отмена")
                }
            }
        }
    }

}
