#include "todolist.h"

ToDoList::ToDoList(QObject *parent) : QObject(parent)
{
    mitems.append({false,"Wash the car"});
    mitems.append({false,"Fix the tap connection"});
    mitems.append({true,"Do the laundry"});
}

QVector<ToDoItem> ToDoList::items() const
{
    return mitems;
}

// Update
bool ToDoList::setItemAt(int index, const ToDoItem &item)
{
    if (index<0 || index>=mitems.size())
        return false;
    const ToDoItem &old = mitems.at(index);
    if (old.done==item.done && old.description==item.description)
        return false;
    mitems[index] = item;
    return true;
}

// Add
void ToDoList::appendItem()
{
    emit preItemAdded();

    ToDoItem item;
    item.done = false;
    mitems.append(item);

    emit postItemAdded();
}

// Remove
void ToDoList::removeCompletedItems()
{
    for(int i=0;i<mitems.size();) {
        if (mitems.at(i).done) {
            emit preItemRemoved(i);
            mitems.remove(i);
            emit postItemRemoved();
        } else {
            i++;
        }
    }
}
