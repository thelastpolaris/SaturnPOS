TEMPLATE = app

QT += qml quick widgets sql

CONFIG += c++11

SOURCES += main.cpp \
    src/backend/saturnpos.cpp \
    src/backend/tablenested.cpp \
    src/backend/modules/qquicksqlrelationaltablemodel.cpp \
    src/backend/tablesubproducts.cpp \
    src/backend/spproducts.cpp \
    src/backend/modules/twodimensionalmodel.cpp

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

HEADERS += \
    src/backend/saturnpos.h \
    src/backend/modules/qquicksqlrelationaltablemodel.h \
    src/backend/tablenested.h \
    src/backend/tablesubproducts.h \
    src/backend/spproducts.h \
    src/backend/modules/twodimensionalmodel.h

DISTFILES += \
    src/qml/main.qml \
    src/qml/Products.qml \
    src/qml/Sales.qml \
    src/qml/Clients.qml \
    src/qml/About.qml \
    src/qml/MainButtons.qml \
    #Modules
    src/qml/modules/Field.qml \
    src/qml/modules/VerticalResizer.qml \
    src/qml/modules/HorizontalResizer.qml \
    src/qml/modules/SearchDropDown.qml \
    #Plugins
    src/qml/plugins/DatePicker.qml \
    src/qml/plugins/ImageDialog.qml \
    src/qml/plugins/tablenested/TableNested.qml \
    src/qml/plugins/tablenested/TableNestedColumn.qml \
    src/qml/plugins/tablenested/ChildTable.qml
