#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "xkcdviewer.h"

void XkcdviewerPlugin::registerTypes(const char *uri) {
    //@uri Xkcdviewer
    qmlRegisterSingletonType<Xkcdviewer>(uri, 1, 0, "Xkcdviewer", [](QQmlEngine*, QJSEngine*) -> QObject* { return new Xkcdviewer; });
}
