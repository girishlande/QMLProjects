#ifndef INIREADER_H
#define INIREADER_H

#include <QObject>

class IniReader : public QObject
{
    Q_OBJECT
public:
    explicit IniReader(QObject *parent = nullptr);
    void readInit(QString path);

signals:

public slots:

private:
};

#endif // INIREADER_H
