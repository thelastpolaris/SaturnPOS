#include "tablesubproducts.h"
#include <QSqlQuery>

TableSubProducts::TableSubProducts(int prodID, QObject *parent, QSqlDatabase db)
    :QQuickSqlRelationalTableModel(parent, db), db(db), productID(prodID)
{
    QSqlQuery query;
    query.prepare("SELECT sub.barcode, amount, reserved, note, s.name as size FROM subproducts "
                  "AS sub, sizes AS s WHERE sub.product_id = ? AND s.size_id = sub.size");
    query.bindValue(0, prodID);
    success = query.exec();
    setQuery(query);
    QQuickSqlRelationalTableModel::select();
    /*QHash<int, QByteArray>::const_iterator i = role_names.constBegin();
    while (i != role_names.constEnd()) {
        qDebug() << i.key() << ": " << i.value();
        ++i;
    }*/
}
