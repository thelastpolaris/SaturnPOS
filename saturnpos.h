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

#include "qquickqsqlrelationaltablemodel.h"

class SaturnPOS : public QObject
{
    Q_OBJECT
public:
    static SaturnPOS* createInstance();
    static SaturnPOS* Instance() { return pinstance; }

    Q_INVOKABLE QString getStandardPath() const { return standardPath; }

    Q_PROPERTY (QQuickQSqlRelationalTableModel* productsModel MEMBER productsModel NOTIFY productsModelChanged)

signals:
    void productsModelChanged();

public slots:

private:
    explicit SaturnPOS(QObject *parent = 0);
    static SaturnPOS* pinstance;
    QSqlDatabase db;
    QString standardPath;
    QQuickQSqlRelationalTableModel* productsModel;

};

#endif // SATURNPOS_H
