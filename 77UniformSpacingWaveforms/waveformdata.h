#ifndef WAVEFORMDATA_H
#define WAVEFORMDATA_H

#include "waveformutils.h"
#include <iostream>
#include <vector>

class WaveformData
{
public:
    WaveformData();
    WaveformData(int minx, int miny, int maxx, int maxy, std::vector<XY>& points);
    WaveformData(std::vector<XY>& points);

    void setPoints(std::vector<XY>& points);
    std::vector<XY>& getPoints();

    int minX();
    int maxX();
    int minY();
    int maxY();

protected:

private:
    std::vector<XY> m_points;
    int m_minX;
    int m_minY;
    int m_maxX;
    int m_maxY;
};

#endif // WAVEFORMDATA_H
