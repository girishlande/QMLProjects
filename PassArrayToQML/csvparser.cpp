#include "csvparser.h"
#include <qfile.h>
#include <qdebug.h>

CSVParser::CSVParser(QObject *parent) : QObject(parent)
{

}

void CSVParser::parseFile(const QString &path,QList<GLine>& lines)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return;
    }

    bool first = true;
    QTextStream in(&file);
    while (!in.atEnd())
    {
        QString line = in.readLine();
        QStringList list = line.split(',');
        if(first) {
            for(int i=0;i<list.count();i++) {
                lines.push_back(GLine());
            }
            first = false;
        }
        for(int i=0;i<list.count();i++) {
            lines[i].addPoint(list[i].toDouble());
        }
    }
    file.close();
}
