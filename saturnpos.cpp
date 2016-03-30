#include "saturnpos.h"

SaturnPOS* SaturnPOS::pinstance;

SaturnPOS::SaturnPOS(QObject *parent) : QObject(parent)
{
    pinstance = this;

    standardPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir sp(standardPath);
    if(!sp.exists()) {
        sp.mkpath(standardPath);
    }

    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("saturnPOS");
    db.setUserName("saturnPOS");
    db.setPassword("redwood32");
    db.open();

    productsModel = new QQuickSqlRelationalTableModel();

    productsModel->setTable("products");

    productsModel->setRelation(3, QSqlRelation("categories", "id", "name"));
    productsModel->setHeaderData(3, Qt::Horizontal, QObject::tr("categories"));

    productsModel->select();
}

SaturnPOS* SaturnPOS::createInstance() {
    delete pinstance;
    //pinstance is created directly in the constructor
    new SaturnPOS();
    return pinstance;
}
