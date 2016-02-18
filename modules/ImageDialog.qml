import QtQuick 2.0

Item {
    property int imageWidth: 100
    property int imageHeight: 100
    property string imageSrc
    property bool imageLoaded: false

    Image {
        fillMode: Image.PreserveAspectFit
        width: imageWidth
        height: imageHeight
        source: imageSrc

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                if(imageLoaded) {

                }
            }
        }

        Image {
            anchors.centerIn: parent
            source:"/images/images/pencil_64x64.png"
        }
    }
}
