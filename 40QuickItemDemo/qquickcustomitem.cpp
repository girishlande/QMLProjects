#include "qquickcustomitem.h"

#include <qpainter.h>
#include <qpainterpath.h>
#include <QSGGeometryNode>
#include <QSGFlatColorMaterial>


QQuickCustomItem::QQuickCustomItem(QQuickItem *parent) :
    QQuickItem(parent),
    m_color(Qt::red),
    m_needUpdate(true)
{
    setFlag(QQuickItem::ItemHasContents);
    setFiltersChildMouseEvents(true);
    setAcceptedMouseButtons(Qt::AllButtons);
}


QSGNode *QQuickCustomItem::updatePaintNode(QSGNode *oldNode, QQuickItem::UpdatePaintNodeData *updatePaintNodeData)
{
    Q_UNUSED(updatePaintNodeData)
    QSGGeometryNode *root = static_cast<QSGGeometryNode *>(oldNode);

    if(!root) {
        root = new QSGGeometryNode;
        QSGGeometry *geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 3);
        geometry->setDrawingMode(GL_TRIANGLE_FAN);
        geometry->vertexDataAsPoint2D()[0].set(width() / 2, 0);
        geometry->vertexDataAsPoint2D()[1].set(width(), height());
        geometry->vertexDataAsPoint2D()[2].set(0, height());

        root->setGeometry(geometry);
        root->setFlag(QSGNode::OwnsGeometry);
        root->setFlag(QSGNode::OwnsMaterial);
    }

    if(m_needUpdate) {
        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(m_color);
        root->setMaterial(material);
        m_needUpdate = false;
    }

    return root;
}


QColor QQuickCustomItem::color() const
{
    return m_color;
}

void QQuickCustomItem::setColor(const QColor &color)
{
    if(m_color != color) {
        m_color = color;
        m_needUpdate = true;
        update();
        colorChanged();
    }
}

void QQuickCustomItem::mousePressEvent(QMouseEvent *event)
{
    qDebug() << " Girish: Q Quick Item mouse pressed!";
}

void QQuickCustomItem::mouseMoveEvent(QMouseEvent *event)
{
    qDebug() << " Girish: Q Quick Item mouse move!";
}

void QQuickCustomItem::mouseReleaseEvent(QMouseEvent *event)
{
    qDebug() << " Girish: Q Quick Item mouse released!";
}

void QQuickCustomItem::mouseDoubleClickEvent(QMouseEvent *event)
{
    qDebug() << " Girish: Q Quick Item mouse double clicked!";
}

void QQuickCustomItem::mouseUngrabEvent()
{
    qDebug() << " Girish: Q Quick Item mouse ungrab!";
}

//void QQuickCustomItem::paint(QPainter *painter)
//{
//    QPainterPath path;
//    path.moveTo(width() / 2, 0);
//    path.lineTo(width(), height());
//    path.lineTo(0, height());
//    path.lineTo(width() / 2, 0);
//    painter->fillPath(path, m_color);
//}
