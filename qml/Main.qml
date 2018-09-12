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

    property real margin: units.gu(2)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('xkcd Viewer')
        }

    	Row {
		id: buttons
		spacing: margin

		anchors {
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}

		Button {
			id: prevComicBtn
			text: "<"
		}

		Button {
			id: randomComicBtn
			text: i18n.tr("Random")
		}

		Button {
			id: altTextBtn
			text: i18n.tr("Title Text")
		}

		Button {
			id: explainBtn
			text: i18n.tr("Explain")
		}

		Button {
			id: nextComicBtn
			text: ">"
		}
	}
    }

}
