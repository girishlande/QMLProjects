#ifndef STUDENTDATA_H
#define STUDENTDATA_H

#include <QObject>

class StudentData : public QObject
{
    Q_OBJECT
public:
    explicit StudentData(QObject *parent = nullptr);
    ~StudentData();

    int roll() const;
    void setRoll(int roll);

    QString name() const;
    void setName(const QString &name);

signals:
    void rollchanged();
    void nameChanged();

private:
    int m_roll = 0;
    QString m_name = "";
};

#endif // STUDENTDATA_H
