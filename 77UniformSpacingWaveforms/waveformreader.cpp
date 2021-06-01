#include "waveformreader.h"
#include <qfile.h>
#include <qdebug.h>

WaveformReader::WaveformReader()
{

}

WaveformData WaveformReader::ReadWaveform(QString fileName)
{
    std::vector<XY> points;

    int minX = INT_MAX;
    int minY = INT_MAX;
    int maxX = INT_MIN;
    int maxY = INT_MIN;
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        qDebug()<<"filenot opened"<<endl;
    }
    else
    {
        QTextStream in(&file);
        in.setCodec("UTF-8"); // change the file codec to UTF-8.
        while(!in.atEnd())
        {
            QString line = in.readLine();
            QStringList p = line.split( "," );
            if (p.length()==2) {
                int x = floor(p[0].toFloat());
                int y = floor(p[1].toFloat());
                if (x<minX) minX = x;
                if (x>maxX) maxX = x;
                if (y<minY) minY = y;
                if (y>maxY) maxY = y;
                XY point = { p[0].toFloat(),p[1].toFloat()};
                points.push_back(point);
            }
        }
    }
    file.close();

    //InterpolatePoints(points);
    ScalePoints(points,minY,maxY);

    ReadLimits(fileName,minX,minY,maxX,maxY);

    return WaveformData(minX,minY,maxX,maxY,points);
}

void WaveformReader::InterpolatePoints(std::vector<XY>& points)
{
    std::vector<XY> interpolatedPoints;
    for(int i=1;i<points.size();i++) {
        XY prev = points[i-1];
        XY curr = points[i];

        float x1 = prev.x;
        float y1 = prev.y;

        float x2 = curr.x;
        float y2 = curr.y;

        float xdiff = x2-x1;
        float ydiff = y2-y1;
        float nsteps = xdiff / 0.1;
        for(int j=0;j<nsteps;j++) {
            float x3 = j*0.1 + x1;
            float y3 = (ydiff/nsteps) * j + y1;
            interpolatedPoints.push_back(XY{x3,y3});
        }
    }
    interpolatedPoints.push_back(points[points.size()-1]);

    qDebug() << "Interpolated points:";
    PrintPoints(interpolatedPoints);
}

void WaveformReader::ScalePoints(std::vector<XY> &points,int minY,int maxY)
{
    qDebug() << " MInY:" << minY <<  " maxY:" << maxY;
    int diff1 = maxY-minY;
    int diff2 = 256;
    std::vector<XY> ScaledPoints;
    for(int i=0;i<points.size();i++) {
        XY curr = points[i];
        float x1 = curr.x;
        float y1 = curr.y;
        float offset = y1 - minY;
        float y2 = (offset*diff2)/diff1;
        ScaledPoints.push_back(XY{x1,(float)floor(y2)});
    }
    PrintPoints(ScaledPoints);
}

void WaveformReader::PrintPoints(std::vector<XY> &points)
{
    for(int i=0;i<points.size();i++) {
        qDebug() << points[i].x << "," << points[i].y;
    }
}

void WaveformReader::ReadLimits(QString fileName,int& minx,int& miny,int& maxx,int& maxy)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        qDebug()<<"filenot opened"<<endl;
    }
    else
    {
        QTextStream in(&file);
        in.setCodec("UTF-8"); // change the file codec to UTF-8.
        while(!in.atEnd())
        {
            QString line = in.readLine();
            QStringList p = line.split( "=" );
            if (p.length()==2) {
                if (p[0] == "minx")
                    minx = p[1].toInt();
                else if (p[0]=="miny")
                    miny = p[1].toInt();
                else if (p[0]=="maxx")
                    maxx = p[1].toInt();
                else if (p[0]=="maxy")
                    maxy = p[1].toInt();
            }
        }
    }

}
