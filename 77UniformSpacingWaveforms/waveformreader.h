#ifndef WAVEFORMREADER_H
#define WAVEFORMREADER_H

#include "waveformdata.h"
#include <qstring.h>
class WaveformReader
{
public:
    WaveformReader();

    WaveformData ReadWaveform(QString filename);

    void InterpolatePoints(std::vector<XY>& points);
    void ScalePoints(std::vector<XY>& points,int minY,int maxY);
    void PrintPoints(std::vector<XY>& points);

private:
    void ReadLimits(QString filename, int& minx,int& miny,int& maxx,int& maxy);
};

#endif // WAVEFORMREADER_H
