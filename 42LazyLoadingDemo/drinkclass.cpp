#include "drinkclass.h"
#include <qdebug.h>

DrinkClass::DrinkClass(QObject *parent) : QObject(parent)
{
qDebug() << "DrinkClass constructor called!";
}

void DrinkClass::func()
{
qDebug() << "DrinkClass func called!";
}

DrinkClass::~DrinkClass()
{
    qDebug() << "DrinkClass destructor called!";
}
