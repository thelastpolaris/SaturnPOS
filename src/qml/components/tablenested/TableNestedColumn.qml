import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: tableNestedItem

    property QtObject parentRow: parent
    property ListModel colModel: parent.tableModel

    Layout.fillWidth: true
    Layout.fillHeight: true

    property Component cellDelegate
    property string modelRole

    SystemPalette {
        id: sysPalette
        colorGroup: SystemPalette.Active
    }

    function sortModel(sortRole, asc) {
        for(var i = 0; i < colModel.count; ++i) {
            var index_min = i;

            for(var a = i; a < colModel.count; ++a) {
                var a1 = colModel.get(a)[sortRole].toLowerCase()
                var a2 = colModel.get(index_min)[sortRole].toLowerCase()
                if(asc) {
                    if(a1.localeCompare(a2) < 0) index_min = a
                }
                else {
                    if(a1.localeCompare(a2) > 0) index_min = a
                }
            }

            if(i != index_min) {
                colModel.move(i, index_min, 1)
                colModel.move(index_min - 1, i, 1)
            }
        }
    }

    ColumnLayout {
        id: nestedColumn

        spacing: 0
        Layout.fillWidth: true
        Layout.fillHeight: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Rectangle {
            id: header
            property int innerMargin: 5
            Layout.preferredWidth: headerLabel.contentWidth
            Layout.preferredHeight: headerLabel.contentHeight

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "grey"

            MouseArea {
                property bool asc: true
                anchors {
                    fill: parent
                    leftMargin: 5
                    rightMargin: 5
                    //To prevent overlapping of resizer mousearea
                }

                ListModel {
                    id:clearModel
                }

                onClicked: {
                    sortModel(modelRole, asc)
                    asc = !asc
                    parentRow.updateModel()
                }
            }

            Text {
                id: headerLabel
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                text: modelRole
            }
        }

        Connections {
            target: parentRow

            onUpdateModel: {
                colRepeater.model = clearModel
                colRepeater.model = colModel
            }
        }

        Repeater {
            id: colRepeater
            model: colModel

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: cell

                Layout.preferredWidth: cellText.contentWidth + cellText.anchors.margins
                Layout.preferredHeight: cellText.contentHeight + cellText.anchors.margins
                border {
                    width: 1
                    color: "#828790"
                }

                Connections {
                    target: parentRow
                    onCellHeightChanged: {
                        if(index === elemIndex) {
                            cell.Layout.preferredHeight = newHeight
                        }
                    }

                    onSelectedChanged: {
                        state = ""
                        if(index === elemIndex) {
                            state = "selected"
                        }
                    }
                }

                Text {
                    id: cellText
                    text: model[modelRole]

                    onContentHeightChanged: {
                        parentRow.cellHeightChanged(anchors.margins + parent.height * (contentHeight/parent.height), index)
                        // Multiply parent.height by the difference between parent and cellText height
                        // to find the new value. Without it the old height will be passed
                    }

                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: 5
                    }
                    wrapMode: Text.WordWrap
                }

                MouseArea {
                    anchors {
                        fill: parent
                        leftMargin: 5
                        rightMargin: 5
                        //To prevent overlapping of resizer mousearea
                    }

                    onClicked: {
                        parentRow.selectedChanged(index)
                    }
                }

                states: [
                    State {
                        name: "selected"

                        PropertyChanges {
                            target: cell
                            color: sysPalette.highlight
                        }

                        PropertyChanges {
                            target: cellText
                            color: sysPalette.highlightedText
                        }
                    }
                ]
            }
        }
    }

    Item {
        id: resizer
        width: 10
        height: nestedColumn.height
        anchors {
            right: parent.right
            rightMargin: -5
            //To center the resizer on the edge
        }

        MouseArea {
            id: mouseDrag

            propagateComposedEvents: true
            preventStealing: true

            property int oldMouseX
            property int numMinWidth: 0
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.SplitHCursor

            onPressed: {
                oldMouseX = mouseX
            }

            onPositionChanged: {
                if (pressed) {
                    var minWidth = new Array();
                    for(var i = 0; i < nestedColumn.children.length - 1; ++i) {
                        var foo = nestedColumn.children[i]
                        var textWidth = foo.children[0].contentWidth
                        if(textWidth >= foo.width) {
                            minWidth.push(textWidth * 1.5)
                        }
                    }
                    var numMinWidth = Math.max.apply(Math,minWidth)
                    if(numMinWidth < 0) numMinWidth = 0
                    if(mouseX + nestedColumn.width > nestedColumn.x + numMinWidth) {
                        tableNestedItem.Layout.maximumWidth = nestedColumn.width + (mouseX - oldMouseX)
                    }

                    // Set similar height for the whole row

                }
            }
        }
    }
}
