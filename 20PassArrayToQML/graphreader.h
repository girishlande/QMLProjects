#ifndef GRAPHREADER_H
#define GRAPHREADER_H

#include <QObject>
#include "gline.h"

class GraphReader : public QObject
{
    Q_OBJECT
public:
    explicit GraphReader(QObject *parent = nullptr);
    void buildGraph();
    Q_INVOKABLE int lineCount();
    Q_INVOKABLE const QVariantList linePoints(int index);

signals:

public slots:

public:
    QList<GLine> m_lines;

};

#endif // GRAPHREADER_H
