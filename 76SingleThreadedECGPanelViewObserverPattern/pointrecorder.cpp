#include "pointrecorder.h"
#include <algorithm>
#include <mutex>
#include <assert.h>
#include <qtimer.h>
#include <qdebug.h>

#include "worker.h"
#include "waveformdata.h"
#include "waveformreader.h"

std::mutex m_mutex;

void PointRecorder::RegisterListener(Worker *worker)
{
    std::lock_guard<std::mutex> guard(m_mutex);
    assert(worker);
    if (worker) {
        m_workers.push_back(worker);
    }
}

void PointRecorder::UnRegisterListener(Worker *worker)
{
    std::lock_guard<std::mutex> guard(m_mutex);
    assert(worker);
    if (worker) {
        m_workers.erase(std::remove(m_workers.begin(), m_workers.end(), worker),
                        m_workers.end());
    }
}

void PointRecorder::StartRecordingPoints()
{
    initialiseWaveformdata();
    assert(!m_timer);

}

void PointRecorder::initialiseWaveformdata()
{
    // Iterate on all the types of waveforms and add the waveform data in member
    ReadWaveformPoints(ECGWave);
    ReadWaveformPoints(ECGWave1);
    ReadWaveformPoints(ECGWave2);
    ReadWaveformPoints(ECGWave3);
}

void PointRecorder::ReadWaveformPoints(WaveformType type)
{
    QString fileName = GetWaveformdataFilePath(type);
    WaveformReader reader;
    WaveformData data = reader.ReadWaveform(fileName);
    m_wavedata[type] = data;
    m_wavedataLOC[type] = LocalWaveData{0,0};
}


QString PointRecorder::GetWaveformdataFilePath(WaveformType type)
{
    QString fileName(":/wavedata/ecg.txt");
    switch(type) {
    case ECGWave1:
        fileName = QString(":/wavedata/ecg1.txt"); break;
    case ECGWave2:
        fileName = QString(":/wavedata/ecg2.txt"); break;
    case ECGWave3:
        fileName = QString(":/wavedata/ecg3.txt"); break;
    case SineWave:
        fileName = QString(":/wavedata/sine.txt"); break;
    case SquareWave:
        fileName = QString(":/wavedata/square.txt"); break;
    }
    return fileName;
}

void PointRecorder::addOnePoint() {
    AddWaveformPoint(ECGWave);
    AddWaveformPoint(ECGWave1);
    AddWaveformPoint(ECGWave2);
    AddWaveformPoint(ECGWave3);
}

WaveformData& PointRecorder::GetWaveformData(WaveformType type)
{
    return m_wavedata[type];
}

void PointRecorder::AddWaveformPoint(WaveformType type) {
    WaveformData& data = m_wavedata[type]; // standard wave form data from disk

    LocalWaveData& meta = m_wavedataLOC[type];
    std::vector<XY>& points = meta.data.getPoints();
    int& pointCounter = meta.m_pointCounter;
    size_t counter = points.size();
    std::vector<XY>& waveformPoints = data.getPoints();

    float ex = waveformPoints[pointCounter].x;
    float ey = waveformPoints[pointCounter].y;

    if (counter>=waveformPoints.size()) {
        float px = points[counter-1].x;
        float diff = 0;
        if (pointCounter!=0) {
            diff = ex - waveformPoints[pointCounter-1].x;
        }
        ex = px + diff;
    }
    pointCounter = (pointCounter + 1) % waveformPoints.size();

    points.push_back(XY{ex,ey});
    NotifyWorker(type,XY{ex,ey});
}

void PointRecorder::NotifyWorker(WaveformType type, XY point)
{
    for(auto w: m_workers) {
        if (w->type()==type)
            w->AddPoint(point);
    }
}

