#ifndef WAVEFORMUTILS_H
#define WAVEFORMUTILS_H

typedef struct {
    float x;
    float y;
}XY;

enum WaveformType {
    RandomWave=0,
    ECGWave,
    ECGWave1,
    ECGWave2,
    ECGWave3,
    SineWave,
    SquareWave
};

class WaveformUtils
{
public:
    WaveformUtils();
};

#endif // WAVEFORMUTILS_H
