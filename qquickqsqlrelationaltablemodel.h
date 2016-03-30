#ifndef QQUICKQSQLRELATIONALTABLEMODEL_H
#define QQUICKQSQLRELATIONALTABLEMODEL_H

#include <QObject>
#include <QSqlRelationalTableModel>
#include <QSqlDatabase>
#include <QDebug>

class QQuickQSqlRelationalTableModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit QQuickQSqlRelationalTableModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
    Q_INVOKABLE QString getValue(qint32 row, QString role) const;
    bool select();
    

signals:

public slots:
private:
};

#endif // QQUICKQSQLRELATIONALTABLEMODEL_H
