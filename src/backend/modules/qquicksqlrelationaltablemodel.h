#ifndef QQUICKSQLRELATIONALTABLEMODEL_H
#define QQUICKSQLRELATIONALTABLEMODEL_H

#include <QObject>
#include <QSqlRelationalTableModel>
#include <QSqlDatabase>
#include <QDebug>
#include <QSqlRecord>

class QQuickSqlRelationalTableModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit QQuickSqlRelationalTableModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
    QHash<int, QByteArray> roleNames() const override {return role_names;}
    QVariant data(const QModelIndex& item, int role) const override;
    bool select() override;
    //~QQuickSqlRelationalTableModel() { }
    //QQuickSqlRelationalTableModel(const QQuickSqlRelationalTableModel& copy) { }

signals:

public slots:
protected:
    void virtual generateRoleNames();
    QHash<int, QByteArray> role_names;
    bool success; // Quick hack to allow to generate roles in QTableSubProducts
};
#endif // QQUICKSQLRELATIONALTABLEMODEL_H
