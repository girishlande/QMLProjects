#ifndef VEGETABLECLASS_H
#define VEGETABLECLASS_H

#include <QObject>

class VegetableClass : public QObject
{
    Q_OBJECT
public:
    explicit VegetableClass(QObject *parent = nullptr);
    Q_INVOKABLE void func();
    ~VegetableClass();

signals:

};

#endif // VEGETABLECLASS_H
