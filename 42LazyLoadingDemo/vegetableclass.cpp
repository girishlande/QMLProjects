#include "vegetableclass.h"
#include <qdebug.h>

VegetableClass::VegetableClass(QObject *parent) : QObject(parent)
{
qDebug() << "VegetableClass constructor called!";
}

void VegetableClass::func()
{
    qDebug() << "Vegetable func called!";
}

VegetableClass::~VegetableClass()
{
qDebug() << "VegetableClass destructor called!";
}
