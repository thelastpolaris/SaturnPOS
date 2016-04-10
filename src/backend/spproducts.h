#ifndef SPPRODUCTS_H
#define SPPRODUCTS_H

#include "tablenested.h"
#include "modules/twodimensionalmodel.h"

#include <QObject>

class SPProducts : public QObject
{
    Q_OBJECT
public:
    explicit SPProducts(QObject *parent = 0);
    Q_PROPERTY (TableNested* productsModel MEMBER productsModel NOTIFY productsModelChanged)
    Q_PROPERTY (TwoDimensionalModel* categories MEMBER categories NOTIFY categoriesChanged)
    Q_PROPERTY (TwoDimensionalModel* sizes MEMBER sizes NOTIFY sizesChanged)
    Q_PROPERTY (TwoDimensionalModel* colors MEMBER colors NOTIFY colorsChanged)
signals:
    void productsModelChanged();
    void categoriesChanged();
    void sizesChanged();
    void colorsChanged();
public slots:

private:
    TableNested* productsModel;
    TwoDimensionalModel* categories;
    TwoDimensionalModel* sizes;
    TwoDimensionalModel* colors;
    void updateCategories();
    void updateSizes();
    void updateColors();
};

#endif // SPPRODUCTS_H
