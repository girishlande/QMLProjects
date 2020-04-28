#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject *parent = nullptr);

    void readFile(QString& path,QStringList& list);
    void writeFile(QString& path);

signals:

public slots:
};

#endif // FILEHANDLER_H
