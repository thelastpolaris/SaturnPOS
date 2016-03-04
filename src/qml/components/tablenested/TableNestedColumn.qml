import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: tableNestedItem

    property QtObject parentRow: parent

    Layout.fillWidth: true
    Layout.fillHeight: true

    property Component cellDelegate
    property string modelRole

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

            Text {
                id: headerLabel
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                text: modelRole
            }
        }

        Repeater {
            model: libraryModel

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
                }

                Text {
                    id: cellText
                    text: model[modelRole]

                    onContentHeightChanged: {
                        parentRow.cellHeightChanged(parent.height * (contentHeight/parent.height), index)
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

                    }

                    onClicked: {
                        console.log("sd")
                    }

                }
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
                            minWidth.push(textWidth)
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
