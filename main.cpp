#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QtQml>
#include <QJSEngine>
#include "saturnpos.h"

Q_DECLARE_METATYPE(QModelIndex)

static QObject* qmlSingletonCallBack(QQmlEngine *engine, QJSEngine *scriptEngine);

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    SaturnPOS* pos = SaturnPOS::createInstance();

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType<SaturnPOS>("com.saturnpos",1,0,"SaturnPOS",qmlSingletonCallBack);

    engine.load(QUrl(QStringLiteral("src/qml/main.qml")));

    return app.exec();
}

QObject* qmlSingletonCallBack(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    SaturnPOS* sp = SaturnPOS::Instance();
    QQmlEngine::setObjectOwnership(sp, QQmlEngine::CppOwnership);

    return sp;
}

