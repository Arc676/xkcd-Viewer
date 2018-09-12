import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Xkcdviewer 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'xkcd_viewer.arc676'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('xkcd Viewer')
        }

        Label {
            anchors.centerIn: parent
            text: i18n.tr('Hello World!')
        }
    }

    Component.onCompleted: Xkcdviewer.speak()
}
