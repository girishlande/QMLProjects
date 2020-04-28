#ifndef GLINE_H
#define GLINE_H

#include <QVariantList>
#include <qlist.h>

class GLine
{
public:
    explicit GLine();
    const QVariantList & points() const;
    void addPoint(double pos);

signals:

public slots:

public:
    QVariantList m_points;
};

#endif // GLINE_H
