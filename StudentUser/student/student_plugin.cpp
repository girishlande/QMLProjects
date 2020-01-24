#include "student_plugin.h"
#include "student.h"

#include <qqml.h>

void StudentPlugin::registerTypes(const char *uri)
{
    // @uri student
    qmlRegisterType<Student>(uri, 1, 0, "Student");
}

