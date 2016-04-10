#ifndef TABLENESTED_H
#define TABLENESTED_H

#include <QObject>
#include "modules/qquicksqlrelationaltablemodel.h"

class TableNested : public QQuickSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit TableNested(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
    void generateRoleNames() override;
    QVariant data(const QModelIndex &item, int role) const override;
signals:

public slots:
};

#endif // TABLENESTED_H
