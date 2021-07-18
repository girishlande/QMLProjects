In this project we are showing how to use a worker object to get the time consuming job done.
TaskManager is main class which is created in main thread.
TaskManager in turn creates another thread and CounterProcessor object (this is worker class which performs some time consuming job)
IF we directly do time consuming job in TaskManager then Main thread will halt and we cannot move the window.
BUt when this time consuming job is done in another class object and it does the job it can tell TaskManager that the job is done using signals and slots. 
Main purpose of this is to avoid blocking the UI when time consuming operation is being done. 
