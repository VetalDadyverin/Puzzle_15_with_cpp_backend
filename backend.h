#ifndef BACKEND_H
#define BACKEND_H
#include <QAbstractListModel>
#include <QObject>
#include <QVariant>
#include <QList>


class MyListModel : public QAbstractListModel{
    Q_OBJECT

public:
    explicit MyListModel(QObject *parent = 0);
    ~MyListModel();
    int rowCount(const QModelIndex &parent)const override;
    QVariant data(const QModelIndex &index, int role) const override;
    Q_INVOKABLE void clicked_shuffled();
    Q_INVOKABLE void clicked_cell(const int number_index);
    Q_INVOKABLE bool check_solved();
private:
    QList<int> m_cells;

    int find_zero();
    bool check_zero(const int number_index, const int zero_index);
    void shuffle();
    bool check_shuffled();
};


#endif // BACKEND_H

