#ifndef SATURNPOS_H
#define SATURNPOS_H

#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QQmlEngine>
#include <QJSEngine>
#include <QtSql>
#include <QtQml>

#include "qquicksqlrelationaltablemodel.h"

class SaturnPOS : public QObject
{
    Q_OBJECT
public:
    static SaturnPOS* createInstance();
    static SaturnPOS* Instance() { return pinstance; }

    Q_INVOKABLE QString getStandardPath() const { return standardPath; }

    Q_PROPERTY (QQuickSqlRelationalTableModel* productsModel MEMBER productsModel NOTIFY productsModelChanged)

signals:
    void productsModelChanged();

public slots:

private:
    explicit SaturnPOS(QObject *parent = 0);
    static SaturnPOS* pinstance;
    QSqlDatabase db;
    QString standardPath;
    QQuickSqlRelationalTableModel* productsModel;

};

#endif // SATURNPOS_H
