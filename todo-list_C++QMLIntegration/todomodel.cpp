#include "todomodel.h"
#include "todolist.h"

ToDoModel::ToDoModel(QObject *parent)
    : QAbstractListModel(parent),
      mlist(nullptr)
{
}

int ToDoModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mlist)
        return 0;

    return mlist->items().size();
}

QVariant ToDoModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mlist)
        return QVariant();

    const ToDoItem &item = mlist->items().at(index.row());

    switch(role) {
    case DoneRole: return QVariant(item.done);
    case DescriptionRole: return QVariant(item.description);
    }
    // FIXME: Implement me!
    return QVariant();
}

bool ToDoModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!mlist) {
        return false;
    }

    ToDoItem item = mlist->items().at(index.row());

    switch(role) {
    case DoneRole: item.done = value.toBool(); break;
    case DescriptionRole: item.description = value.toString(); break;
    }

    if (mlist->setItemAt(index.row(),item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ToDoModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> ToDoModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names[DoneRole] = "done";
    names[DescriptionRole] = "description";
    return names;
}

ToDoList *ToDoModel::list() const
{
    return mlist;
}

void ToDoModel::setList(ToDoList *value)
{
    beginResetModel();

    if(mlist)
        mlist->disconnect(this);

    mlist = value;

    if (mlist) {
        connect(mlist,&ToDoList::preItemAdded,this,[=]() {
            const int index  = mlist->items().size();
            beginInsertRows(QModelIndex(),index,index);
        });
        connect(mlist,&ToDoList::postItemAdded,this,[=](){
            endInsertRows();
        });
        connect(mlist,&ToDoList::preItemRemoved,this,[=](int index){
            beginRemoveRows(QModelIndex(),index,index);
        });
        connect(mlist,&ToDoList::postItemRemoved,this,[=](){
            endRemoveRows();
        });
    }

    endResetModel();
}
