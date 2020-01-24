#ifndef STUDENT_PLUGIN_H
#define STUDENT_PLUGIN_H

#include <QQmlExtensionPlugin>

class StudentPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // STUDENT_PLUGIN_H
