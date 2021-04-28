#ifndef WORKER_H
#define WORKER_H

#include <QObject>

class Worker : public QObject
{
    Q_OBJECT
public:
    explicit Worker(QObject *parent = nullptr);
    Worker(int id);

public slots:
    void process();

signals:
    void finished();
    void error(QString error);
    void processed(int i);

private:
    int m_id = 0;
};

#endif // WORKER_H
