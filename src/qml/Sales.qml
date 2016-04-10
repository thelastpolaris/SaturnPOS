import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"
import "plugins"

Item {
    id: sales
    anchors.fill: parent

    SystemPalette {id: sysPalette; colorGroup: SystemPalette.Active }

    property int comboBoxSize: 102

    ListModel {
        id: libraryModel
        ListElement {
            title: "A Masterpiece"
            author: "Gabriel"
        }
        ListElement {
            title: "Brilliance"
            author: "Jens"
        }
        ListElement {
            title: "Outstanding"
            author: "Frederik"
        }
    }

    Row {
        anchors.fill: parent

        Item {
            id: salesLeft
            width: parent.width * vertResizer.portion
            height: parent.height

            Button {
                id: searchButton
                text: qsTr("Поиск")
                checkable: true
                anchors {
                    left: parent.left
                    top: parent.top
                }
                onClicked: if (checked) {
                               searchRow.visible = true;
                               salesColumn.anchors.top = searchRow.bottom
                           }
                           else {
                               searchRow.visible = false;
                               salesColumn.anchors.top = searchButton.bottom
                           }
                //checked ? searchRow.height = 0 : searchRow.visible = false;
            }

            RowLayout {
                anchors {
                    right: parent.right
                    margins: 10
                }
                Button {
                    id: addProductButton
                    // Layout.preferredHeight: 32
                    //Layout.preferredWidth: 32

                    iconSource: "qrc:/images/add_48x48.png"
                    text: qsTr("Добавить товар")
                }

                Button {
                    id: addSubProductButton
                    //Layout.preferredHeight: 32
                    //Layout.preferredWidth: 32

                    iconSource: "qrc:/images/add_48x48.png"
                    text: qsTr("Добавить подпродукт")
                }
            }

            RowLayout {
                id: searchRow
                visible: false
                anchors {
                    top: searchButton.bottom
                    left: parent.left
                    right: parent.right
                    rightMargin: 5
                }
                height: searchMain.height

                GroupBox {
                    id: searchMain
                    title: qsTr("Главные атрибуты")
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.horizontalCenter
                        rightMargin: 5
                    }

                    Flow {
                        id: searchMainFlow
                        anchors.fill: parent
                        spacing: 10

                        Field {
                            title: qsTr("Наименование")
                            TextField {
                                id: nameSearch
                            }
                        }

                        Field {
                            title: qsTr("Цена")
                            TextField { }
                        }

                        Field {
                            title: qsTr("Категория")
                            ComboBox {
                                id: categorySearchComboBox
                                implicitWidth: comboBoxSize
                            }
                        }

                        Field {
                            title: qsTr("Тип товара")
                            ComboBox {
                                id: typeSearchComboBox
                                implicitWidth: comboBoxSize
                            }
                        }

                        Field {
                            title: qsTr("Баркод")
                            TextField { }
                        }

                        Field {
                            title: qsTr("Дата поступл.")
                            DatePicker { topParent: sales }
                        }
                    }
                }

                GroupBox {
                    id: searchCustom
                    title: qsTr("Пользовательские атрибуты")
                    anchors {
                        top: parent.top
                        left: parent.horizontalCenter
                        right: parent.right
                        bottom: parent.bottom
                        leftMargin: 5
                        rightMargin: 5
                    }

                    ScrollView {
                        anchors{
                            fill: parent
                            rightMargin: -6
                        }
                        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                        Flow {
                            id: searchAttributesFlow
                            width: searchMain.width
                            spacing: 10

                            Field {
                                title: qsTr("Размер")
                                TextField {
                                    id: test1
                                }
                            }

                            Field {
                                title: qsTr("Размер")
                                TextField {
                                    id: test13
                                }
                            }

                            Field {
                                title: qsTr("Цвет")
                                TextField { }
                            }

                            Field {
                                title: qsTr("Материал")
                                ComboBox {
                                    id: test1SearchComboBox
                                    implicitWidth: comboBoxSize
                                }
                            }

                            Field {
                                title: qsTr("Тип товара")
                                ComboBox {
                                    id: test2SearchComboBox
                                    implicitWidth: comboBoxSize
                                }
                            }

                            Field {
                                title: qsTr("Баркод")
                                TextField { }
                            }

                            Field {
                                title: qsTr("Дата поступл.")
                                TextField { }
                            }

                            Field {
                                title: qsTr("Дата поступл.")
                                DatePicker { topParent: sales }
                            }
                        }
                    }
                }
            }

            Item {
                id: salesColumn
                anchors {
                    left: parent.left
                    top: searchButton.bottom
                    topMargin: 5
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 10
                }

                Column {
                    anchors.fill: parent

                    ColumnLayout {
                        width: parent.width
                        height: parent.height * horResizer.portion

                        Text {
                            text: qsTr("Товары")
                            color: sysPalette.windowText
                            renderType: Text.NativeRendering
                        }

                        TableView {
                            id: salesTable
                            model: libraryModel
                            Layout.fillHeight: true
                            Layout.fillWidth: true
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

                    HorizontalResizer {
                        id:horResizer
                        portion: 0.6
                    }

                    ColumnLayout {
                        width: parent.width
                        height: parent.height * (1 - horResizer.portion)

                        Text {
                            text: qsTr("Корзина клиента")
                            color: sysPalette.windowText
                            renderType: Text.NativeRendering
                        }

                        TableView {
                            id: salesHistoryTable
                            model: libraryModel
                            Layout.fillHeight: true
                            Layout.fillWidth: true
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
                }
            }
        }

        VerticalResizer {
            id: vertResizer
            minimumLeft: 422
            minimumRight: 250
        }

        ColumnLayout {
            id: salesRight
            width: parent.width * (1 - vertResizer.portion) - vertResizer.width
            height: parent.height

            GroupBox {
                id: addAboutGroupBox
                title: qsTr("Добавить/выбрать клиента")
                implicitWidth: parent.width

                ColumnLayout {
                    visible: false
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    Button {
                        Layout.fillWidth: true
                        text: qsTr("Найти клиента")
                    }

                    Button {
                        Layout.fillWidth: true
                        text: qsTr("Добавить клиента")
                    }
                }

                RowLayout {
                    width: parent.width

                    ColumnLayout {
                        id: clientInfo
                        Layout.fillHeight: true

                        Text {
                            color: sysPalette.windowText
                            text: "Макс Крупп"
                        }

                        Flow {
                            spacing: 5
                            Layout.fillWidth: true
                            Text {
                                width: parent.width
                                wrapMode:Text.WordWrap
                                color: sysPalette.windowText
                                text: "Клубная карта: 5435 бонусов"
                            }

                            Text {
                                color: sysPalette.windowText
                                text: "Скидка: 5%"
                            }
                        }

                        Button {
                            text: "Подробнее"
                        }
                    }
                    ImageDialog {
                        id: clientImage
                        Layout.preferredHeight: 105
                        Layout.preferredWidth: 105
                        //imageSrc: "file:/home/polaris/dev/Salko/sales/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    }
                }
            }

            Flow {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                spacing: 10

                GroupBox {
                    id: addMainAttrGroupBox
                    title: qsTr("В долг")
                    width: 240 // width of AddAbout GroupBox

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Field {
                            title: qsTr("Сумма ")
                            SpinBox { }
                        }

                        Field {
                            title: qsTr("Дата возврата")
                            DatePicker { topParent: sales;width: 130 }
                        }
                    }
                }
                Field {
                    title:  qsTr("Скидка ")
                    SpinBox { }
                }

                Field {
                    title:  qsTr("Резерв")
                    DatePicker {
                        topParent: sales
                    }
                }
            }

            GroupBox {
                id: addCustom
                title: qsTr("Пользовательские атрибуты")

                anchors {
                    left: parent.left
                    right: parent.right
                }

                ScrollView {
                    id: addCustomScroll

                    anchors.fill: parent
                    anchors.rightMargin: -8
                    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                    Flow {
                        id: addCustomFlow
                        width: addCustom.width
                        height: children.height
                        spacing: 5

                        Field {
                            title: qsTr("Размер")
                            TextField {
                                id: addTest1
                            }
                        }

                        Field {
                            title: qsTr("Размер")
                            TextField {
                                id: addTest11
                            }
                        }

                        Field {
                            title: qsTr("Цвет")
                            TextField { }
                        }

                        Field {
                            title: qsTr("Материал")
                            ComboBox {
                                id: test1AddComboBox
                                implicitWidth: comboBoxSize
                            }
                        }

                        Field {
                            title: qsTr("Тип товара")
                            ComboBox {
                                id: test2AddComboBox
                                implicitWidth: comboBoxSize
                            }
                        }

                        Field {
                            title: qsTr("Баркод")
                            TextField { }
                        }

                        Field {
                            title: qsTr("Дата поступл.")
                            DatePicker { topParent: sales }
                        }
                    }
                }
            }

            Field {
                title: qsTr("Заметка")
                id: addNoteColumn

                anchors {
                    right: parent.right
                    left: parent.left
                }

                TextArea {
                    id: addNoteTextArea
                    Layout.fillHeight: true
                    anchors {
                        right: parent.right
                        left: parent.left
                    }
                }
            }

            /*Item {
            id: addStretch

            Layout.minimumWidth: 60
            Layout.preferredHeight: 150
            Layout.fillWidth: true
            Layout.fillHeight: true
        }*/

            RowLayout {
                id: addSaveButtonsRow
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Layout.fillWidth: true

                Button {
                    id: saveButton
                    Layout.preferredHeight: 32
                    iconSource: "qrc:/images/save_48x48.png"
                    text: qsTr("Сохранить")
                }

                Button {
                    id: cancelButton
                    Layout.preferredHeight: 32
                    iconSource: "qrc:/images/save_48x48.png"
                    anchors.right: parent.right
                    text: qsTr("Отмена")
                }
            }
        }
    }
}
