#ifndef CSVPARSER_H
#define CSVPARSER_H

#include <QObject>
#include <gline.h>

class CSVParser : public QObject
{
    Q_OBJECT
public:
    explicit CSVParser(QObject *parent = nullptr);
    void parseFile(const QString& path,QList<GLine>& lines);

signals:

public slots:
};

#endif // CSVPARSER_H
