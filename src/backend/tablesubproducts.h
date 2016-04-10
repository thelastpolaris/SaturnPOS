#ifndef TABLESUBPRODUCTS_H
#define TABLESUBPRODUCTS_H

#include <QObject>
#include "modules/qquicksqlrelationaltablemodel.h"

class TableSubProducts : public QQuickSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit TableSubProducts(int prodID, QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
    /*QVariant data(const QModelIndex &index, int role) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;*/
signals:

public slots:

protected:
    int productID;
    //QList<QVector<QString>> modelData;
    //void virtual generateRoleNames();
    //QHash<int, QByteArray> roleNames;
    QSqlDatabase db;
};

#endif // TABLESUBPRODUCTS_H
