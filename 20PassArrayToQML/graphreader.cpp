#include "graphreader.h"
#include "csvparser.h"

GraphReader::GraphReader(QObject *parent) : QObject(parent)
{

}

void GraphReader::buildGraph()
{
    QString filePath(":/Line_Graph.csv");
    CSVParser parser;
    parser.parseFile(filePath,m_lines);
}

int GraphReader::lineCount()
{
    return m_lines.count();
}

const QVariantList GraphReader::linePoints(int index)
{
    if(index<m_lines.count()) {
        return m_lines[index].points();
    }
    return QVariantList();
}
