#ifndef QQUICKCUSTOMITEM_H
#define QQUICKCUSTOMITEM_H

#include <QQuickItem>

class QQuickCustomItem : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
public:
    QQuickCustomItem(QQuickItem *parent = Q_NULLPTR);

protected:
    QSGNode *updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *updatePaintNodeData);
    //void paint(QPainter *painter);

    QColor color() const;
    void setColor(const QColor &color);

    virtual void mousePressEvent(QMouseEvent *event);
    virtual void mouseMoveEvent(QMouseEvent *event);
    virtual void mouseReleaseEvent(QMouseEvent *event);
    virtual void mouseDoubleClickEvent(QMouseEvent *event);
    virtual void mouseUngrabEvent(); // XXX todo - params?

private:
    QColor m_color;
    bool m_needUpdate;

signals:
    void colorChanged();
};

#endif // QQUICKCUSTOMITEM_H
