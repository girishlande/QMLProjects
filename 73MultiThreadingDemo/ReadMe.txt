This is multithreading using Worker class.
We create a new Thread. We create worker class instance. We move our worker class to this new thread. 

QThread instance:
QThread* thread = new QThread;
Worker* worker = new Worker();
worker->moveToThread(thread);
connect(worker, SIGNAL (error(QString)), this, SLOT (errorString(QString)));
connect(thread, SIGNAL (started()), worker, SLOT (process()));
connect(worker, SIGNAL (finished()), thread, SLOT (quit()));
connect(worker, SIGNAL (finished()), worker, SLOT (deleteLater()));
connect(thread, SIGNAL (finished()), thread, SLOT (deleteLater()));
thread->start();
