TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

copydata.commands += $(MKDIR) $$OUT_PWD/src/ &&
copydata.commands += $(COPY_DIR) $$PWD/src/qml $$OUT_PWD/src/
first.depends = $(first) copydata
export(first.depends)
export(copydata.commands)
QMAKE_EXTRA_TARGETS += first copydata

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS +=

DISTFILES += \
    src/qml/main.qml \
    src/qml/Products.qml \
    src/qml/Sales.qml \
    src/qml/Clients.qml \
    src/qml/About.qml \
    src/qml/MainButtons.qml \
    src/qml/modules/DatePicker.qml \
    src/qml/modules/ImageDialog.qml \
    src/qml/components/Field.qml \
    src/qml/components/VerticalResizer.qml \
    src/qml/components/HorizontalResizer.qml \
    src/qml/components/tablenested/TableNested.qml \
    src/qml/components/tablenested/TableNestedColumn.qml
