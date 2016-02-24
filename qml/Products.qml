import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"

Item {
    id: products
    anchors{
        fill: parent
    }

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

    Item {
        id: prod
        width: parent.width * 0.7
        height: parent.height
        //Layout.fillWidth: true
        //Layout.fillHeight: true

        Button {
            id: searchButton
            text: qsTr("Поиск")
            checkable: true
            anchors {
                left: parent.left
                top: parent.top
                //margins: 10
            }
            onClicked: if (checked) {
                           searchRow.visible = true;
                           productsTable.anchors.top = searchRow.bottom
                       }
                       else {
                           searchRow.visible = false;
                           productsTable.anchors.top = searchButton.bottom
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

                iconSource: "/images/images/add_48x48.png"
                text: qsTr("Добавить товар")
            }

            Button {
                id: addSubProductButton
                //Layout.preferredHeight: 32
                //Layout.preferredWidth: 32

                iconSource: "/images/images/add_48x48.png"
                text: qsTr("Добавить подпродукт")
            }
        }

        RowLayout {
            id: searchRow
            width: parent.width * 0.3
            visible: false
            anchors {
                top: searchButton.bottom
                left: parent.left
                right: parent.right
                rightMargin: 5
            }
            height: searchGroupBox.height

            GroupBox {
                id: searchGroupBox
                title: qsTr("Главные атрибуты")
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.horizontalCenter
                    //leftMargin: 10
                    rightMargin: 5
                }

                Flow {
                    id: searchFlow
                    anchors.fill: parent
                    spacing: 10

                    Column {
                        Label {
                            text: qsTr("Наименование")
                        }
                        TextField {
                            id: nameSearch
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Цена")
                        }
                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Категория")
                        }
                        ComboBox {
                            id: categorySearchComboBox
                            width: comboBoxSize
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Тип товара")
                        }
                        ComboBox {
                            id: typeSearchComboBox
                            width: comboBoxSize
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Баркод")
                        }
                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Дата поступл.")
                        }
                        DatePicker { topParent: products }
                    }
                }
            }

            GroupBox {
                id: attributeSearchGroupBox
                title: qsTr("Пользовательские атрибуты")
                anchors {
                    top: parent.top
                    left: parent.horizontalCenter
                    right: parent.right
                    bottom: searchGroupBox.bottom
                    leftMargin: 5
                    rightMargin: 5
                }

                ScrollView {
                    anchors.fill: parent
                    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                    Flow {
                        id: searchAttributesFlow
                        spacing: 10
                        width: searchGroupBox.width

                        Column {
                            Label {
                                text: qsTr("Размер")
                            }
                            TextField {
                                id: test1
                            }
                        }

                        Column {
                            Label {
                                text: qsTr("Размер")
                            }
                            TextField {
                                id: test13
                            }
                        }

                        Column {
                            Label {
                                text: qsTr("Цвет")
                            }
                            TextField { }
                        }

                        Column {
                            Label {
                                text: qsTr("Материал")
                            }
                            ComboBox {
                                id: test1SearchComboBox
                                width: comboBoxSize
                            }
                        }

                        Column {
                            Label {
                                text: qsTr("Тип товара")
                            }
                            ComboBox {
                                id: test2SearchComboBox
                                width: comboBoxSize
                            }
                        }

                        Column {
                            Label {
                                text: qsTr("Баркод")
                            }
                            TextField { }
                        }

                        Column {
                            Label {
                                text: qsTr("Дата поступл.")
                            }
                            TextField { }
                        }

                        Column {
                            Label {
                                text: qsTr("Дата поступл.")
                            }
                            DatePicker { topParent: products }
                        }
                    }
                }
            }
        }

        TableView {
            id: productsTable
            model: libraryModel
            anchors {
                left: parent.left
                top: searchButton.bottom
                right: parent.right
                bottom: parent.bottom
                rightMargin: 10
                topMargin: 5
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

    ColumnLayout {
        id: addProductColumn
        width: parent.width * 0.3
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        GroupBox {
            id: addAboutGroupBox
            title: qsTr("Добавить/Изменить товар")
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
                            text: qsTr("Наименование")
                        }
                        TextField {
                            Layout.fillWidth: true
                            id: nameAddText
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                        }
                    }

                    ColumnLayout {
                        Label {
                            text: qsTr("Категория")
                        }
                        anchors {
                            left: parent.left
                            right: parent.right
                        }

                        ComboBox {
                            Layout.fillWidth: true
                            id: categoryAddComboBox
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                        }
                    }
                }

                ImageDialog {
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.height

                    imageSrc: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                }
            }
        }

        GroupBox {
            id: addMainAttrGroupBox
            title: qsTr("Параметры")
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
                        text: qsTr("Цена")
                    }

                    TextField { }
                }



                Column {
                    Label {
                        text: qsTr("Тип товара")
                    }
                    ComboBox {
                        id: typeAddComboBox
                        width: comboBoxSize
                    }
                }

                Column {
                    Label {
                        text: qsTr("Баркод")
                    }
                    TextField { }
                }

                Column {
                    z: 10
                    Label {
                        text: qsTr("Дата поступл.")
                    }
                    DatePicker { topParent: products }
                }
            }
        }

        GroupBox {
            z: 1
            id: addAttributesGroupBox
            title: qsTr("Пользовательские атрибуты")
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors {
                left: parent.left
                right: parent.right
                bottom: addNoteColumn.top
            }
            ScrollView {
                anchors {
                    left: parent.left
                    //right: parent.right
                }

                width: addMainAttrGroupBox.width - 10
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                Flow {
                    id: addAttributesFlow
                    width: addMainAttrGroupBox.width
                    //anchors.fill: parent
                    spacing: 5

                    Column {
                        Label {
                            text: qsTr("Размер")
                        }
                        TextField {
                            id: addTest1
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Размер")
                        }
                        TextField {
                            id: addTest11
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Цвет")
                        }

                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Материал")
                        }

                        ComboBox {
                            id: test1AddComboBox
                            width: comboBoxSize
                        }

                    }

                    Column {
                        Label {
                            text: qsTr("Тип товара")
                        }
                        ComboBox {
                            id: test2AddComboBox
                            width: comboBoxSize
                        }
                    }

                    Column {
                        Label {
                            text: qsTr("Баркод")
                        }
                        TextField { }
                    }

                    Column {
                        Label {
                            text: qsTr("Дата поступл.")
                        }
                        DatePicker { topParent: products }
                    }
                }
            }
        }

        ColumnLayout {
            id: addNoteColumn
            Layout.fillHeight: true
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                text: qsTr("Заметка")
            }

            TextArea {
                id: addNoteTextArea
                Layout.fillHeight: true
                Layout.fillWidth: true
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
                iconSource: "/images/images/save_48x48.png"
                text: qsTr("Сохранить")
            }

            Button {
                id: cancelButton
                Layout.preferredHeight: 32
                iconSource: "/images/images/save_48x48.png"
                anchors.right: parent.right
                text: qsTr("Отмена")
            }
        }
    }

}
