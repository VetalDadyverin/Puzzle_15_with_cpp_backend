#include "backend.h"
#include <cstdlib>
#include <cmath>
#include <algorithm>

MyListModel::MyListModel(QObject *parent) : QAbstractListModel(parent){
    for(int i = 0; i < 16; ++i){
        m_cells.push_back(i);
    }
    m_cells.move(0,12);

}
MyListModel::~MyListModel(){

}

int MyListModel::rowCount(const QModelIndex &parent) const{
    Q_UNUSED(parent);
    return m_cells.count();
}

QVariant MyListModel::data(const QModelIndex &index, int role) const{
    int row = index.row();
    if(row < 0 || row >= m_cells.count()){
        return QVariant();
    }

    switch (role) {
    case Qt::DisplayRole:
        return m_cells.value(row);
    }

    return QVariant();
}


void MyListModel::clicked_cell(const int number_index){
    int zero_index = find_zero();
    int min = std::min(number_index, zero_index);
    int max = std::max(number_index, zero_index);
    if(check_zero(number_index, zero_index)){
        qDebug() << "Swapping";

        if(beginMoveRows(QModelIndex(), min, min, QModelIndex(), max + 1)){
            m_cells.move(min, max);
            qDebug() << "m_cells";
            endMoveRows();
        }
        if(beginMoveRows(QModelIndex(), max - 1, max - 1, QModelIndex(), min)){
            m_cells.move(max - 1, min);
            qDebug() << "m_cells2";
            endMoveRows();
        }
//        std::swap(m_cells.begin() + max, m_cells.begin() + min);
// Doesn`t work swap for QList::iterator
    }
    qDebug() << "__________________";
}


int MyListModel::find_zero(){
    for(int i = 0; i < m_cells.count(); ++i){
        if(m_cells.at(i) == 0){
            return i;
        }
    }
    return -1;
}

bool MyListModel::check_zero(const int number_index, const int zero_index){
    int difference = abs(number_index - zero_index);
    return (difference == 1 && (number_index / 4) == (zero_index / 4)) || (difference == 4);
}

bool MyListModel::check_shuffled(){
    int result = 0;
    for(int i = 0; i < m_cells.count(); ++i){
        if(m_cells.at(i) != 0){
            for(int j = 0; j < i; ++j){
                if(m_cells.at(j) != 0){
                    if(m_cells.at(i) < m_cells.at(j)){
                        result++;
                    }
                }
            }
        }
    }
    result += find_zero() / 4 + 1;
    return result & 1;
}

void MyListModel::shuffle(){
    int first_pos, second_pos;
    srand(time(NULL));
    do{
        for(int i = 0; i < 200; ++i){
            first_pos = rand() % 16;
            second_pos = rand() % 16;
            if(first_pos < second_pos){
                if(beginMoveRows(QModelIndex(), first_pos, first_pos, QModelIndex(), second_pos + 1)){
                    endMoveRows();
                }
                m_cells.move(first_pos, second_pos);

            }
            else{
                if(beginMoveRows(QModelIndex(), second_pos, second_pos, QModelIndex(), first_pos + 1)){
                    endMoveRows();
                }
                m_cells.move(second_pos, first_pos);
            }

        }
    } while(check_shuffled());
}

void MyListModel::clicked_shuffled(){
    shuffle();
    emit dataChanged(QAbstractItemModel::createIndex(0,0), QAbstractItemModel::createIndex(15,0));
}

bool MyListModel::check_solved(){
    for(int i = 0; i < m_cells.count() - 1; ++i){
        if(m_cells.at(i) != i + 1){
            return false;
        }
    }
    return true;
}


