This project explains C++ models in QML and how to use them.
How to display and modify C++ models in QML.

Create new empty QML project todo-list
Create ToDoList.qml. create Frame object.
Create ListView as a child. 
Add implicitWidth and implicitHeight to the ListView. 
Frame will adjust based on implicit size of its child. 

add model:100

delegate for each model item will be checkbox and textfield to give description 
delegate: RowLayout { 
	CheckBox {}
	TextField {}
}

add Layout.fillWidth = true for textfield. so that it stretches itself to full with in frame

add ListModel instead of 100
model: ListModel { 
	ListElement { done:true, description: "Wash the car" } 
	ListElement { done:true, description: "Do the laundry" } 
	ListElement { done: false, description: "Do the homework"}
}

Set Checkbox checked property to model.done
and TextField text property to model.description 

update model on checkbox clicked and textfield onTextChanged. this will keep model in sync with the view changes. 
		CheckBox {
                    checked: model.done
                    onClicked: {
                        model.done = checked
                    }
                }
                TextField {
                    text: model.description
                    onTextChanged: {
                        model.description = text
                    }
                }

//Create C++ model now. 
File->new Qt item Model. Name it ToDoModel and derived it from QAbstractListModel. 
Check Items are editable. UnCheck everything. 

//Add Enum in Model
enum roles {
  DoneRole = Qt::UserRole,
  DescriptionRole
};

//add supporting function 
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

main.cpp changes 
---------------------
add #include<QQmlApplicationEngine"
#include <ToDoModel>
qmlRegisterType<ToDoModel>("ToDo",1,0,"ToDoModel");


qml changes
-----------------
import ToDo 1.0 
model: ToDomodel {}

With Above changes, you should see 100 entries in toDo list. 
Note , you won't be able to change data for e.g checkbox. because we haven't update setData function. 

We can store in this Model class ToDoModel. 
But This is ViewModel and mostly data is stored in backend. Hence lets create ToDoList class. 

Create a C++ class ToDoList. Derive it from QObject. 
It should support add, modify , delete operation. 
define structure in class
struct ToDoItem {
	bool done;
	QString description;
};

create Qvector of ToDoItems, mItems.
private:
QVector<ToDoItem> mItems;

Add getter function for same.
QVector<ToDoItem> items() const;
return mItems;

Add update method to update existing element in list
bool setItemAt(int index, const ToDoitem &item);
if (index<0 || index>=mitems.size())
  return false;
const ToDOItem& old = mItems.at(index);
if (old.done == item.done && old.description== item.description)
   return false;
mItems[index]=item;
return true;

declare signals for indicating append and remove operations from the list.

signals:
	void preItemAppended();
	void postitemAppended();
	void preItemRemove(int index);
	void postItemRemoved();

public slots:
	void appenditem();
	void removeCompletedItems();

void appendItem()
----------------------
emit preItemAppended();
ToDoItem item;
item.done = false;
mItems.append(item);
emit postitemAppended();

void removeCompletedItems()
-------------------------------
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

// Update model methods to use List data 
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

//Now, add support in main.cpp to add List Object and declare it as uncreatable type in qml.
So that instances of list can't be creates inside qml. 
#include <QQmlContext>
qmlRegisterUncreatableType<ToDOList>("ToDo",1,0,"ToDoList",
"ToDoList should not be createdin QML");
ToDoList toDoList;
engine.rootContext()->setContextProperty("toDoList",&toDoList);

ToDOList.qml
----------
model: TODoModel {
   list: toDoList
}





