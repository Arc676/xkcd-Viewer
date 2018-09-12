#ifndef XKCDVIEWER_H
#define XKCDVIEWER_H

#include <QObject>

class Xkcdviewer: public QObject {
    Q_OBJECT

public:
    Xkcdviewer();
    ~Xkcdviewer() = default;

    Q_INVOKABLE void speak();
};

#endif
