#ifndef FILEREADER_H
#define FILEREADER_H

#include <QObject>
#include <qvector.h>

class FileReader : public QObject
{
    Q_OBJECT
public:
    explicit FileReader(QObject *parent = nullptr);

    Q_INVOKABLE void readFile(const int filename);
    Q_INVOKABLE int getPoints();
    Q_INVOKABLE int getX(int index);
    Q_INVOKABLE int getY(int index);

signals:

public slots:

private:
    QVector<int> m_points;
};

#endif // FILEREADER_H
