import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "modules"
import "components"

Item {
    id: clients
    anchors.fill: parent

    SystemPalette {id: sysPalette; colorGroup: SystemPalette.Active }

    property int comboBoxSize: 102

    Row {
        anchors.fill: parent

        Item {
            id: clientsLeft
            width: parent.width * vertResizer.portion
            height: parent.height

            RowLayout {
                id: search
                anchors {
                    left: parent.left
                    right: parent.right
                }
                spacing: 0

                Button {
                    id: searchButton
                    text: qsTr("Поиск")

                    checkable: true
                    onClicked: if (checked) {
                                   searchRow.visible = true;
                                   salesColumn.anchors.top = searchRow.bottom
                               }
                               else {
                                   searchRow.visible = false;
                                   salesColumn.anchors.top = search.bottom
                               }
                    //checked ? searchRow.height = 0 : searchRow.visible = false;
                }

                RowLayout {
                    id: addProductButtonsRow
                    anchors.right: parent.right


                    Button {
                        id: addProductButton
                        iconSource: "qrc:/images/add_48x48.png"
                        text: qsTr("Добавить товар")
                    }

                    Button {
                        id: addSubProductButton
                        iconSource: "qrc:/images/add_48x48.png"
                        text: qsTr("Добавить подпродукт")
                    }
                }
            }

            RowLayout {
                id: searchRow
                visible: false
                anchors {
                    top: search.bottom
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
                            DatePicker { topParent: clients }
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
                                DatePicker { topParent: clients }
                            }
                        }
                    }
                }
            }

            Item {
                id: salesColumn
                anchors {
                    left: parent.left
                    top: search.bottom
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

                        ListModel {
                            id: libraryModel

                            ListElement {
                                title: "C"
                                author: "Gabriel s"
                                Copy: "Gabriel dsdds s"

                            }
                            ListElement {
                                title: "A"
                                author: "Jens"
                                Copy: "Second copy"
                            }
                            ListElement {
                                title: "B"
                                author: "ArederikkArederikkArederikkArederikkArederikk"
                                Copy: "Third copy"
                            }
                        }

                        TableView {
                            id: clientsTable
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

                            TableViewColumn {
                                role: "author"
                                title: "Author"
                                width: 200
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

        Item {
            id: clientsRight
            height: parent.height
            width: parent.width * (1 - vertResizer.portion) - vertResizer.width

            ScrollView {
                anchors{
                    fill: parent
                    rightMargin: -5
                }
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                ColumnLayout {
                    id: clientsInfoColumn
                    width: clientsRight.width - 12
                    height: children.height

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

                                Field {
                                    title: qsTr("Имя")

                                    anchors {
                                        left: parent.left
                                        right: parent.right
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

                                Field {
                                    title: qsTr("Фамилия")

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

                                Field {
                                    title: qsTr("Отчество")

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

                                //imageSrc: "file:/home/polaris/dev/Salko/clients/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
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

                        GridLayout {
                            id: addMainAttrFlow
                            anchors.fill: parent
                            columns: 2

                            Field {
                                title: qsTr("День Рожд.")
                                Layout.fillWidth: true
                                DatePicker { topParent: clients;Layout.fillWidth: true }
                            }

                            Row {
                                Field {
                                    title: qsTr("Вес")
                                    SpinBox {
                                        maximumValue: 99
                                    }
                                }

                                Field {
                                    title: qsTr("Рост")
                                    SpinBox {
                                        maximumValue: 99
                                    }
                                }
                            }

                            Field {
                                Layout.fillWidth: true
                                title: qsTr("Город")
                                TextField {Layout.fillWidth: true }
                            }

                            Field {
                                title: qsTr("Категория")
                                ComboBox {
                                    implicitWidth: comboBoxSize
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

                            Field {
                                title: qsTr("Телефон ")
                                TextField {
                                    Layout.fillWidth: true
                                }
                            }

                            Field {
                                title: qsTr("Телефон ")
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

                            Field {
                                title: qsTr("E-Mail")
                                TextField {
                                    Layout.fillWidth: true
                                }
                            }

                            Field {
                                title: qsTr("E-Mail")
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

                    Field {
                        Layout.fillWidth: true
                        title: qsTr("Клубная карта")

                        Button {
                            text: qsTr("Управление картами")
                            Layout.fillWidth: true
                        }

                    }

                    Field {
                        id: addNoteColumn
                        Layout.fillWidth: true
                        anchors.bottom: addSaveButtonsRow.top
                        title: qsTr("Заметка")

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
    }
}
