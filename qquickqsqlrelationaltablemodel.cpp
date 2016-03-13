#include "qquickqsqlrelationaltablemodel.h"

QQuickQSqlRelationalTableModel::QQuickQSqlRelationalTableModel(QObject *parent, QSqlDatabase db)
    : QSqlRelationalTableModel(parent,db)
{

}

QString QQuickQSqlRelationalTableModel::getValue(qint32 row, QString role) const {
    if (row >= 0 && row < rowCount()) {
        for(int i = 0; i < columnCount(); ++i) {
            qDebug() << (headerData(i, Qt::Horizontal)).toString();
            if((headerData(i, Qt::Horizontal)).toString() == role) {
                return (data(index(row,i))).toString();
            }
        }
        qWarning() << "No column found";
        return "";
    }
    else {
        qWarning() << "Incorrect row number";
        return "";
    }
}

