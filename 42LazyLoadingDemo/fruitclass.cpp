#include "fruitclass.h"
#include <qdebug.h>

FruitClass::FruitClass(QObject *parent) : QObject(parent)
{
qDebug() << "FruitClass constructor called!";
}

void FruitClass::func()
{
    qDebug() << "FruitClass func called!";
}

FruitClass::~FruitClass()
{
 qDebug() << "FruitClass destructor called!";
}
