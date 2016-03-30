#include "qquicksqlrelationaltablemodel.h"

QQuickSqlRelationalTableModel::QQuickSqlRelationalTableModel(QObject *parent, QSqlDatabase db)
    : QSqlRelationalTableModel(parent,db)
{

}

bool QQuickSqlRelationalTableModel::select() {
    bool ret = QSqlRelationalTableModel::select();

    if(ret) {
        generateRoleNames();
    }

    return ret;
}

void QQuickSqlRelationalTableModel::generateRoleNames() {
    role_names.clear();

    for(int i = 0; i < record().count(); ++i) {
        role_names[Qt::UserRole + i + 1] = record().fieldName(i).toUtf8();
    }
}

QVariant QQuickSqlRelationalTableModel::data(const QModelIndex &item, int role) const {
    if(item.row() >= rowCount()) {
        return QString();
    }

    if(role < Qt::UserRole) {
        return QSqlQueryModel::data(item, role);
    } else {
        int columnId = role - 1 - Qt::UserRole;
        QModelIndex modelIndex = this->index(item.row(), columnId);
        return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
}
