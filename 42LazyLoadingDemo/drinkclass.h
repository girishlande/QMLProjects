#ifndef DRINKCLASS_H
#define DRINKCLASS_H

#include <qobject.h>

class DrinkClass : public QObject
{
    Q_OBJECT
public:
    explicit DrinkClass(QObject *parent = nullptr);
    Q_INVOKABLE void func();
    ~DrinkClass();

signals:

};

#endif // DRINKCLASS_H
