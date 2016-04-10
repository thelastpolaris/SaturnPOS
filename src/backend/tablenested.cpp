#include "tablenested.h"
#include "tablesubproducts.h"
#include <QSqlQuery>

TableNested::TableNested(QObject *parent, QSqlDatabase db) : QQuickSqlRelationalTableModel(parent, db)
{

}

void TableNested::generateRoleNames() {
    QQuickSqlRelationalTableModel::generateRoleNames();
    role_names.insert(Qt::UserRole + role_names.count() + 1, "subproducts");
    /*QHash<int, QByteArray>::const_iterator i = role_names.constBegin();
    while (i != role_names.constEnd()) {
        qDebug() << i.key() << ": " << i.value();
        ++i;
    }*/
}

QVariant TableNested::data(const QModelIndex &item, int role) const {
    if(item.row() >= rowCount()) {
        return QString();
    } else if (role == Qt::UserRole + role_names.count()) {
        TableSubProducts* model = new TableSubProducts(item.row());
        return QVariant::fromValue(model);
        return QString();
    } else {
        return QQuickSqlRelationalTableModel::data(item, role);
    }
}

