#ifndef TWODIMENSIONALMODEL_H
#define TWODIMENSIONALMODEL_H

#include <QObject>
#include <QAbstractListModel>

class TwoDimensionalModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        KeyRole = Qt::UserRole + 1,
        ValueRole
    };
    explicit TwoDimensionalModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const override;
    int rowCount(const QModelIndex &parent) const override;
    void addValue(QVariant key, QVariant value);
    void clear();
signals:

public slots:
protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QVector<QPair<QVariant, QVariant>> modelData;
};

#endif // TWODIMENSIONALMODEL_H
