#ifndef INITGROUP_H
#define INITGROUP_H

#include <QObject>
#include <qmap.h>

class InitGroup : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title)
    Q_PROPERTY(QString thickness READ title)
    Q_PROPERTY(QString increment READ title)
    Q_PROPERTY(QString plane READ title)
    Q_PROPERTY(QString type READ title)
    Q_PROPERTY(QString imgCount READ title)
    Q_PROPERTY(QString planningVP READ title)
    Q_PROPERTY(QString arcDes READ title)

public:
    explicit InitGroup(QObject *parent = nullptr);

    void AddKeyValuePair(QString key,QString value);

    QString title();
    QString thickness();
    QString increment();
    QString plane();
    QString type();
    QString imgCount();
    QString planningVP();
    QString arcDes();

signals:

public slots:

private:

    QMap<QString, QString> m_map;
};

#endif // INITGROUP_H
