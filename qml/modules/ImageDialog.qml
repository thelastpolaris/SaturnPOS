import QtQuick 2.5
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Item {
    property int imageWidth: 100
    property int imageHeight: 100
    property string imageSrc

    property bool imageLoaded: false

    signal fileUploaded(string state, string file)

    Component.onCompleted: {
        if(imageSrc.length) imageLoaded = true
        else imageSrc = "qrc:/images/modules/noimage_128x128.png"
    }

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
                    iconImage.state = "edit"
                }
                else {
                    iconImage.state = "upload"
                }
                mainImageBlur.state = "blurOn"
                mainImageBlur.visible = true
                iconImage.opacity = 1
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                mainImageBlur.state = "blurOff"
                blurTimer.running = true
                iconImage.opacity = 0
            }
            onClicked: {
                imageDialog.visible = true
            }
        }
    }

    Image {
        id: iconImage
        anchors.centerIn: parent
        opacity: 0
        z:1

        Behavior on opacity {
            PropertyAnimation {
                duration: 800
                easing.type: Easing.InSine
            }
        }

        states: [
            State {
                name: "edit"

                PropertyChanges {
                    target: iconImage
                    source: "/images/images/pencil_64x64.png"
                }
            },
            State {
                name: "upload"

                PropertyChanges {
                    target: iconImage
                    source: "/images/images/upload_48x48.png"
                }
            }
        ]
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

    FileDialog {
        id: imageDialog
        visible: false
        nameFilters: [ qsTr("Image files")+" (*.jpg* *.jpeg *.png *.gif *.bmp)"]
        onAccepted: {
            fileUploaded(iconImage.state, fileUrl)
        }
    }
}
