#ifndef IMGRECEIVER_H
#define IMGRECEIVER_H

#include <QObject>

class ImgReceiver : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)

    explicit ImgReceiver(QObject *parent = nullptr);

    virtual QPixmap getCurrentImage()=0;
    virtual int width();
    virtual int height();


public slots:
    void processImage();

signals:
    void imageReady();
    void widthChanged();
    void heightChanged();

protected:
    int m_width;
    int m_height;

};

#endif // IMGRECEIVER_H
