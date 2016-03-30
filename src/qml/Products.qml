import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"
import "components"
import "components/tablenested"
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

            Flow {
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
                        //right: parent.right
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
            }

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

                        tableModel: SaturnPOS.productsModel
                        roles: [ {"r":"photo"}, {"r":"name"}, {"r":"price"},
                        {"r":"categories"},  {"r":"arrival"},
                        {"r":"discount"}, {"r":"amount"},]
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

                    Field {
                        title: qsTr("Цена ")
                        TextField { }
                    }

                    Field {
                        title: qsTr("Тип товара")
                        ComboBox {
                            id: typeAddComboBox
                            implicitWidth: comboBoxSize
                        }
                    }

                    Field {
                        title: qsTr("Баркод ")
                        TextField { }
                    }

                    Field {
                        title: qsTr("Дата поступл.")
                        DatePicker { topParent: products }
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
                    anchors{
                        fill: parent
                        rightMargin: -8
                    }
                    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                    Flow {
                        id: addCustomFlow
                        width: addCustom.width

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
                            DatePicker { topParent: products }
                        }
                    }
                }
            }

            Field {
                title: qsTr("Заметка")
                id: addNoteColumn

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
