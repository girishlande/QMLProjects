#ifndef TASKMANAGER_H
#define TASKMANAGER_H

#include <QObject>
#include <QTimer>
#include <counterprocessor.h>
#include <QThread>

class TaskManager : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(int counter READ counter WRITE setCounter NOTIFY counterChanged)
    explicit TaskManager(QObject *parent = nullptr);
    ~TaskManager();

    bool running() const;
    void setRunning(bool running);

    int counter() const;
    void setCounter(int counter);

signals:
    void runningChanged();
    void counterChanged();
    void runningUpdate(bool value);

private:
    bool m_running = true;
    int m_counter = 0;
    QThread workerThread;
    QTimer m_timer;
};

#endif // TASKMANAGER_H
