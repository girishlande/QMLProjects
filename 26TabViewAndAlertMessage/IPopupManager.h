#pragma once

#include "IMsgModel.h"
#include <qstring.h>

class IPopupManager {
public:
    virtual void showAlert(const QString& text, IMsgModel::Type type) = 0;

};
