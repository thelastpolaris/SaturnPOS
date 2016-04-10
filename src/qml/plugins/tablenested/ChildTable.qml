import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    id: nestedChildTableRoot
    property var tableModel
    property int minColWidth: 150
    property var roles
    height: 0
    Component.onCompleted: {
        state = ""
    }

    Connections {
        target: nestedTableRoot
        onGlobalColWidthChanged: {
            colWidthChanged(elemIndex, newWidth, false)
        }
    }

    //Signals
    signal colWidthChanged(int elemIndex, int newWidth, bool propagate)

    SystemPalette {
        id: sysPalette
        colorGroup: SystemPalette.Active
    }

    states: [
        State {
            name: "on"

            PropertyChanges {
                target: nestedChildTableRoot
                height: elemChildView.height
            }
            PropertyChanges {
                target: elemChildView
                opacity: 1
            }
        },
        State {
            name: ""
            PropertyChanges {
                target: elemChildView
                opacity: 0
            }
            PropertyChanges {
                target: nestedChildTableRoot
                height: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "on"
            to: ""

            SequentialAnimation{
                NumberAnimation {
                    target: nestedChildTableRoot
                    property: "height"
                    duration: 100
                    //easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: elemChildView
                    property: "opacity"
                    duration: 0
                }
            }
        },
        Transition {
            from: ""
            to: "on"
            SequentialAnimation{
                NumberAnimation {
                    target: elemChildView
                    property: "opacity"
                    duration: 0
                }
                NumberAnimation {
                    target: nestedChildTableRoot
                    property: "height"
                    duration: 100
                    //easing.type: Easing.InOutQuad
                }
            }
        }
    ]



    ListView {
        id: elemChildView
        model: tableModel
        interactive: false
        currentIndex: -1 // To disable selecting 0 row by default
        opacity: 0

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            Component.onCompleted: {
                if(elemChildView.model.rowCount()) visible = false
            }

            color: sysPalette.base

            Text {
                text: qsTr("Подпродукты не найдены")
                color: sysPalette.buttonText
                anchors.centerIn: parent
                font {
                    pointSize: 11
                }
            }
        }

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
            id: tableHeader
            property color headerColor: sysPalette.mid
            property color headerTextColor: sysPalette.buttonText

            spacing: 0
            Repeater {
                id: headerRepeater
                model: childTableRoles

                Rectangle {
                    id: header
                    color: headerColor

                    implicitWidth: minColWidth
                    implicitHeight: headerLabel.contentHeight
                    Layout.fillHeight: true

                    Connections {
                        target: nestedChildTableRoot
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

                        onClicked: {
                            elemChildView.sortModel(tableModel, modelData.r, asc)
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
            id: tableChildDelegate
            property color cellColor: sysPalette.base
            property color cellTextColor: sysPalette.buttonText
            property color cellBorderColor: sysPalette.mid
            property QtObject parentModel: model
            property bool mouseAreasEnabled: (nestedChildTableRoot.state == "on") ? true : false

            width: childrenRect.width
            height: childrenRect.height

            Connections {
                target: elemChildView
                onCurrentIndexChanged: {
                    if(elemChildView.currentIndex === index) {
                        state = "selected"
                        elemView.currentIndex = tableDelegate.elemIndex
                    }
                    else state = ""
                }
            }

            Connections {
                target: elemView
                onCurrentIndexChanged: {
                    if(elemView.currentIndex != tableDelegate.elemIndex) elemChildView.currentIndex = -1
                }
            }

            RowLayout {
                id: elemRow
                spacing: 0

                MouseArea {
                    id: mouseSelect
                    anchors.fill: parent
                    enabled: mouseAreasEnabled

                    onClicked: {
                        elemChildView.currentIndex = index
                    }
                }

                Repeater {
                    model: childTableRoles

                    Rectangle {
                        property string modelValue: tableChildDelegate.parentModel[modelData.role]

                        id: cellRect
                        implicitWidth: minColWidth
                        implicitHeight: cellContent.implicitHeight + cellContent.anchors.margins*2
                        Layout.fillHeight: true
                        color: cellColor
                        border {
                            width: 1
                            color: cellBorderColor//"#828790"
                        }

                        Connections {
                            target: nestedChildTableRoot
                            onColWidthChanged: {
                                if(index == elemIndex) {
                                    implicitWidth = newWidth
                                }
                            }
                        }

                        Item {
                            id: cellContent
                            width: parent.width// - nestedArrow.width
                            implicitHeight: cellText.implicitHeight
                            property int anchMargins: 5
                            anchors {
                                fill: parent
                                margins: anchMargins
                            }

                            Component.onCompleted: {
                                //cellContent.implicitHeight = Qt.binding(function() { return cellText.implicitHeight } )
                                //If child table needs to display images insert code for image displaying headerRepeater
                            }

                            Text {
                                id: cellText

                                width: parent.width
                                Layout.fillHeight: true
                                color: cellTextColor
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
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
                            visible: mouseAreasEnabled

                            cursorShape: Qt.SplitHCursor
                            property var oldMouse

                            onPressed: {
                                oldMouse = mouseX
                            }

                            onPositionChanged: {
                                if (pressed) {
                                    parent.implicitWidth = cellRect.width + (mouseX - oldMouse)
                                    nestedChildTableRoot.colWidthChanged(index, parent.implicitWidth, true)
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
                        target: tableChildDelegate
                        cellColor: sysPalette.highlight
                    }

                    PropertyChanges {
                        target: tableChildDelegate
                        cellTextColor: sysPalette.highlightedText
                    }
                }
            ]
        }
    }
}
