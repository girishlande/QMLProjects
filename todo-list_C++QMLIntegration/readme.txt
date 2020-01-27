This project explains C++ models in QML and how to use them. ToDo List 
How to display and modify C++ models in QML.

Create new project todo-list
Create ToDoList.qml. create Frame object as root parent.
Create ListView as a child. 
Add implicitWidth and implicitHeight to the ListView. 
Frame will adjust based on implicit height of its child. 

add model:100

delete will be checkbox and textfield to give description 
delegate: RowLayout { 
	CheckBox {}
	TextField {}
}

add Layout.fillWidth = true for textfield. 

add ListModel instead of 100
model: ListModel { 
	ListElement { done:true, description: "Wash the car" } 
	ListElement { done:true, description: "Do the laundry" } 
}

Set Checkbox checked property to model.done.

update model on checkbox click and textfield onEditingFinished. 

Create C++ model now. 
File->new Qt item Model. Name it ToDoModel and derived it from QAbstractListModel. 
Check Items are editable. UnCheck everything. 

Add Enum in Modle 
enum {
  DoneRole = Qt::UserRole,
  DescriptionRole
};

virtual QHash<int,QByteArray> roleNames() const override;
{
   QHash<int,QByteArray> names;
   names[DoneRole] = "done";
   names[DescriptionRole] = "description";
   return names;
}

rowCount() {
  return 100;
}

data() {
   switch(role) {
     case DoneRole: return QVariant(false);  
     case DescriptionRole: return QVariant(QStringLiteral("test description"));
}

add #include<QQmlApplicationEngine"
#include <ToDoModel>
qmlRegisterType<ToDoModel>("ToDo",1,0,"ToDoModel");

import ToDo 1.0 

model: ToDomodel {}

With Above changes, you should see 100 entries in toDo list. 
Note , you won't be able to change data for e.g checkbox. because we haven't update setData function. 

We can store in this Model class ToDoModel. 
But This is ViewModel.  and mostly data is stored in backend. Hence lets create ToDoList class. 

Create a C++ class ToDoList. Derive it from QObject. 
It should support add, modify , delete operation. 
define structure in class
struct ToDoItem {
	bool done;
	QString description;
};


QVector<ToDoItem> items() const;
return mItems;

bool setItemAt(int index, const ToDoitem &item);
if (index<0 || index>=mitems.size())
  return false;
const ToDOItem& old = mItems.at(index);
if (old.done == item.done && old.description== item.description)
   return false;
mItems[index]=item;
return true;

private:
QVector<ToDoItem> mItems;

signals:
	void preItemAppended();
	void postitemAppended();

	void preItemRemove(int index);
	void postItemRemoved();

public slots:
	void appenditem();
	void removeCompletedItems();

void appendItem()
emit preItemAppended();
ToDoItem item;
item.done = false;
mItems.append(item);
emit postitemAppended();

void removeCompletedItems()
for(int i=0;i<mItems.size();)
  if(mItems.at(i).done)
	emit preItemRemoved(i);
	mItems.remove(i);
	emit postItemRemoved();
   else 
	i++;

Add some default items in list
 mitems.append({false,"Wash the car"});
 mitems.append({false,"Fix the tap connection"});
 mitems.append({true,"Do the laundry"});

Add this toDOlist in root context
in main.cpp make changes 
#include <QQmlContext>
ToDoList toDoList;
engine.rootContext()->setContextProperty("toDoList",&toDoList);

Now make Model aware of the list. 
Forward declare ToDoList
class ToDoList;
Q_PROPERTY(ToDoList *list READ list WRITE list)

private:
  ToDoList *mList;

right click on member and select create getter and setter functions.

goto source file (.cpp)
mList(nullptr)

ToDOList *ToDOModel::list() const
  return mList;

void ToDoModel::setList(ToDoList *list)
beginResetModel();

if (mList)
mList->disconnect(this);

mList = list;
if (mList)
  connect(mList,&ToDoList::preItemAppended,this[=](){
const int index = mList->items.size();
beginInsertRows(QmodelIndex(),index,index);
});
connect(mList,&ToDoList::postItemAppended,this,[=]() {
  endInsertRows();
});
  connect(mList,&ToDoList::preItemRemoved,this[=](int index){
beginRemoveRows(QmodelIndex(),index,index);
});
connect(mList,&ToDoList::postItemRemoved,this[=](int index){
endRemoveRows(QmodelIndex(),index,index);
});
endResetModel();

rowCount()
return mList->items().size();

data() {
const ToDoItem item = mList->items().at(index.row());
switch(role) {
case DOneRole: return QVariant(item.done);
case DescriptionRole: return QVariant(item.description);
}

setData() {
ToDOItem item = mList->items().at(index.row());
switch(role) {
case DOneRole: item.done = value.toBool(); break;
case DescriptionRole: item.description = value.toString(); break;
}

if (mList->setItemAt(index.row(), item) {
  emit dataCHanged(index,index,Qvector<int>() <<role;
}

open main.cpp
=============
qmlRegisterUncreatableType<ToDOList>("ToDo",1,0,"ToDOList",
"ToDOList should not be createdin QML"));

ToDOList.qml
----------
model: TODoModel {
   list: toDoList
}





