#include "twodimensionalmodel.h"

TwoDimensionalModel::TwoDimensionalModel(QObject *parent) : QAbstractListModel(parent)
{

}

QHash<int, QByteArray> TwoDimensionalModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[KeyRole] = "key";
    roles[ValueRole] = "value";
    return roles;
}

QVariant TwoDimensionalModel::data(const QModelIndex &index, int role) const {
    if(index.row() < 0 || index.row() >= modelData.count()) {
        return QVariant();
    }

    if(role == KeyRole) {
        return modelData[index.row()].first;
    }
    else if(role == ValueRole) {
        return modelData[index.row()].second;
    }
    return QVariant();
}

int TwoDimensionalModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return modelData.count();
}

void TwoDimensionalModel::addValue(QVariant key, QVariant value) {
    modelData.push_back(qMakePair(key,value));
}

void TwoDimensionalModel::clear() {
    modelData.clear();
}
