#pragma once

#include <QList>
#include <QObject>

#include <functional>
#include "IPopupManager.h"
#include "MsgModel.h"


class PopupManager : public QObject, public IPopupManager {
    Q_OBJECT
public:
    PopupManager() = default;
    ~PopupManager() = default;

    Q_INVOKABLE void showAlert(const QString& text, IMsgModel::Type type) override;

    Q_INVOKABLE void show(QString msg);

signals:
    void showError(MsgModel* msgModel);
    void showWarning(MsgModel* msgModel);
    void showInfo(MsgModel* msgModel);

private:
    void handleAlertClosed();
    QList<MsgModelPtr> m_msglist;
};
