#ifndef POINTGENERATOR_H
#define POINTGENERATOR_H

#include <QObject>

class PointGenerator : public QObject
{
    Q_OBJECT
public:
    explicit PointGenerator(QObject *parent = nullptr);
    Q_PROPERTY(int ivalue READ ivalue WRITE setIvalue NOTIFY ivalueChanged)
    Q_PROPERTY(int pid READ pid WRITE setPid NOTIFY pidChanged)

    int ivalue();
    void setIvalue(int i);

    int pid();
    void setPid(int id);

    Q_INVOKABLE void init();

public slots:
    void errorString(QString error);
    void processed(int i);

signals:
    void ivalueChanged();
    void pidChanged();

private:
    int m_value=0;
    int m_id = 1;

};

#endif // POINTGENERATOR_H
