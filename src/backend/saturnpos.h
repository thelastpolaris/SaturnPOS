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

#include "spproducts.h"

class SaturnPOS : public QObject
{
    Q_OBJECT
public:
    static SaturnPOS* createInstance();
    static SaturnPOS* Instance() { return pinstance; }

    Q_INVOKABLE QString getStandardPath() const { return standardPath; }
    Q_PROPERTY (SPProducts* products MEMBER products NOTIFY productsChanged())

signals:
    void productsChanged();

public slots:

private:
    explicit SaturnPOS(QObject *parent = 0);
    static SaturnPOS* pinstance;
    QSqlDatabase db;
    QString standardPath;
    SPProducts* products;
};

#endif // SATURNPOS_H
