import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: tableNestedItem

    property QtObject parentRow: parent
    property ListModel colModel: parentRow.tableModel
    property int cellMargin: 10
    property int nestedItemMinWidth
    property var maxCellHeight: parentRow.maxCellHeight

    Component.onCompleted: {
        if(Positioner.isLastItem) {
            var component = Qt.createComponent(Rectangle);
            if (component.status == Component.Ready)
                component.createObject(parentRow, {"width": 100, "height": 100});
        }
    }
    width: 150
    height: childrenRect.height

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

    onWidthChanged: {
        if(nestedItemMinWidth && width < nestedItemMinWidth) {
            width = nestedItemMinWidth
        }
    }

    ColumnLayout {
        id: nestedColumn

        spacing: 0
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
                           cell.Layout.preferredHeight = maxCellHeight[index]
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
                        var newHeight = anchors.margins + parent.height * (contentHeight/parent.height)
                        if(newHeight > parentRow.maxCellHeight[index]) {
                            maxCellHeight[index] = newHeight
                        }
                        else {
                            maxCellHeight[index] = 0
                            parentRow.getMaxCellHeight()
                            parentRow.cellHeightChanged(maxCellHeight[index], index)
                        }

                        // Multiply parent.height by the difference between parent and cellText height
                        // to find the new value. Without it the old height will be passed
                    }

                    Connections {
                        target: parentRow
                        onGetMaxCellHeight: {
                            var ch = cellText.contentHeight
                            if(ch > maxCellHeight[index]) maxCellHeight[index] = ch
                            else if(!maxCellHeight[index]) maxCellHeight.push(ch)
                            console.log(maxCellHeight[index])
                        }
                    }

                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: cellMargin
                    }
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
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

            anchors.fill: parent
            cursorShape: Qt.SplitHCursor
            property var oldMouse

            onPressed: {
                oldMouse = mouseX
            }

            onPositionChanged: {
                if (pressed) {
                    var numMinWidth
                    for(var i = 0; i < nestedColumn.children.length - 1; ++i) {
                        var foo = nestedColumn.children[i]
                        var textWidth = foo.children[0].contentWidth
                        if(textWidth + cellMargin * 2 >= foo.width) {
                            numMinWidth = textWidth + cellMargin * 2
                            console.log(numMinWidth)
                        }
                    }
                    if(nestedColumn.width + mouseX < numMinWidth) return
                    tableNestedItem.width = nestedColumn.width + (mouseX - oldMouse)
                    if(numMinWidth) nestedItemMinWidth = numMinWidth
                }
            }
        }
    }
}
