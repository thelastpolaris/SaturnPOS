#include "spproducts.h"
#include <QSqlQuery>

SPProducts::SPProducts(QObject *parent) : QObject(parent), productsModel(new TableNested),
    categories(new TwoDimensionalModel), sizes(new TwoDimensionalModel), colors(new TwoDimensionalModel)
{
    productsModel->setTable("products");
    productsModel->setRelation(3, QSqlRelation("categories", "category_id", "category_name"));
    productsModel->setRelation(7, QSqlRelation("colors", "color_id", "color_name"));
    productsModel->select();

    updateCategories();
    updateSizes();
    updateColors();
}

void SPProducts::updateCategories() {
    QSqlQuery query("SELECT category_id, category_name FROM categories");
    query.exec();
    categories->clear();

    while (query.next()) {
        QString category_id = query.value(0).toString();
        QString category = query.value(1).toString();
        categories->addValue(category_id, category);

        qDebug() << category_id << ": " << category;
    }
}

void SPProducts::updateSizes() {
    QSqlQuery query("SELECT category_id, category_name FROM categories");
    query.exec();
    sizes->clear();

    while (query.next()) {
        QString category_id = query.value(0).toString();
        QString category = query.value(1).toString();
        sizes->addValue(category_id, category);

        qDebug() << category_id << ": " << category;
    }
}

void SPProducts::updateColors() {
    QSqlQuery query("SELECT color_id, color_name FROM colors");
    query.exec();
    colors->clear();

    while (query.next()) {
        QString category_id = query.value(0).toString();
        QString category = query.value(1).toString();
        colors->addValue(category_id, category);

        qDebug() << category_id << ": " << category;
    }
}
