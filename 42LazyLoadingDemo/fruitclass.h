#ifndef FRUITCLASS_H
#define FRUITCLASS_H

#include <QObject>

class FruitClass : public QObject
{
    Q_OBJECT
public:
    explicit FruitClass(QObject *parent = nullptr);
    Q_INVOKABLE void func();
    ~FruitClass();

signals:

};

#endif // FRUITCLASS_H
