#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQuickView>
#include <QObject>
#include <QQuickItem>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("src/qml/main.qml")));

    return app.exec();
}

