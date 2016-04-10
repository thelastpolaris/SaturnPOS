import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import com.saturnpos 1.0

Item {
    id: nestedTableRoot
    property var tableModel
    property int minColWidth: 150
    property var roles
    property var childTableRoles
    clip: true

    //Internal properties
    //width: childrenRect.width

    //Signals
    signal colWidthChanged(int elemIndex, int newWidth)
    signal globalColWidthChanged(int elemIndex, int newWidth)

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
            property color headerColor: sysPalette.mid
            property color headerTextColor: sysPalette.buttonText

            spacing: 0
            Repeater {
                id: headerRepeater
                model: roles

                Rectangle {
                    id: header
                    color: headerColor

                    implicitWidth: minColWidth
                    implicitHeight: headerLabel.contentHeight
                    Layout.fillHeight: true

                    Connections {
                        target: nestedTableRoot
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

                        //This was need to update the view afte sorting the model
                        /*ListModel {
                            id:clearModel
                        }*/

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
                        text: modelData.title
                        color: headerTextColor
                    }
                }
            }
        }

        delegate: Item {
            id: tableDelegate
            property color cellColor: sysPalette.base
            property color cellTextColor: sysPalette.buttonText
            property color cellBorderColor: sysPalette.mid
            property QtObject parentModel: model
            property int elemIndex: index

            height: childrenRect.height
            width: childrenRect.width

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
                        property string modelValue: tableDelegate.parentModel[modelData.role]

                        id: cellRect
                        implicitWidth: minColWidth
                        implicitHeight: cellContent.implicitHeight + cellContent.anchors.margins*2
                        Layout.fillHeight: true
                        color: cellColor
                        border {
                            width: 1
                            color: cellBorderColor//"#828790"
                        }
                        //Only for root table (not child)
                        Item {
                            id: nestedArrow
                            width: 16
                            height: 16
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            states: State {
                                name: "rotated"
                                PropertyChanges {
                                    target: nestedArrow
                                    rotation: 90
                                }
                            }

                            transitions: Transition {
                                RotationAnimation { duration: 200 }
                            }

                            MouseArea {
                                id: openNestTable
                                anchors.fill: parent

                                onClicked: {
                                    subTable.makeVisible()
                                    if(!parent.state) parent.state = "rotated"
                                    else parent.state = ""
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
                                } else visible = false
                            }
                        }

                        Connections {
                            target: nestedTableRoot
                            onColWidthChanged: {
                                if(index == elemIndex) {
                                    implicitWidth = newWidth
                                }
                            }
                        }

                        Item {
                            id: cellContent
                            //width: parent.width// - nestedArrow.width
                            property int anchMargins: 5

                            Component.onCompleted: {
                                if(index == 0) {
                                    anchors.left = nestedArrow.right
                                }
                                else {
                                    anchors.fill = parent
                                    anchors.margins = anchMargins
                                }

                                if(modelData.role === "images" || modelData.role === "photo") {
                                    var obj = Qt.createQmlObject('import QtQuick 2.0;
                                    Image {
                                        anchors.verticalCenter: parent.verticalCenter
                                        fillMode: Image.PreserveAspectFit
                                    }',
                                                                 this,
                                                                 '')
                                    obj.width = Qt.binding(function() { return parent.width - anchMargins * 2 -nestedArrow.width } )
                                    obj.height = Qt.binding(function() { return parent.width - anchMargins * 2 - nestedArrow.width } )
                                    obj.source = "file:" + SaturnPOS.getStandardPath() + "/productImages/" + modelValue
                                    cellContent.implicitHeight = Qt.binding(function() { return obj.height + anchMargins * 2 } )
                                    cellText.destroy()
                                } else {
                                    cellContent.implicitHeight = Qt.binding(function() { return cellText.implicitHeight } )
                                }
                                if(modelData.role === "arrival") {
                                    cellText.text = Qt.formatDateTime(modelValue, "dd.MM.yyyy")
                                }
                            }

                            Text {
                                id: cellText

                                width: parent.width
                                Layout.fillHeight: true
                                color: cellTextColor
                                wrapMode: Text.WrapAnywhere
                                text: modelValue
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
                                    cellRect.implicitWidth = cellRect.width + (mouseX - oldMouse)
                                    nestedTableRoot.colWidthChanged(index, parent.implicitWidth)
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
                        target: tableDelegate
                        cellColor: sysPalette.highlight
                    }

                    PropertyChanges {
                        target: tableDelegate
                        cellTextColor: sysPalette.highlightedText
                    }
                }
            ]

            ChildTable {
                signal makeVisible()
                id: subTable
                anchors {
                    top: elemRow.bottom
                    left: parent.left
                    leftMargin: 10
                }

                tableModel: tableDelegate.parentModel['subproducts']
                roles: nestedTableRoot.childTableRoles

                onColWidthChanged: {
                    if(propagate) globalColWidthChanged(elemIndex, newWidth)
                }

                onMakeVisible: {
                    state = (state == "") ? "on" : ""
                }
            }
        }
    }
}
