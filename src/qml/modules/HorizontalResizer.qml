import QtQuick 2.0

Item {
    property int minimumLeft: 200
    property int minimumRight: 200
    property int dragMinY: minimumLeft
    property int dragMaxY: parent.height - minimumRight
    property double portion: 0.8

    height: 10
    width: parent.width

    onYChanged: if(mouseDrag.pressed) portion = y/parent.height

    MouseArea {
        id: mouseDrag
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.SplitVCursor
        drag{
            target: parent
            axis: Drag.YAxis
            minimumY: dragMinY
            maximumY: dragMaxY
        }
    }
}

