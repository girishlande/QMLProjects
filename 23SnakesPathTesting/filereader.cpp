#include "filereader.h"
#include<qdebug.h>
#include <fstream>
#include <qfile.h>

FileReader::FileReader(QObject *parent) : QObject(parent)
{

}

void FileReader::readFile(const int fileIndex)
{
    QString filename = QStringLiteral(":/files/s%1.txt").arg(fileIndex);
    QFile file(filename);
    if(!file.exists()) {
        qDebug() << "File does not exists";
        return;
    }
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "File failed to open in read mode";
    }
    m_points.clear();
    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        int num = line.toInt();
        m_points.append(num);
    }
    file.close();
}

int FileReader::getPoints()
{
    qDebug()<<("getPoints:");
    return m_points.size();
}

int FileReader::getX(int index)
{
    qDebug()<<("getX:");
    return m_points.at(index);
}

int FileReader::getY(int index)
{
    qDebug()<<("getY:");
    return m_points.at(index);
}
