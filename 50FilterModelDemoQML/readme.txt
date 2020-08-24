16

It would be interesting to present a pure QML approach to the problem.
 This is not the shorted path, for sure, but it is a solution.

The approach is based on the DelegateModel available in the models QML module. 
It reads in the documentation:

The DelegateModel type encapsulates a model and the delegate that will be instantiated for items in the model.

It is usually not necessary to create a DelegateModel. However, 
it can be useful for manipulating and accessing the modelIndex when a QAbstractItemModel subclass is used as the model. 
Also, DelegateModel is used together with Package to provide delegates to multiple views, 
and with DelegateModelGroup to sort and filter delegate items.

DelegateModel is really a powerful type with a lot of functionalities (see the linked documentation for details). 
Two key properties of DelegateModel are groups and filterOnGroup. The former is basically a list of DelegateModelGroup 
which defines the items to be filtered or not. The latter is used to apply a specific filter, i.e. choose a specific 
DelegateModelGroup contained in groups, by simply setting the property to the name of the chosen group.

Note that referring to VisualDataModel or DelegateModel is the same since the first is provided for compatibility
 reasons (the same applies to VisualDataGroup w.r.t. DelegateModelGroup).

Summing up, it is possible to filter a model in full QML in this way:

Create a model as a source of filtered models
Feed the model to a VisualDataModel/DelegateModel
Define a VisualDataGroup/DelegateModelGroup (or more than one) - includeByDefault set to false 
to avoid automatic addition of all items from the original model
Define policies to populate the groups
Set filterOnGroup to the chosen group
Set the view model to the VisualDataModel model
In the next example, for simplicity, I just populate the group once, during the Component.onCompleted event handler.
 As said, policies should be chosen and that's depends on the specific use case.

In the example only the items with key role equal to 0 are added to the group key0 which is the one shown in the ListView.
 The checklist described above is highlighted in the code.