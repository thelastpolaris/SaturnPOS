import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"
import "plugins"
import "plugins/tablenested"
import com.saturnpos 1.0

Item {
    id: products
    anchors.fill: parent

    Component.onCompleted: {

    }

    property int comboBoxSize: 102

    ListModel {
        id: libraryModel

        ListElement {
            images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
            author: "hak_s_bantom_i_uzorom_pered.png"
            Copy: "C"
            subproduct: [
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C"},
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C"}
            ]

        }
        ListElement {
            images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
            author: "B"
            Copy: "B"
            subproduct: [
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C" },
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C"}
            ]
        }
        ListElement {
            images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
            author: "C"
            Copy: "A"
            subproduct: [
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C"},
                ListElement { images: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                    author: "A"
                    Copy: "C"}
            ]
        }
    }

    Row {
        anchors.fill: parent

        Item {
            id: productsLeft
            width: parent.width * vertResizer.portion
            height: parent.height

            RowLayout {
                id: searchButton
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Button {

                    text: qsTr("Поиск")
                    checkable: true

                    onClicked: if (checked) {
                                   searchRow.visible = true;
                                   productsTableWrapper.anchors.top = searchRow.bottom
                               }
                               else {
                                   searchRow.visible = false;
                                   productsTableWrapper.anchors.top = searchButton.bottom
                               }
                    //checked ? searchRow.height = 0 : searchRow.visible = false;
                }

                RowLayout {
                    anchors {
                        right: parent.right
                        //margins: 10
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
            }

            /*RowLayout {
                id: searchRow
                visible: false
                anchors {
                    top: searchButton.bottom
                    left: parent.left
                    right: parent.right
                    rightMargin: 5
                }
                //height: searchMain.height

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
                            DatePicker { topParent: products }
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
                                DatePicker { topParent: products }
                            }
                        }
                    }
                }
            }*/

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
                    id: searchProdAttr
                    title: qsTr("Параметры продукта")
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.horizontalCenter
                        rightMargin: 5
                    }

                    Flow {
                        anchors.fill: parent
                        spacing: 10

                        Field {
                            title: qsTr("Название")
                            TextField {
                                id: sName
                            }
                        }

                        Field {
                            title: qsTr("Цена")
                            TextField {
                                id: sPrice
                            }
                        }

                        Field {
                            title: qsTr("Категория")
                            ComboBox {
                                id: sCategory
                                implicitWidth: comboBoxSize
                                textRole: "value"
                                model: SaturnPOS.products.categories
                            }
                        }

                        Field {
                            title: qsTr("Цвет")
                            ComboBox {
                                id: sColor
                                implicitWidth: comboBoxSize
                                textRole: "value"
                                model: SaturnPOS.products.colors
                            }
                        }

                        Field {
                            title: qsTr("Скидка")
                            TextField {
                                id: sDiscount
                            }
                        }

                        Field {
                            title: qsTr("Дата поступления")
                            DatePicker {
                                id: sArrivalDate
                                topParent: products
                            }
                        }
                    }
                }

                GroupBox {
                    id: searcheSubAttr
                    title: qsTr("Параметры подпродуктов")
                    anchors {
                        top: parent.top
                        left: parent.horizontalCenter
                        right: parent.right
                        bottom: parent.bottom
                        leftMargin: 5
                        rightMargin: 5
                    }

                    Flow {
                        id: searchAttributesFlow
                        anchors.fill: parent
                        spacing: 10

                        Field {
                            title: qsTr("Размер")
                            ComboBox {
                                id: sSize
                                implicitWidth: comboBoxSize
                                textRole: "value"
                                model: SaturnPOS.products.sizes
                            }
                        }

                        Field {
                            title: qsTr("Залог")
                            TextField {
                                id: sPrepayment
                            }
                        }

                        Field {
                            title: qsTr("Кол-во")
                            TextField {
                                id: sAmount
                            }
                        }

                        Field {
                            title: qsTr("Штрихкод")
                            TextField {
                                id: sBarcode
                            }
                        }
                    }
                }
            }

            /*Button {
                width: 50
                height: 50
                text: "TEST!"
                onClicked: {
                    productsTable.visible = productsTable.visible ? false : true
                }
            }*/

            Item {
                id: productsTableWrapper
                anchors {
                    left: parent.left
                    top: searchButton.bottom
                    topMargin: 5
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 5
                }


                ScrollView {
                    anchors.fill: parent


                    TableNested {
                        id: productsTable
                        width: childrenRect.width
                        height: childrenRect.height

                        tableModel: SaturnPOS.products.productsModel

                        roles: [
                            {"role":"photo", "title":"Фото"},
                            {"role":"name", "title":"Название"},
                            {"role":"price", "title":"Цена"},
                            {"role":"category_name", "title":"Категория"},
                            {"role":"color_name", "title":"Цвет"},
                            {"role":"arrival", "title":"Дата поступления"},
                            {"role":"discount", "title":"Скидка"}]//,
                        // {"role":"amount", "title":"Количество"}]
                        childTableRoles: [
                            {"role":"size", "title":"Размер"},
                            {"role":"reserved", "title":"Залог"},
                            {"role":"amount", "title":"Кол-во"},
                            {"role":"note", "title":"Заметка"},
                            {"role":"barcode", "title":"Штрихкод"}
                        ]
                        //subProductRoles
                        /*roles: [ "photo", "name", "price",
                              "arrival",
                            "discount", "amount"]*/
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
            id: addProductColumn
            width: parent.width * (1 - vertResizer.portion) - vertResizer.width
            height: parent.height

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

                        Layout.fillWidth: true

                        Field {
                            title: qsTr("Наименование")
                            TextField {
                                Layout.fillWidth: true
                                id: nameAddText
                            }
                        }

                        Field {
                            title: qsTr("Категория")
                            ComboBox {
                                Layout.fillWidth: true
                                id: categoryAddComboBox
                                textRole: "value"
                                model: SaturnPOS.products.categories
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
                id: addProdAttr
                title: qsTr("Параметры продукта")
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Flow {
                    anchors.fill: parent
                    spacing: 10

                    Field {
                        title: qsTr("Название")
                        TextField {
                            id: aName
                        }
                    }

                    Field {
                        title: qsTr("Цена")
                        TextField {
                            id: aPrice
                        }
                    }

                    Field {
                        title: qsTr("Цвет")
                        ComboBox {
                            id: aColor
                            implicitWidth: comboBoxSize
                            textRole: "value"
                            model: SaturnPOS.products.colors
                        }
                    }

                    Field {
                        title: qsTr("Скидка")
                        TextField {
                            id: aDiscount
                        }
                    }

                    Field {
                        title: qsTr("Общее кол-во")
                        TextField {
                            id: aAllAmount
                            readOnly: true
                        }
                    }

                    Field {
                        title: qsTr("Дата поступления")
                        DatePicker {
                            id: aArrivalDate
                            topParent: products
                        }
                    }
                }
            }

            GroupBox {
                id: addCustom
                title: qsTr("Параметры подпродукта")

                anchors {
                    left: parent.left
                    right: parent.right
                }

                /*ScrollView {
                    id: addCustomScroll
                    anchors{
                        fill: parent
                        rightMargin: -8
                    }
                    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff*/

                Flow {
                    id: addSubAttr
                    anchors.fill: parent
                    spacing: 10

                    Field {
                        title: qsTr("Размер")
                        ComboBox {
                            id: aSize
                            implicitWidth: comboBoxSize
                            textRole: "value"
                            model: SaturnPOS.products.sizes
                        }
                    }

                    Field {
                        title: qsTr("Залог")
                        TextField {
                            id: aPrepayment
                        }
                    }

                    Field {
                        title: qsTr("Кол-во")
                        TextField {
                            id: aAmount
                        }
                    }

                    Field {
                        title: qsTr("Штрихкод")
                        TextField {
                            id: aBarcode
                        }
                    }
                }
                // }
            }

            Field {
                title: qsTr("Заметка")
                id: aNote

                anchors {
                    left: parent.left
                    right: parent.right
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
