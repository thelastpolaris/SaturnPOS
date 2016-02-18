import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property int imageWidth: 100
    property int imageHeight: 100
    property string imageSrc
    property bool imageLoaded: false
    property string iconPath: ""

    Image {
        fillMode: Image.PreserveAspectFit
        width: imageWidth
        height: imageHeight
        source: imageSrc
        id: mainImage

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                if(imageLoaded) {
                    iconPath = "/images/images/pencil_64x64.png"
                }
                else {
                    iconPath = "/images/images/upload_48x48.png"
                }
                mainImageBlur.state = "blurOn"
                mainImageBlur.visible = true
                iconImage.opacity = 1
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                iconPath = ""
                mainImageBlur.state = "blurOff"
                blurTimer.running = true
                iconImage.opacity = 0
            }
        }
    }

    Image {
        id: iconImage
        anchors.centerIn: parent
        source: iconPath
        opacity: 0
        z:1

        Behavior on opacity {
            PropertyAnimation {
                duration: 800
                easing.type: Easing.InSine
            }
        }

    }

    FastBlur {
        id: mainImageBlur
        anchors.fill: parent
        source: mainImage
        radius: 0
        z:0
        visible: false
        transparentBorder: false
        states: [
            State {
                name: "blurOn"

                PropertyChanges {
                    target: mainImageBlur
                    radius: 30
                }
            },
            State {
                name: "blurOff"

                PropertyChanges {
                    target: mainImageBlur
                    radius: 0
                }
            }
        ]

        Timer {
            id: blurTimer
            interval: 500;
            onTriggered: {
                mainImageBlur.visible = false
            }
        }

        Behavior on radius {
            PropertyAnimation {
                duration: 700
                easing.type: Easing.InOutQuint
            }
        }
    }
}
