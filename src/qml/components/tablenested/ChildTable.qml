import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    id: nestRootItem
    property ListModel tableModel
    property Component delegate
    property int minColWidth: 150
    property var childRoles

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

        delegate: RowLayout {
            id: elemRow
            spacing: 0
            property color cellColor: "white"
            property color cellTextColor: "black"
            property int parentIndex: index

            Connections {
                target: elemView
                onCurrentIndexChanged: {
                    if(elemView.currentIndex === index) {
                        state = "selected"
                    }
                    else state = ""
                }
            }



            Repeater {
                model: roles
                Rectangle {
                    id: cellRect
                    implicitWidth: minColWidth
                    implicitHeight: cellText.contentHeight + cellText.anchors.margins*2
                    Layout.fillHeight: true
                    color: cellColor
                    border {
                        width: 1
                        color: "#828790"
                    }

                    MouseArea {
                        id: mouseSelect
                        anchors.fill: parent

                        onClicked: {
                            elemView.currentIndex = parentIndex
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

                    Text {
                        id: cellText
                        anchors{
                            margins: 5
                            centerIn: parent
                            fill: parent
                        }
                        Layout.fillHeight: true
                        color: cellTextColor
                        wrapMode: Text.WrapAnywhere
                        text: tableModel.get(parentIndex)[modelData .r]
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

            states: [
                State {
                    name: "selected"

                    PropertyChanges {
                        target: elemRow
                        cellColor: sysPalette.highlight
                    }

                    PropertyChanges {
                        target: elemRow
                        cellTextColor: sysPalette.highlightedText
                    }
                }
            ]
        }
    }
}

