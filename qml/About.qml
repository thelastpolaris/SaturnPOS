import QtQuick 2.5
import QtQuick.Dialogs 1.2

Dialog {
    visible: true
    title: "Blue sky dialog"
    modality: Qt.ApplicationModal
    standardButtons: StandardButton.Close
        Text {
            text: "Hello blue sky!"
            color: "navy"
            anchors.centerIn: parent
        }
}
