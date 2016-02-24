import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    z: 10
    width: dateField.width
    height: dateField.height

    property Item topParent
    FocusScope {
    TextField {
        id: dateField
        inputMask: "99/B9/9999"
        validator: dateRegExp

        RegExpValidator {
            id: dateRegExp
            //regExp: /((3[0-1]|[0-2][1-9]))\/(0[1-9]|1[0-2])\/\d{4}/
        }

        property date enteredDate

        onActiveFocusChanged: {
            focus = activeFocus
            if(focus) {
                calendar.state = "on"
                forceActiveFocus()
            }
            else {
                calendar.state = "off"

                enteredDate = Date.fromLocaleDateString(Qt.locale(),dateField.text,"dd/MM/yyyy")
                if(acceptableInput && enteredDate.toLocaleDateString()) calendar.selectedDate = enteredDate
                else if (dateField.text != "//") { // don't show warning when nothing was entered and focuse changed
                        dateField.text = ""
                        dateError.state = "on"
                    }
            }
        }
        onTextChanged: {
            if(acceptableInput) {
                enteredDate = Date.fromLocaleDateString(Qt.locale(),dateField.text,"dd/MM/yyyy")
                if(enteredDate) calendar.selectedDate = enteredDate
            }
        }
    }


    Rectangle {
        parent: topParent

        onVisibleChanged: {
            x = topParent.mapFromItem(dateField, dateField.x, dateField.y).x
            y = topParent.mapFromItem(dateField, dateField.x, dateField.y).y - dateField.height - 5
        }

        id: dateError
        width: invalidDate.width + 10
        height: invalidDate.height + 10
        anchors {
            top: dateField.bottom
            topMargin: 2
        }
        visible: false

        border.color: "black"
        border.width: 2

        Text {
            id: invalidDate
            text: qsTr("Неверная дата")
            anchors.centerIn: parent
        }

        Timer {
            id: errorTimer
            interval: 3000
            onTriggered: {
                dateError.state = "off"
            }
        }

        states: [
            State {
                name: "off"

                PropertyChanges {
                    target: dateError
                    opacity: 0
                }
                PropertyChanges {
                    target: dateError
                    visible: false
                }
            },
            State {
                name: "on"

                PropertyChanges {
                    target: dateError
                    opacity: 1
                    visible: true
                }

                PropertyChanges {
                    target: errorTimer
                    running: true
                }
            }
        ]

        transitions: [
            Transition {
                from: "on"
                to: "off"

                SequentialAnimation{
                    NumberAnimation {
                        target: dateError
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: dateError
                        property: "visible"
                        duration: 0
                    }
                }
            },
            Transition {
                from: "off"
                to: "on"
                SequentialAnimation{
                    NumberAnimation {
                        target: dateError
                        property: "visible"
                        duration: 0
                    }
                    NumberAnimation {
                        target: dateError
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
    }

    Calendar {
        id: calendar
        parent: topParent

        onVisibleChanged: {
            movePosition()
        }

        onReleased: {
            dateField.text = date.toLocaleDateString(Qt.locale(),"dd/MM/yyyy")
            state = "off"
            dateField.focus = false
        }

        function movePosition() {
            var xPos = topParent.mapFromItem(dateField, dateField.x, dateField.y).x
            var yPos = topParent.mapFromItem(dateField, dateField.x, dateField.y).y
            var xDiff = topParent.width - xPos
            var yDiff = topParent.height - 15 - yPos
            x = (xDiff < calendar.width) ? xPos - (calendar.width - xDiff + 10) : xPos
            y = (yDiff < calendar.height) ? yPos - calendar.height - dateField.height + 5  : yPos + dateField.height + 5
        }

        states: [
            State {
                name: "off"

                PropertyChanges {
                    target: calendar
                    opacity: 0
                }
                PropertyChanges {
                    target: calendar
                    visible: false
                }

            },
            State {
                name: "on"

                PropertyChanges {
                    target: calendar
                    opacity: 1
                    visible: true
                }
            }
        ]

        transitions: [
            Transition {
                from: "on"
                to: "off"

                SequentialAnimation{
                    NumberAnimation {
                        target: calendar
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: calendar
                        property: "visible"
                        duration: 0
                    }
                }
            },
            Transition {
                from: "off"
                to: "on"
                SequentialAnimation{
                    NumberAnimation {
                        target: calendar
                        property: "visible"
                        duration: 0
                    }
                    NumberAnimation {
                        target: calendar
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]

        anchors{
            top: dateField.bottom
            topMargin: 5
        }
        state: "off"
    }
    }
}
