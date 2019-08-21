#pragma once

#include "IMsgModel.h"
#include <QObject>
#include <QSharedPointer>

class MsgModel : public QObject, IMsgModel {
    Q_OBJECT
    Q_PROPERTY(QString text MEMBER m_text NOTIFY textChanged)
    Q_PROPERTY(Type type MEMBER m_type NOTIFY typeChanged)

public:
    Q_ENUM(Type)

    MsgModel(const QString& text, Type type)
        : m_text(text)
        , m_type(type) {
    }

    QString getText() const 
    {
        return m_text;
    }

signals:
    void alertClosed();
    void textChanged();
    void typeChanged();

private:
    QString m_text;
    Type m_type = ErrorMsg;
};

using MsgModelPtr = QSharedPointer<MsgModel>;
