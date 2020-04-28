#include "diskfilemodel.h"
#include "qfile.h"
#include "qtextstream.h"

DiskFileModel::DiskFileModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int DiskFileModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_list.count();
    // FIXME: Implement me!
}

QVariant DiskFileModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_list.size()) {
        return QVariant();
    }

    QString s = m_list.at(index.row());

    switch (role) {
    case titleRole: return QVariant::fromValue(s);
    case nameRole: return QVariant::fromValue(s);
    }

    // FIXME: Implement me!
    return QVariant();
}

void DiskFileModel::readFile(QString &fileName)
{
    QFile inputFile(fileName);
    if (inputFile.open(QIODevice::ReadOnly))
    {
        QTextStream in(&inputFile);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            m_list.append(line);
        }
        inputFile.close();
    }
}

QHash<int,QByteArray> DiskFileModel::roleNames() const {
    return {
        { titleRole, "title" },
        { nameRole, "name" }
    };
}

