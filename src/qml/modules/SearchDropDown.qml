import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick 2.5
//import "../plugins"

RowLayout {
    id: searchRow
    visible: false
    anchors {
        top: searchButton.bottom
        left: parent.left
        right: parent.right
        rightMargin: 5
    }
    property var first: firstBox
    property Item topParent: Item{ }
    property Item firstBoxContent: Item {}
    property Item secondBoxContent: Item {}

    GroupBox {
        id: firstBox
        title: qsTr("Главные атрибуты")
        anchors {
            top: parent.top
            left: parent.left
            right: parent.horizontalCenter
            rightMargin: 5
        }
        Component.onCompleted: {
            //searchRow.firstBoxContent.parent = this
        }
    }

    GroupBox {
        id: secondBox
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
                //width: searchMain.width
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
                    DatePicker { topParent: searchRow.topParent }
                }
            }
        }
    }
}
