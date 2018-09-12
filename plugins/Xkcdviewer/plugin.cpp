//Copyright (C) 2018  Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

//This program is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation (version 3) with the exception that
//linking the OpenSSL library is allowed.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "xkcdviewer.h"

void XkcdviewerPlugin::registerTypes(const char *uri) {
    //@uri Xkcdviewer
    qmlRegisterSingletonType<Xkcdviewer>(uri, 1, 0, "Xkcdviewer", [](QQmlEngine*, QJSEngine*) -> QObject* { return new Xkcdviewer; });
}
