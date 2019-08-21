#include "PopupManager.h"
#include "MsgModel.h"

void PopupManager::showAlert(const QString& text, IMsgModel::Type type)
{
    MsgModelPtr alert(new MsgModel(text,type));

    m_msglist.append(alert);
    connect(alert.data(), &MsgModel::alertClosed, this, &PopupManager::handleAlertClosed);

    switch (type) {
    case IMsgModel::InfoMsg:
        emit showInfo(alert.data());
        break;
    case IMsgModel::ErrorMsg:
        emit showError(alert.data());
        break;
    case IMsgModel::WarningMsg:
        emit showWarning(alert.data());
        break;
    }
}

void PopupManager::show(QString msg)
{
    showAlert(msg, IMsgModel::InfoMsg);
}

void PopupManager::handleAlertClosed()
{
    auto alertModel = QObject::sender();
    for (auto it = m_msglist.begin(); it != m_msglist.end(); ++it) {
        if (it->data() == alertModel) {
            m_msglist.erase(it);
            break;
        }
    }
}
