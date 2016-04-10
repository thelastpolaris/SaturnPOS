import QtQuick 2.0

Item {
    property int minimumLeft: 200
    property int minimumRight: 200
    property int dragMinX: minimumLeft
    property int dragMaxX: parent.width - minimumRight
    property double portion: 0.68

    width: 10
    height: parent.height

    onXChanged: {if(mouseDrag.pressed) portion = x/parent.width/*;console.log(clientsLeft.width)*/}

    MouseArea {
        id: mouseDrag
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.SplitHCursor
        drag{
            target: parent
            axis: Drag.XAxis
            minimumX: dragMinX
            maximumX: dragMaxX
        }
    }
}

