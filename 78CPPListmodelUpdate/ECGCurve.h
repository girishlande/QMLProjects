#ifndef ECGCurve_H
#define ECGCurve_H

#include <QObject>

class ECGCurve : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString curvecolor READ curvecolor WRITE setCurvecolor NOTIFY curvecolorChanged)
    Q_PROPERTY(bool curvevisible READ curvevisible WRITE setCurvevisible NOTIFY curvevisibleChanged)

public:
    explicit ECGCurve(QObject *parent = nullptr);
    ECGCurve(QString name,int id,QString color,bool visible);

    int id();
    void setId(const int r);

    QString name();
    void setName(const QString name);

    QString curvecolor();
    void setCurvecolor(const QString color);

    bool curvevisible();
    void setCurvevisible(bool visible);

    Q_INVOKABLE void print();

signals:
    void nameChanged();
    void idChanged();
    void curvecolorChanged();
    void curvevisibleChanged();

public slots:

private:
    QString m_name;
    int m_id;
    QString m_color;
    bool m_visible;
};

#endif // ECGCurve_H
