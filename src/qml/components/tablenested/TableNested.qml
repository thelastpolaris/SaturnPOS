import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    id: nestRootItem
    property ListModel tableModel
    property Component delegate
    property int minColWidth: 150
    property var roles
    property bool nested: false

    //Internal properties
    width: elemView.width

    //Signals
    signal colWidthChanged(int elemIndex, int newWidth)

    SystemPalette {
        id: sysPalette
        colorGroup: SystemPalette.Active
    }

    ListView {
        id: elemView
        model: tableModel
        interactive: false

        currentIndex: -1 // To disable selecting 0 row by default

        //Workaround to bind height to contentHeight and get rid of binding loop warning
        Component.onCompleted: {
            height = Qt.binding(function() { return contentHeight })
            width = Qt.binding(function() {
                var maxWidth = 0
                for(var child in contentItem.children) {
                    maxWidth = Math.max(maxWidth, contentItem.children[child].width)
                }
                return maxWidth
            })
        }

        //Selection sort
        function sortModel(sortModel, sortRole, asc) {
            for(var i = 0; i < sortModel.count; ++i) {
                var index_min = i;

                for(var a = i; a < sortModel.count; ++a) {
                    var a1 = sortModel.get(a)[sortRole].toLowerCase()
                    var a2 = sortModel.get(index_min)[sortRole].toLowerCase()
                    if(asc) {
                        if(a1.localeCompare(a2) < 0) index_min = a
                    }
                    else {
                        if(a1.localeCompare(a2) > 0) index_min = a
                    }
                }

                if(i != index_min) {
                    sortModel.move(i, index_min, 1)
                    sortModel.move(index_min - 1, i, 1)
                }
            }
            sortModel.layoutAboutToBeChanged()
        }

        header: RowLayout {
            spacing: 0
            Repeater {
                id: headerRepeater
                model: roles

                Rectangle {
                    id: header
                    color: "grey"

                    implicitWidth: minColWidth
                    implicitHeight: headerLabel.contentHeight
                    Layout.fillHeight: true

                    Connections {
                        target: nestRootItem
                        onColWidthChanged: {
                            if(index == elemIndex) {
                                implicitWidth = newWidth
                            }
                        }
                    }

                    MouseArea {
                        property bool asc: true
                        anchors {
                            fill: parent
                            //leftMargin: 5
                            //rightMargin: 5
                            //To prevent overlapping of resizer mousearea
                        }

                        ListModel {
                            id:clearModel
                        }

                        onClicked: {
                            elemView.sortModel(tableModel, modelData.r, asc)
                            asc = !asc
                        }
                    }

                    Text {
                        id: headerLabel
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        text: modelData.r
                    }
                }
            }
        }

        delegate: Column {
            id: elemItem
            property color cellColor: "white"
            property color cellTextColor: "black"
            property int parentIndex: index

            width: childrenRect.width
            height: childrenRect.height

            Connections {
                target: elemView
                onCurrentIndexChanged: {
                    if(elemView.currentIndex === index) {
                        state = "selected"
                    }
                    else state = ""
                }
            }

            RowLayout {
                id: elemRow
                spacing: 0

                MouseArea {
                    id: mouseSelect
                    anchors.fill: parent

                    onClicked: {
                        elemView.currentIndex = index
                    }
                }

                Repeater {
                    model: roles
                    Rectangle {
                        id: cellRect
                        implicitWidth: minColWidth
                        implicitHeight: cellContent.implicitHeight + cellContent.anchors.margins*2
                        Layout.fillHeight: true
                        color: cellColor
                        border {
                            width: 1
                            color: "#828790"
                        }

                        Item {
                            id: nestedArrow
                            width: 16
                            height: 16
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }

                            MouseArea {
                                id: openNestTable
                                anchors.fill: parent

                                onClicked: {
                                    subTable.makeVisible()
                                }
                            }

                            Component.onCompleted: {
                                if(index == 0) {
                                    var obj = Qt.createQmlObject('import QtQuick 2.0;
                                Image {
                                    width: 16
                                    height: 16
                                    source: "qrc:/images/components/tablenested/arrow-nested-48x48.png"

                                }',
                                this,
                                '')
                                }
                            }
                        }

                        Connections {
                            target: nestRootItem
                            onColWidthChanged: {
                                if(index == elemIndex) {
                                    implicitWidth = newWidth
                                }
                            }
                        }

                        Item {
                            id: cellContent
                            width: parent.width - nestedArrow.width
                            property int anchMargins: 5

                            Component.onCompleted: {
                                if(index == 0) {
                                    anchors.left = nestedArrow.right

                                }
                                else {
                                    anchors.fill = parent
                                    anchors.margins = anchMargins
                                }

                                if(modelData.r === "images") {
                                    var obj = Qt.createQmlObject('import QtQuick 2.0;
                                    Image {
                                        source: "file:/home/polaris/dev/Salko/Products/Photoshoped/chornyi_pidzhak_s_bantom_i_uzorom_pered.png"
                                        anchors.verticalCenter: parent.verticalCenter
                                        fillMode: Image.PreserveAspectFit
                                    }',
                                                                 this,
                                                                 '')
                                    obj.width = Qt.binding(function() { return parent.width - anchMargins * 2 -nestedArrow.width } )
                                    obj.height = Qt.binding(function() { return parent.width - anchMargins * 2 - nestedArrow.width } )
                                    cellContent.implicitHeight = Qt.binding(function() { return obj.height + anchMargins * 2 } )
                                    cellText.destroy()
                                } else {
                                    cellContent.implicitHeight = Qt.binding(function() { return cellText.implicitHeight } )
                                }
                            }

                            Text {
                                id: cellText

                                width: parent.width
                                Layout.fillHeight: true
                                color: cellTextColor
                                wrapMode: Text.WrapAnywhere
                                text: tableModel.get(parentIndex)[modelData.r]
                            }
                        }

                        MouseArea {
                            id: mouseResize

                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                right: parent.right
                            }
                            width: 5

                            cursorShape: Qt.SplitHCursor
                            property var oldMouse

                            onPressed: {
                                oldMouse = mouseX
                            }

                            onPositionChanged: {
                                if (pressed) {
                                    parent.implicitWidth = cellRect.width + (mouseX - oldMouse)
                                    nestRootItem.colWidthChanged(index, parent.implicitWidth)
                                }
                            }
                        }
                    }
                }
            }

            states: [
                State {
                    name: "selected"

                    PropertyChanges {
                        target: elemItem
                        cellColor: sysPalette.highlight
                    }

                    PropertyChanges {
                        target: elemItem
                        cellTextColor: sysPalette.highlightedText
                    }
                }
            ]

            ChildTable {
                signal makeVisible()

                id: subTable
                tableModel: subproduct
                childRoles: roles
                height: 0
                visible: false
                width: parent.width

                onMakeVisible: {
                  height = (height == 0) ? childrenRect.height : 0
                    subTable.visible = !subTable.visible

                }
            }
        }
    }
}
