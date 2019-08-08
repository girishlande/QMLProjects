#ifndef USER_H
#define USER_H

#include <QObject>
#include <qstring.h>
#include <qcolor.h>

class User : public QObject
{
    Q_OBJECT
public:
    explicit User(QObject *parent = nullptr);
    User(QString,QString);
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString col READ col WRITE setCol NOTIFY colChanged)

    QString name();
    void setName(QString name);
    QString col();
    void setCol(QString col);

signals:
    void nameChanged();
    void colChanged();

public slots:

private:
    QString m_name;
    QString m_color;

};

#endif // USER_H
