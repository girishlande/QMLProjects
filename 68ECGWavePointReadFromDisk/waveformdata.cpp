#include "waveformdata.h"

WaveformData::WaveformData()
{

}

WaveformData::WaveformData(int minx, int miny, int maxx, int maxy, std::vector<XY>& points)
    :m_minX(minx),m_minY(miny), m_maxX(maxx), m_maxY(maxy), m_points(points){

}

void WaveformData::setPoints(std::vector<XY>& points)
{
    m_points = points;
}

std::vector<XY> &WaveformData::getPoints()
{
    return m_points;
}

int WaveformData::minX()
{
    return m_minX;
}

int WaveformData::maxX()
{
    return m_maxX;
}

int WaveformData::minY()
{
    return m_minY;
}

int WaveformData::maxY()
{
    return m_maxY;
}
