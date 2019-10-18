#include "filehandler.h"
#include "QFile"
#include "QIODevice"
#include "QTextStream"
#include "qdebug.h"

FileHandler::FileHandler(QObject *parent) : QObject(parent)
{

}

void FileHandler::readFile(
        QString &fileName,
        QStringList& list
        )
{

    QFile inputFile(fileName);
    if (inputFile.open(QIODevice::ReadOnly))
    {
        QTextStream in(&inputFile);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            list.append(line);
        }
        inputFile.close();
    }

}

void FileHandler::writeFile(QString &fileName)
{
    int counter=1;
    int c = 1;
    int maxTimes = 10;
    int maxLines = 10000;
    QFile file( fileName );
    if ( file.open(QIODevice::ReadWrite) )
    {
        QTextStream stream( &file );
        while(c<maxTimes) {
            counter = 0;
            while(counter<maxLines) {
                stream << counter++ << " All work and no play makes Jack a dull bo is a proverb. It means that without time off from work, a person becomes both bored and boring" << endl;
            }
            c++;
        }
    }
    file.close();
}
