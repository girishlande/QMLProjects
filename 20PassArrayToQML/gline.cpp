#include "gline.h"

GLine::GLine()
{

}

const QVariantList &GLine::points() const
{
    return m_points;
}

void GLine::addPoint(double pos)
{
    m_points.push_back(pos);
}
