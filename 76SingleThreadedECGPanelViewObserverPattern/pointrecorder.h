#ifndef POINTRECORDER_H
#define POINTRECORDER_H

#include <qobject.h>

#include <iostream>
#include <vector>
#include <map>

#include "waveformutils.h"
#include "waveformdata.h"

class Worker;
class QTimer;

struct LocalWaveData {
    int m_counter;
    int m_pointCounter;
    WaveformData data;
};

class PointRecorder:public QObject {
    Q_OBJECT
public:

    static PointRecorder& getInstance() {
        static PointRecorder instance;  // Guaranteed to be destroyed.
        // Instantiated on first use.
        return instance;
    }

    void RegisterListener(Worker* worker);
    void UnRegisterListener(Worker* topo);

    void StartRecordingPoints();
    void addOnePoint();

    WaveformData& GetWaveformData(WaveformType type);

    PointRecorder(PointRecorder const&) = delete;
    void operator=(PointRecorder const&) = delete;

protected:
    void initialiseWaveformdata();
    void ReadWaveformPoints(WaveformType type);
    QString GetWaveformdataFilePath(WaveformType type);
    void AddWaveformPoint(WaveformType type);
    void NotifyWorker(WaveformType type,XY point);

private:

    PointRecorder() {} // private constructor

    std::vector<Worker*> m_workers;
    std::map<WaveformType,WaveformData> m_wavedata; // waveform data from disk
    std::map<WaveformType,WaveformData> m_wavedataGLOB; // history
    std::map<WaveformType,LocalWaveData> m_wavedataLOC; // Current local waveform data

    QTimer *m_timer = nullptr;

};

#endif // POINTRECORDER_H
