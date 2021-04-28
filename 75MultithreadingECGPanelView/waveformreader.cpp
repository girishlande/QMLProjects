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

    ReadLimits(fileName,minX,minY,maxX,maxY);

    return WaveformData(minX,minY,maxX,maxY,points);
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
