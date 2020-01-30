#include "ExamplePlugin.h"
#include "PatientProvider.h"
#include "Patient.h"

#include <qqml.h>

void ExamplePlugin::registerTypes(const char *uri)
{
    qmlRegisterSingletonType<PatientProvider>(uri, 1, 0, "PatientProvider", &PatientProvider::instance);
}

