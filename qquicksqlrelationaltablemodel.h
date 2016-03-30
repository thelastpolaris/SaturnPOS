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
    QHash<int, QByteArray> roleNames() const {return role_names;}
    QVariant data(const QModelIndex& item, int role) const;
    bool select();

signals:

public slots:
private:
    void generateRoleNames();
    QHash<int, QByteArray> role_names;
};

#endif // QQuickSqlRelationalTableModel_H
