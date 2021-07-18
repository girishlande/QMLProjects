#ifndef COUNTERPROCESSOR_H
#define COUNTERPROCESSOR_H

#include <QObject>
#include <QTimer>

class CounterProcessor : public QObject
{
    Q_OBJECT
public:
    explicit CounterProcessor(QObject *parent = nullptr);


public slots:
    void work();
    void setRunning(bool running);

signals:
    void runningChanged();
    void counterChanged(int counter);

private:
    bool m_running = true;
    int m_counter = 0;
};

#endif // COUNTERPROCESSOR_H
