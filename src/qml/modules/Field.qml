import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

ColumnLayout {
    property string title
    property bool changed: false

    Label {
        id: fieldLabel
        text: title
    }

}
